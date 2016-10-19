package seniorsoftware.tutorme;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class EventDetails extends Activity{


	boolean clicked = false;
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.event_detail);


		TextView tvClassName = (TextView) findViewById(R.id.tvName);
		TextView tvCourse = (TextView) findViewById(R.id.tvCourse);
		TextView tvOrganizer = (TextView) findViewById(R.id.tvOrganizer);
		TextView tvSubj = (TextView) findViewById(R.id.tvSubject);
		TextView tvDate = (TextView) findViewById(R.id.tvDate);
		TextView tvTime = (TextView) findViewById(R.id.tvTime);
		TextView tvLoc = (TextView) findViewById(R.id.tvLoc);
		Button btnRSVP = (Button) findViewById(R.id.btnRSVP);
		//	DatePicker dpDate = (DatePicker) findViewById(R.id.dpDate);

		String num;
		String[] subject;


		tvClassName.setText(getIntent().getExtras().get("Name").toString());
		tvCourse.setText("Course: " + getIntent().getExtras().get("Course").toString());
		subject = getIntent().getExtras().get("Course").toString().split(" ");
		tvSubj.setText("Subject: " + subject[0]);
		tvOrganizer.setText("Organizer: " + getIntent().getExtras().get("Organizer").toString());
		tvDate.setText("Date: " + getIntent().getExtras().get("month").toString() + "-" +
				getIntent().getExtras().get("day").toString() + "-" + getIntent().getExtras().get("year").toString()); 
		if(getIntent().getExtras().get("min").equals("00")) 
			tvTime.setText("Time: " + getIntent().getExtras().get("hour").toString() + ":" + getIntent().getExtras().get("min") + "0");
		else 
			tvTime.setText("Time: " + getIntent().getExtras().get("hour").toString() + ":" + getIntent().getExtras().get("min"));
		tvLoc.setText("Location: " + getIntent().getExtras().get("loc").toString());

		//tvClassName.setBackgroundColor(000000);
		tvClassName.bringToFront();

		num = btnRSVP.getText().toString();




		final String tokens[] = num.split(" ");


		btnRSVP.setOnClickListener(new View.OnClickListener() {					
			public void onClick(View view) {
				rsvpToEvent(tokens[0]);

			}


		});
	}

	private void rsvpToEvent(String str) {
		// TODO Auto-generated method stub

		if(clicked == false){
			int rsvp;
			Button btnRSVP = (Button) findViewById(R.id.btnRSVP);

			rsvp = Integer.parseInt(str);
			rsvp++;
			btnRSVP.setText(rsvp + " Attending\nYou Are RSVP'd");
			Toast.makeText(getApplicationContext(), "You Are Attending This Event", Toast.LENGTH_SHORT).show();
			clicked = true;
			//EventsAttending.getStudy().add(getIntent().getExtras().getInt("id"), null);
		}
		else {
			int rsvp;
			Button btnRSVP = (Button) findViewById(R.id.btnRSVP);

			rsvp = Integer.parseInt(str);
			btnRSVP.setText(rsvp-- + " Attending\nRSVP for this Event ");
			Toast.makeText(getApplicationContext(), "You Are No Longer Attending This Event", Toast.LENGTH_SHORT).show();
			clicked = false;
			//EventsAttending.getStudy().remove(getTaskId());
		}
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
    	emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "Study Event Inquiry");

    	/* Send it off to the Activity-Chooser */
    	startActivity(Intent.createChooser(emailIntent, "Send mail..."));
   	
    
    }

}
