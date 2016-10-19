package seniorsoftware.tutorme;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
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
        TextView tvMajor = (TextView) findViewById(R.id.tvMajor);
        TextView tvMajor2 = (TextView) findViewById(R.id.tvMajor2);
        TextView tvMajor3 = (TextView) findViewById(R.id.tvMajor3);
        TextView tvMajor4 = (TextView) findViewById(R.id.tvMajor4);
        TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
        TextView tvPhone = (TextView) findViewById(R.id.tvPhone);
        TextView tvDescription = (TextView) findViewById(R.id.tvDescription);
        TextView tvAvailability = (TextView) findViewById(R.id.tvAvailability);

        tvName.setText(getIntent().getExtras().get("tutor").toString());
        tvRank.setText(getIntent().getExtras().get("year").toString());
        tvMajor.setText(getIntent().getExtras().get("major").toString());
        tvEmail.setText(getIntent().getExtras().get("email").toString());
        tvPhone.setText(getIntent().getExtras().get("phone").toString());
        tvDescription.setText(getIntent().getExtras().get("description").toString());
        tvAvailability.setText(getIntent().getExtras().get("availability").toString());
        
        if(getIntent().getExtras().get("major2").toString().length() < 3)
        	tvMajor2.setText("-");
        else
        	tvMajor2.setText(getIntent().getExtras().get("major2").toString());
        
        if(getIntent().getExtras().get("major3").toString().length() < 3)
        	tvMajor3.setText("-");
        else
        	tvMajor3.setText(getIntent().getExtras().get("major3").toString());
        
        if(getIntent().getExtras().get("major4").toString().length() < 3)
        	tvMajor4.setText("-");
        else
        	tvMajor4.setText(getIntent().getExtras().get("major4").toString());
        
        Button callButton = (Button) findViewById(R.id.tutor_detail_call);
        callButton.setEnabled(getIntent().getExtras().get("phone").toString().length() == 10);
        Button emailButton = (Button) findViewById(R.id.tutor_detail_email);
        emailButton.setEnabled(getIntent().getExtras().get("email").toString().length() > 6);
        
        tvName.bringToFront();
    }
    
    public void CallTutor(View view)
    {
    	TextView tvPhone = (TextView) findViewById(R.id.tvPhone);
    	String phone_number = (String) tvPhone.getText();
    	Intent i = new Intent(Intent.ACTION_DIAL);
    	String p = "tel:" + phone_number;
    	i.setData(Uri.parse(p));
    	startActivity(i);
    }
    
    public void onBackPressed()
    {
    	Tutors.reload = false;
    	super.onBackPressed();
    }
    
    public void Email(View view)
    {
    	TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
    	final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);

    	emailIntent.setType("plain/text");
    	emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{tvEmail.getText().toString()});
    	emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "TutorMe Inquiry");

    	startActivity(Intent.createChooser(emailIntent, "Send mail..."));
    }
}