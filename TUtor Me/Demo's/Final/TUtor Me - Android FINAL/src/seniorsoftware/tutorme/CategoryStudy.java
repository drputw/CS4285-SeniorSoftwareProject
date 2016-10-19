package seniorsoftware.tutorme;

import generics.SeparatedListAdapter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.CategoryStudyQuery;
import android.app.Activity;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class CategoryStudy extends ListActivity {  
    
    public final static String ITEM_TITLE = "title";  
    public final static String ITEM_CAPTION = "caption";
    
    public String[] general = new String[] {"All", "Organizer Name", "Recently Added"};
    public static ArrayList<String> subjects = null;
  
    private static Runnable viewCategory = null;
	private static boolean loaded = false;
	
	private ProgressDialog m_ProgressDialog = null;
	private SeparatedListAdapter adapter = null;
	
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
	        adapter.addSection("Subjects", new ArrayAdapter<String>(this,  
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
						CategoryStudyQuery sq = new CategoryStudyQuery();
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
			m_ProgressDialog = ProgressDialog.show(CategoryStudy.this, "Please wait...", "Retrieving data", true);
    }
    
    public void onResume()
    {
    	super.onResume();
    	HomePage hp = (HomePage) this.getParent();
    	hp.changeTitle("Event Categories");
    }

	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);
		Object o = this.getListAdapter().getItem(position);
		HomePage ParentActivity;
        ParentActivity = (HomePage) this.getParent();
        HomePage.filter = o.toString();
        ParentActivity.setEventTab();
	}
	
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.study_menu, menu);
        return true;
    }
	
	public boolean onOptionsItemSelected(MenuItem item)
	{
		if(item.getTitle().equals("Create Event"))
		{
			final Intent i = new Intent().setClass(this, CreateStudyEvent.class);
			startActivity(i);
		}
		if(item.getTitle().equals("Search"))
		{
			InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
			inputMgr.toggleSoftInput(0, 0);
		}
		return true;
	}
}