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

public class SpringCalendar extends ListActivity 
{
	private ArrayList<String> spring;
	private String[] arr_spring = {
		"January",
		"2\n\nFirst day to apply for a degree at Winter Commencement",
		"8\n\nResidence halls reopen at noon",
		"8-10\n\nNew Student Orientation",
		"10\n\nRegistration for Spring semester (see Spring Class Schedule for registration information)",
		"10\n\nAdd/Drop and late registration begin",
		"11\n\nBeginning of classes: 8:30 a.m.",
		"16\n\nMartin Luther King, Jr., Day; University holiday; offices closed; no classes",
		"19\n\nAdd/Drop ends and last day to register",
		"Feburary",
		"1\n\nLast day to change Pass/Fail",
		"March",
		"10-18\n\nSpring break; no classes",
		"13\n\nMid-semester grades due: 5:00 p.m.",
		"13\n\nLast day a graduate student may withdraw from a course without approval",
		"22\n\nLast day an undergraduate student may withdraw from a course with a “W”",
		"30-31\n\nSpring Family Weekend",
		"April",
		"1\n\nSpring Family Weekend",
		"6\n\nGood Friday; University holiday; offices closed; no classes",
		"9-20\n\nRegistration of currently enrolled students for Summer and Fall semesters, 2011",
		"20\n\nLast day for graduate degree candidates to submit theses or projects to Academic Affairs (Spring Commencement)",
		"20\n\nHonors theses due in Office of Academic Affairs for May degree candidates",
		"30\n\nLast day to apply for a degree at Winter Commencement",
		"30\n\nReading Days",
		"May",
		"2-8\n\nFinal examinations (begin on May 2: 8:30 a.m.)",
		"9\n\nResidence halls close at noon, May 9, except for graduating seniors who may remain until noon, May 13",
		"10\n\nGrades due for graduating seniors: noon",
		"12\n\nSpring Commencement: Graduate Commencement, 9:00 a.m.; Undergraduate Commencement, 10:30 a.m.",
		"14\n\nSpring semester grades due: 5:00 p.m"
	};
	
    @Override
	public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        
        spring = new ArrayList<String>();
        addContent();
        
        setListAdapter(new SpecialAdapter(this,
                android.R.layout.simple_list_item_1, spring));
        getListView().setTextFilterEnabled(true);
    }
    
    private void addContent()
    {
    	for(int i = 0; i < arr_spring.length; i++)
    	{
    		spring.add(arr_spring[i]);
    	}
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