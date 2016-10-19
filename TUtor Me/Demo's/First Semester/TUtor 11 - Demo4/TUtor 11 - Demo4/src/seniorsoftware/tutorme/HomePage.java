package seniorsoftware.tutorme;

import android.app.TabActivity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.widget.TabHost;
import android.widget.Toast;

public class HomePage extends TabActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

//        ActionBar actionBar = getActionBar();
//   	 actionBar.hide();
   	 
        mainView();
        TabHost tabHost = getTabHost();
        tabHost.setCurrentTab(0);
    }
    
    public void mainView() {
    	Resources res = getResources(); // Resource object to get Drawables
        TabHost tabHost = getTabHost();  // The activity TabHost
        TabHost.TabSpec spec;  // Resusable TabSpec for each tab
        Intent intent;  // Reusable Intent for each tab

        tabHost.clearAllTabs();
        // Create an Intent to launch an Activity for the tab (to be reused)
        intent = new Intent().setClass(this, CategoryTutors.class);

        // Initialize a TabSpec for each tab and add it to the TabHost
        spec = tabHost.newTabSpec("tutors").setIndicator("Tutors",
                          res.getDrawable(R.drawable.tutor))
                      .setContent(intent);
        tabHost.addTab(spec);

        // Do the same for the other tabs
        intent = new Intent().setClass(this, Study.class);
        spec = tabHost.newTabSpec("study").setIndicator("Study",
                          res.getDrawable(R.drawable.study))
                      .setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, Info.class);
        spec = tabHost.newTabSpec("info").setIndicator("Info",
                          res.getDrawable(R.drawable.info))
                      .setContent(intent);
        tabHost.addTab(spec);
        
        intent = new Intent().setClass(this, Settings.class);
        spec = tabHost.newTabSpec("settings").setIndicator("Account",
                          res.getDrawable(R.drawable.settings))
                      .setContent(intent);
        tabHost.addTab(spec);
	}

	public void setTutorTab()
    {
		Resources res = getResources(); // Resource object to get Drawables
        TabHost tabHost = getTabHost();  // The activity TabHost
        TabHost.TabSpec spec;  // Resusable TabSpec for each tab
        Intent intent;  // Reusable Intent for each tab

        tabHost.clearAllTabs();
        // Create an Intent to launch an Activity for the tab (to be reused)
        intent = new Intent().setClass(this, Tutors.class);

        // Initialize a TabSpec for each tab and add it to the TabHost
        spec = tabHost.newTabSpec("tutors").setIndicator("Tutors",
                          res.getDrawable(R.drawable.tutor))
                      .setContent(intent);
        tabHost.addTab(spec);

        // Do the same for the other tabs
        intent = new Intent().setClass(this, CategoryStudy.class);
        spec = tabHost.newTabSpec("study").setIndicator("Study",
                          res.getDrawable(R.drawable.study))
                      .setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, Info.class);
        spec = tabHost.newTabSpec("info").setIndicator("Info",
                          res.getDrawable(R.drawable.info))
                      .setContent(intent);
        tabHost.addTab(spec);
        
        intent = new Intent().setClass(this, Settings.class);
        spec = tabHost.newTabSpec("settings").setIndicator("Account",
                          res.getDrawable(R.drawable.settings))
                      .setContent(intent);
        tabHost.addTab(spec);
        tabHost.setCurrentTab(0);
    }
	
	public void setEventTab()
    {
		Resources res = getResources(); // Resource object to get Drawables
        TabHost tabHost = getTabHost();  // The activity TabHost
        TabHost.TabSpec spec;  // Resusable TabSpec for each tab
        Intent intent;  // Reusable Intent for each tab

        tabHost.clearAllTabs();
        // Create an Intent to launch an Activity for the tab (to be reused)
        intent = new Intent().setClass(this, CategoryTutors.class);

        // Initialize a TabSpec for each tab and add it to the TabHost
        spec = tabHost.newTabSpec("tutors").setIndicator("Tutors",
                          res.getDrawable(R.drawable.tutor))
                      .setContent(intent);
        tabHost.addTab(spec);

        // Do the same for the other tabs
        intent = new Intent().setClass(this, CategoryStudy.class);
        spec = tabHost.newTabSpec("study").setIndicator("Study",
                          res.getDrawable(R.drawable.study))
                      .setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, Info.class);
        spec = tabHost.newTabSpec("info").setIndicator("Info",
                          res.getDrawable(R.drawable.info))
                      .setContent(intent);
        tabHost.addTab(spec);
        
        intent = new Intent().setClass(this, Settings.class);
        spec = tabHost.newTabSpec("settings").setIndicator("Account",
                          res.getDrawable(R.drawable.settings))
                      .setContent(intent);
        tabHost.addTab(spec);
		Toast.makeText(getApplicationContext(), "SET TAB", Toast.LENGTH_SHORT).show();
    }
}