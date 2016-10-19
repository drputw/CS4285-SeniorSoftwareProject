package seniorsoftware.tutorme;

import android.app.ListActivity;
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

public class CategoryTutors extends ListActivity {
	
	private SpecialAdapter category_tutor_adapter;
	
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        this.category_tutor_adapter = new SpecialAdapter(this, android.R.layout.simple_list_item_1, DATA_ARRAY);
        setListAdapter(category_tutor_adapter);
        getListView().setTextFilterEnabled(true);   
    }

	static final String[] DATA_ARRAY = new String[]{
    	"Most Viewed",
    	"Recently Added",
    	"All Tutors",
    	"Biology",
    	"Computer Science",
    	"Music"
    };
    
    protected void onListItemClick(ListView l, View v, int position, long id) {
    	super.onListItemClick(l, v, position, id);
    	Object o = this.getListAdapter().getItem(position);
    	final Intent intent = new Intent().setClass(this, Tutors.class);
    	
    	HomePage ParentActivity;
        ParentActivity = (HomePage) this.getParent();
//        Toast.makeText(getApplicationContext(), "" + ParentActivity.toString(), Toast.LENGTH_LONG).show();
        ParentActivity.setTutorTab();
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
                    ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
			view.setPadding(10, 0, 0, 0);
			return view;
	  	}
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.tutor_menu, menu);
        return true;
    }
    
    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        switch (item.getItemId())
        {
            case R.id.SearchTutor:
            	InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
            	inputMgr.toggleSoftInput(0, 0);
            	break;
        }
        return true;
    }
}