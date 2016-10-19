package seniorsoftware.tutorme;

import generics.SeparatedListAdapter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.CategoryTutorsQuery;
import android.app.Activity;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class CategoryTutors extends ListActivity {  
    
    public final static String ITEM_TITLE = "title";  
    public final static String ITEM_CAPTION = "caption";
    public static String filter = "";
    
    public String[] general = new String[] {"All", "By Rank", "Recently Added"};
    public static ArrayList<String> subjects = null;
  
	private static Runnable viewCategory = null;
	private static boolean loaded = false;
	
	private ProgressDialog m_ProgressDialog = null;
	private SeparatedListAdapter adapter = null;
	
	//the runnable that gets called after the data is returned and parsed
	final Runnable returnRes = new Runnable(){

		public void run() {
			if(subjects != null && subjects.size() > 0){

				System.out.println("Updating adapter");
				System.out.println(subjects.size());
				adapter.notifyDataSetChanged();
			}
			m_ProgressDialog.dismiss();
			adapter.notifyDataSetChanged();
			loaded = true;
		}
	};
	
    public Map<String,?> createItem(String title, String caption) {  
        Map<String,String> item = new HashMap<String,String>();  
        item.put(ITEM_TITLE, title);  
        item.put(ITEM_CAPTION, caption);  
        return item;  
    }

    public void onCreate(Bundle icicle) {  
    	final String query = "SELECT * FROM tm_Major ORDER BY major Asc";
		final String args = "";
		final Activity act = this;
    	
        super.onCreate(icicle);  
    
        if(subjects == null)
        	subjects = new ArrayList<String>();
        if(adapter == null)
        {
	        adapter = new SeparatedListAdapter(this);  
	        adapter.addSection("Browse", new ArrayAdapter<String>(this,  
	            R.layout.category_list_item, general));
	        adapter.addSection("Majors & Minors", new ArrayAdapter<String>(this,  
	                R.layout.category_list_item, subjects));
        }
        setListAdapter(adapter);
        
        if(viewCategory == null)
		{
			viewCategory = new Runnable()
			{
				public void run()
				{
					try {
						System.out.println("Started viewStaff thread");
						CategoryTutorsQuery sq = new CategoryTutorsQuery();
						sq.getInfo(query, args, act, returnRes);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (ParserConfigurationException e) {
						e.printStackTrace();
					} catch (SAXException e) {
						e.printStackTrace();
					}
				}
			};
			Thread thread = new Thread(null, viewCategory, "Background");
			thread.start();
		}

		if(!loaded)
			m_ProgressDialog = ProgressDialog.show(CategoryTutors.this, "Please wait...", "Retrieving data", true);
    }
    
    public void onResume()
    {
    	super.onResume();
    	HomePage hp = (HomePage) this.getParent();
    	hp.changeTitle("Tutor Categories");
    }

	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);
		Object o = this.getListAdapter().getItem(position);
		
		HomePage ParentActivity = (HomePage) this.getParent();
        HomePage.filter = o.toString();
        ParentActivity.setTutorTab();
	}
}