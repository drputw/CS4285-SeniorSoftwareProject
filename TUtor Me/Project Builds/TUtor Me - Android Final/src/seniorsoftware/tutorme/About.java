package seniorsoftware.tutorme;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class About extends Activity 
{
    @Override
	public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.about);
    }
    
    public void Email(View view)
    {
    	final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);

    	emailIntent.setType("plain/text");
    	emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{"TUmobile@trinity.edu"});
    	emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "TutorMe Feedback");
    	emailIntent.putExtra(android.content.Intent.EXTRA_TEXT, "\n \n \n \n \n TUtorMe for Android Version 1.01");

    	startActivity(Intent.createChooser(emailIntent, "Send mail..."));
   	
    
    }
}