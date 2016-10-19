package seniorsoftware.tutorme;

import android.app.TabActivity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.widget.TabHost;

public class HomePage extends TabActivity {
    /** Called when the activity is first created. */
	
	Intent categoryTutorsIntent;
	Intent categoryEventsIntent;
	Intent tutorIntent;
	Intent eventIntent;
	Intent infoIntent;
	Intent settingsIntent;
	
	public static String userID = "3";
	public static String filter = "All";
    
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        categoryTutorsIntent = new Intent().setClass(this, CategoryTutors.class);
        categoryEventsIntent = new Intent().setClass(this, CategoryStudy.class);
    	tutorIntent = new Intent().setClass(this, Tutors.class);
    	eventIntent = new Intent().setClass(this, Study.class);
    	infoIntent = new Intent().setClass(this, Info.class);
    	settingsIntent = new Intent().setClass(this, Settings.class);
    	
        mainView();
    }

    public void mainView() {
    	Resources res = getResources(); // Resource object to get Drawables
        TabHost tabHost = getTabHost();  // The activity TabHost
        TabHost.TabSpec spec;  // Resusable TabSpec for each tab

        tabHost.setCurrentTab(0);
        tabHost.clearAllTabs();
        
        spec = tabHost.newTabSpec("tutors").setIndicator("Tutors",
                          res.getDrawable(R.drawable.tutor)).setContent(categoryTutorsIntent);
        tabHost.addTab(spec);

        spec = tabHost.newTabSpec("study").setIndicator("Events",
                          res.getDrawable(R.drawable.study)).setContent(categoryEventsIntent);
        tabHost.addTab(spec);

        spec = tabHost.newTabSpec("info").setIndicator("Info",
                          res.getDrawable(R.drawable.info)).setContent(infoIntent);
        tabHost.addTab(spec);
        
        spec = tabHost.newTabSpec("settings").setIndicator("Account",
                          res.getDrawable(R.drawable.settings)).setContent(settingsIntent);
        tabHost.addTab(spec);
	}

	public void setTutorTab()
    {
		Resources res = getResources(); // Resource object to get Drawables
        TabHost tabHost = getTabHost();  // The activity TabHost
        TabHost.TabSpec spec;  // Resusable TabSpec for each tab

        tabHost.setCurrentTab(0);
        tabHost.clearAllTabs();
        
        spec = tabHost.newTabSpec("tutors").setIndicator("Tutors",
                          res.getDrawable(R.drawable.tutor)).setContent(tutorIntent);
        tabHost.addTab(spec);

        spec = tabHost.newTabSpec("study").setIndicator("Events",
                          res.getDrawable(R.drawable.study)).setContent(categoryEventsIntent);
        tabHost.addTab(spec);

        spec = tabHost.newTabSpec("info").setIndicator("Info",
                          res.getDrawable(R.drawable.info)).setContent(infoIntent);
        tabHost.addTab(spec);
        
        spec = tabHost.newTabSpec("settings").setIndicator("Account",
                          res.getDrawable(R.drawable.settings)).setContent(settingsIntent);
        tabHost.addTab(spec);
    }
	
	public void setEventTab()
    {
		Resources res = getResources(); // Resource object to get Drawables
        TabHost tabHost = getTabHost();  // The activity TabHost
        TabHost.TabSpec spec;  // Resusable TabSpec for each tab

        tabHost.setCurrentTab(0);
        tabHost.clearAllTabs();
        
        spec = tabHost.newTabSpec("tutors").setIndicator("Tutors",
                          res.getDrawable(R.drawable.tutor)).setContent(categoryTutorsIntent);
        tabHost.addTab(spec);

        spec = tabHost.newTabSpec("study").setIndicator("Events",
                          res.getDrawable(R.drawable.study)).setContent(eventIntent);
        tabHost.addTab(spec);

        spec = tabHost.newTabSpec("info").setIndicator("Info",
                          res.getDrawable(R.drawable.info)).setContent(infoIntent);
        tabHost.addTab(spec);
        
        spec = tabHost.newTabSpec("settings").setIndicator("Account",
                          res.getDrawable(R.drawable.settings)).setContent(settingsIntent);
        tabHost.addTab(spec);
        tabHost.setCurrentTab(1);
    }
	
	public void changeTitle(String title)
    {
    	setTitle(title);
    }
}