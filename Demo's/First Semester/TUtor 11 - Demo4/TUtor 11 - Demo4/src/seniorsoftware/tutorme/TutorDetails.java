package seniorsoftware.tutorme;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class TutorDetails extends Activity 
{
    @Override
	public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.tutor_detail);
        
        
        TextView tvName = (TextView) findViewById(R.id.tvName);
        TextView tvRank = (TextView) findViewById(R.id.tvRank);

        tvName.setText(getIntent().getExtras().get("tutor").toString());
        tvRank.setText(getIntent().getExtras().get("year").toString());
        
        //Toast.makeText(getApplicationContext(), getIntent().getExtras().get("tutor").toString(), Toast.LENGTH_SHORT).show();
        //tvName.setBackgroundColor(0xFFFFFF);
        tvName.bringToFront();

    }
    
    public void CallTutor(View view)
    {
    	String phone_number = "5125693916";
    	Intent i = new Intent(Intent.ACTION_DIAL);
    	String p = "tel:" + phone_number;
    	i.setData(Uri.parse(p));
    	startActivity(i);
    }
    
    public void Email(View view)
    {
    	
    	 /* Create the Intent */
    	final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);

    	/* Fill it with Data */
    	emailIntent.setType("plain/text");
    	emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{"test@test.ing"});
    	emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "TutorMe Inquiry");

    	/* Send it off to the Activity-Chooser */
    	startActivity(Intent.createChooser(emailIntent, "Send mail..."));
   	
    
    }
    
}