package seniorsoftware.tutorme;

import generics.SeparatedListAdapter;

import java.util.HashMap;
import java.util.Map;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.ListView;
import android.widget.Toast;

public class Settings extends ListActivity {  
    
    public final static String ITEM_TITLE = "title";  
    public final static String ITEM_CAPTION = "caption";
    
    public String[] tprofile = new String[] {"Edit Profile"};
    public String[] pvisible = new String[] {"Enabled"};
    public String[] events = new String[] {"Organized Events", "Events Attending"};
    public String[] settings = new String[] {"About"};
  
    public Map<String,?> createItem(String title, String caption) {  
        Map<String,String> item = new HashMap<String,String>();  
        item.put(ITEM_TITLE, title);  
        item.put(ITEM_CAPTION, caption);  
        return item;
    }

    public void onCreate(Bundle icicle) {  
        super.onCreate(icicle);  
    
        SeparatedListAdapter adapter = new SeparatedListAdapter(this);  
        adapter.addSection("Tutor Profile", new ArrayAdapter<String>(this,
                R.layout.lcategory_list_checkbox, pvisible));
        adapter.addSection("", new ArrayAdapter<String>(this,
                R.layout.category_list_item, tprofile));
        adapter.addSection("Events", new ArrayAdapter<String>(this,
                R.layout.category_list_item, events));
        adapter.addSection("Settings", new ArrayAdapter<String>(this,  
                R.layout.category_list_item, settings));
        setListAdapter(adapter);
    }
    
    public void onResume()
    {
    	super.onResume();
    	HomePage hp = (HomePage) this.getParent();
    	hp.changeTitle("Account");
    }

	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);
		
		if(position == 3)
			startActivity(new Intent().setClass(this, EditTutor.class));
		if(position == 5)
			startActivity(new Intent().setClass(this, OrganizedEvents.class));
		if(position == 6)
			startActivity(new Intent().setClass(this, EventsAttending.class));
		if(position == 8)
			startActivity(new Intent().setClass(this, About.class));
	}
	
//	public void profileEnabling()
//	{
//		final CheckBox cbUserEnabled = (CheckBox) findViewById(R.id.cbUserEnabled);
//		cbUserEnabled.setOnCheckedChangeListener(new OnCheckedChangeListener()
//		{
//		    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked)
//		    {
//		    	Toast.makeText(getApplicationContext(), "onCheckedChanged " + cbUserEnabled.isChecked(), Toast.LENGTH_SHORT).show();
//		    }
//		});
//	}
}