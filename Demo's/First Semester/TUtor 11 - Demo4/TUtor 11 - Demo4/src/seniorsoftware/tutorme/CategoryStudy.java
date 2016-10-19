package seniorsoftware.tutorme;

import android.app.ListActivity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AbsListView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TabHost;
import android.widget.Toast;

public class CategoryStudy extends ListActivity {
	
	private SpecialAdapter category_event_adapter;
	
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        this.category_event_adapter = new SpecialAdapter(this, android.R.layout.simple_list_item_1, DATA_ARRAY);
        setListAdapter(category_event_adapter);
        getListView().setTextFilterEnabled(true);   
    }

    static final String[] DATA_ARRAY = new String[]{
    	"Most Viewed",
    	"Recently Added",
    	"Earliest Times",
    	"Biology",
    	"Computer Science",
    	"Music"
    };
    
    protected void onListItemClick(ListView l, View v, int position, long id) {
    	super.onListItemClick(l, v, position, id);
    	Object o = this.getListAdapter().getItem(position);
    	final Intent intent = new Intent().setClass(this, Tutors.class);
    	
//    	Toast.makeText(getApplicationContext(), "begin", Toast.LENGTH_SHORT).show();
    	HomePage ParentActivity;
        ParentActivity = (HomePage) this.getParent();
        ParentActivity.setEventTab();
//        ParentActivity.mainView();
//        Toast.makeText(getApplicationContext(), "" + tabhost.getCurrentTab(), Toast.LENGTH_LONG).show();
//        Toast.makeText(getApplicationContext(), "end", Toast.LENGTH_SHORT).show();
    }
    
    public class SpecialAdapter extends ArrayAdapter
    {    	
    	private int[] colors = new int[] { 0x30ffffff, 0x30808080 };
	    
	    public SpecialAdapter(Context context, int textViewResourceId, String[] items)
	    {
	    	super(context, textViewResourceId, items);
	    }
    	    
	    @Override
	    public View getView(int position, View convertView, ViewGroup parent)
	    {
			View view = super.getView(position, convertView, parent);
			int colorPos = position % colors.length;
			view.setBackgroundColor(colors[colorPos]);
			view.setLayoutParams(new AbsListView.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT, 45));
			view.setPadding(10, 0, 0, 0);
			return view;
	  	}
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.study_menu, menu);
        return true;
    }
    
    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        switch (item.getItemId())
        {
	        case R.id.createEvent:
	        	final Intent intent = new Intent().setClass(this, CreateStudyEvent.class);
	        	   try
	        	   {
				        startActivity(intent);
				   } 
	        	   catch (ActivityNotFoundException a)
	        	   {
				        	Toast.makeText(getApplicationContext(), "Activity Not Found!", Toast.LENGTH_SHORT).show();
				   }        	
	            break;
            case R.id.SearchStudy:
            	InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
            	inputMgr.toggleSoftInput(0, 0);
            	break;
        }
        return true;
    }
}