package seniorsoftware.tutorme;

import generics.MonthObject;
import generics.SeparatedListAdapter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.FallCalendarQuery;
import android.app.Activity;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

public class FallCalendar extends ListActivity {  
    
    public final static String ITEM_TITLE = "title";  
    public final static String ITEM_CAPTION = "caption";
    
    public static ArrayList<MonthObject> august = null;
    public static ArrayList<MonthObject> september = null;
    public static ArrayList<MonthObject> october = null;
    public static ArrayList<MonthObject> november = null;
    public static ArrayList<MonthObject> december = null;
  
    private static Runnable viewCalendar = null;
	private static boolean loaded = false;
	
	private ProgressDialog m_ProgressDialog = null;
	private SeparatedListAdapter adapter = null;
	
	//the runnable that gets called after the data is returned and parsed
	final Runnable returnRes = new Runnable(){

		public void run() {
			if(august != null && august.size() > 0){

				System.out.println("Updating adapter");
				System.out.println(august.size());
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
    	final String query = "SELECT * FROM CalendarFall2011";
		final String args = "";
		final Activity act = this;
    	
        super.onCreate(icicle);  
    
        if(august == null)
        {
        	august = new ArrayList<MonthObject>();
        	september = new ArrayList<MonthObject>();
        	october = new ArrayList<MonthObject>();
        	november = new ArrayList<MonthObject>();
        	december = new ArrayList<MonthObject>();
        }
        if(adapter == null)
        {
	        adapter = new SeparatedListAdapter(this);  
	        adapter.addSection("August", new FallAdapter(this,  
	            R.layout.calendar_row, august));
	        adapter.addSection("September", new FallAdapter(this,  
	                R.layout.calendar_row, september));
	        adapter.addSection("October", new FallAdapter(this,  
	                R.layout.calendar_row, october));
	        adapter.addSection("November", new FallAdapter(this,  
	                R.layout.calendar_row, november));
	        adapter.addSection("December", new FallAdapter(this,  
	                R.layout.calendar_row, december));
        }
        setListAdapter(adapter);
        
        if(viewCalendar == null)
		{
			viewCalendar = new Runnable()
			{
				public void run()
				{
					try {
						System.out.println("Started viewStaff thread");
						FallCalendarQuery sq = new FallCalendarQuery();
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
			Thread thread = new Thread(null, viewCalendar, "Background");
			thread.start();
		}

		if(!loaded)
			m_ProgressDialog = ProgressDialog.show(FallCalendar.this, "Please wait...", "Retrieving data", true);
    }
    
    private class FallAdapter extends ArrayAdapter<MonthObject>
    {
        private ArrayList<MonthObject> allDates;


        public FallAdapter(Context context, int textViewResourceId, ArrayList<MonthObject> items)
        {
            super(context, textViewResourceId, items);
            this.allDates = items;
        }
        
        @Override
        public View getView(int position, View convertView, ViewGroup parent)
        {
            View v;
            if (convertView == null) {
            	LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            	v = vi.inflate(R.layout.calendar_row, null);
            } else {
                v = convertView;
            }

            MonthObject o = allDates.get(position);
            
            if (o != null)
            {
            	TextView tt = (TextView) v.findViewById(R.id.fallCalendarDate);
                TextView bt = (TextView) v.findViewById(R.id.fallCalendarDescription);
                
                String date = o.getStartDate();
                if(!o.getEnd().equals(o.getStartDate()))
                	date = date.concat(" - " + o.getEnd());
                
                if (tt != null)
                      tt.setText(date);
                if(bt != null)
                      bt.setText(o.getDescription());
            }
            return v;
        }
    }
}