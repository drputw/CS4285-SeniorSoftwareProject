package seniorsoftware.tutorme;

import generics.SeparatedListAdapter;

import java.util.HashMap;
import java.util.Map;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class Info extends ListActivity {  
    
    public final static String ITEM_TITLE = "title";  
    public final static String ITEM_CAPTION = "caption";
    
    public String[] calendar = new String[] {"Fall 2011", "Spring 2012"};
    public String[] honorcode = new String[] {"The Code", "Philosophy and Background", "FAQ"};
  
    public Map<String,?> createItem(String title, String caption) {  
        Map<String,String> item = new HashMap<String,String>();  
        item.put(ITEM_TITLE, title);  
        item.put(ITEM_CAPTION, caption);  
        return item;  
    }

    public void onCreate(Bundle icicle) {  
        super.onCreate(icicle);
    
        SeparatedListAdapter adapter = new SeparatedListAdapter(this);  
        adapter.addSection("Academic Calendar", new ArrayAdapter<String>(this,  
            R.layout.category_list_item, calendar));
        adapter.addSection("Honor Code", new ArrayAdapter<String>(this,  
                R.layout.category_list_item, honorcode));

        setListAdapter(adapter);
    }
    
    public void onResume()
    {
    	super.onResume();
    	HomePage hp = (HomePage) this.getParent();
    	hp.changeTitle("Info");
    }

	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);

		if(position == 1)
			startActivity(new Intent().setClass(this, FallCalendar.class));
		if(position == 2)
			startActivity(new Intent().setClass(this, SpringCalendar.class));
//		if(position == 3)
//			startActivity(new Intent().setClass(this, SummerCalendar.class));
		if(position == 4)
			startActivity(new Intent().setClass(this, TheCode.class));
		if(position == 5)
			startActivity(new Intent().setClass(this, TheCodeBackground.class));
		if(position == 6)
			startActivity(new Intent().setClass(this, FAQ.class));
	}
}