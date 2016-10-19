package seniorsoftware.tutorme;

import genericobjects.StudyObject;

import java.util.ArrayList;

import android.app.ListActivity;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;

public class FallCalendar extends ListActivity 
{
	private ArrayList<String> fall;
    @Override
	public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        
        fall = new ArrayList<String>();
        addContent();
        
        setListAdapter(new SpecialAdapter(this,
                android.R.layout.simple_list_item_1, fall));
        getListView().setTextFilterEnabled(true);
    }
    
    private void addContent()
    {
    	fall.add("15-19\n\nFaculty Orientation");
    	fall.add("18\n\nNew undergraduate student orientation begins");
    	fall.add("18\n\nNew Student Move-in Day");
    	fall.add("20\n\nResidence halls open for sophomores");
    	fall.add("21\n\nResidence halls open for juniors/seniors");
    }
    
    public class SpecialAdapter extends ArrayAdapter<String> {    	
    	private int[] colors = new int[] { 0x30ffffff, 0x30808080 };    
    	    
//    	    private ArrayList<StudyObject> study;
    	    
    	    public SpecialAdapter(Context context, int textViewResourceId, ArrayList<String> items) {
    	    	super(context, textViewResourceId, items);
//                this.study = items;
    	
    	    }
    	    
    	    @Override
    	    public View getView(int position, View convertView, ViewGroup parent) {
    	  	  View view = super.getView(position, convertView, parent);
    	  	  int colorPos = position % colors.length;
    	  	  view.setBackgroundColor(colors[colorPos]);
    	  	  return view;
    	  	}
    }
}