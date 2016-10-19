package seniorsoftware.tutorme;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.InsertQuery;
import generics.DateObject;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;
import android.widget.Toast;

public class EventDetails extends Activity
{
	boolean clicked = false;
	static boolean checkit = false;
	int rsvpCount, id;
	String[] dateParsed;
	String date, dateUnparsed, endTime, startTime;
	Activity act = this;

	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.event_detail);

		TextView tvEventName = (TextView) findViewById(R.id.tvEventName);
		TextView tvCourseName = (TextView) findViewById(R.id.tvCourseName);
		TextView tvCourseNumber = (TextView) findViewById(R.id.tvCourseNumber);
		TextView tvOrganizer = (TextView) findViewById(R.id.tvOrganizer);
		TextView tvCourseMajor = (TextView) findViewById(R.id.tvCourseMajor);
		TextView tvDateStart = (TextView) findViewById(R.id.tvDateStart);
		TextView tvDateEnd = (TextView) findViewById(R.id.tvDateEnd);
		TextView tvLoc = (TextView) findViewById(R.id.tvLoc);
		TextView tvAttending = (TextView) findViewById(R.id.tvAttending);
		TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
		TextView tvPhone = (TextView) findViewById(R.id.tvPhone);
		TextView tvDescription = (TextView) findViewById(R.id.tvDescription);

		DateObject start = new DateObject(getIntent().getExtras().get("dateStart").toString());
		DateObject end = new DateObject(getIntent().getExtras().get("dateEnd").toString());
		
		rsvpCount = Integer.parseInt(getIntent().getExtras().get("rsvp").toString());
		id = Integer.parseInt(getIntent().getExtras().get("id").toString());
		tvEventName.setText(getIntent().getExtras().get("eventName").toString());
		
		if(getIntent().getExtras().get("courseName").toString().length() < 3)
			tvCourseName.setText("-");
        else
        	tvCourseName.setText(getIntent().getExtras().get("courseName").toString());
		
		if(getIntent().getExtras().get("courseNumber").toString().length() < 3)
			tvCourseNumber.setText("-");
        else
        	tvCourseNumber.setText(getIntent().getExtras().get("courseNumber").toString());
		
		tvDescription.setText(getIntent().getExtras().get("details").toString());
		tvCourseMajor.setText(getIntent().getExtras().get("subject").toString());
		tvOrganizer.setText(getIntent().getExtras().get("organizer").toString());
		tvDateStart.setText(start.getFullDate()); 
		tvDateEnd.setText(end.getFullDate());
		tvLoc.setText(getIntent().getExtras().get("location").toString());
		tvEmail.setText(getIntent().getExtras().get("email").toString());
		tvPhone.setText(getIntent().getExtras().get("phone").toString());
		tvAttending.setText(rsvpCount + " RSVP'd");
		tvEventName.bringToFront();

		final CheckBox cbAttending = (CheckBox) findViewById(R.id.cbAttending);
		cbAttending.setChecked(checkit);
		
		cbAttending.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				countRSVP(cbAttending.isChecked());
			}
		});

		Button callButton = (Button) findViewById(R.id.event_detail_call);
		callButton.setEnabled(getIntent().getExtras().get("phone").toString().length() > 6);
		Button emailButton = (Button) findViewById(R.id.event_detail_email);
		emailButton.setEnabled(getIntent().getExtras().get("email").toString().length() > 6);
	}

	public void countRSVP(boolean checked) {
		TextView tvAttending = (TextView) findViewById(R.id.tvAttending);
		String query;
		if(checked)
		{
			rsvpCount++;
			query = "INSERT INTO tm_RSVP (event_ID, user_ID) " +
					"VALUES (" + id + "," + HomePage.userID +  ")";
			Toast.makeText(getApplicationContext(), "You are now RSVP'd for this event", Toast.LENGTH_SHORT).show();
		}
		else
		{
			rsvpCount--;
			query = "DELETE FROM trinity2011team1.tm_RSVP " +
					"WHERE event_id = " + id + " AND user_id  = " + HomePage.userID;
			Toast.makeText(getApplicationContext(), "You are no longer RSVP'd for this event", Toast.LENGTH_SHORT).show();
		}
		eventQuery(query);
		tvAttending.setText(rsvpCount + " RSVP'd");
	}
	
	public void eventQuery(final String query)
	{
		Runnable runnable = new Runnable()
		{
			public void run()
			{
				try {
					System.out.println("Started createStudy thread");
					InsertQuery sq = new InsertQuery();
					sq.getInfo(query, "", act, null);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (ParserConfigurationException e) {
					e.printStackTrace();
				} catch (SAXException e) {
					e.printStackTrace();
				}
			}
		};

		System.out.println(query);
		Thread thread = new Thread(null, runnable, "Background");
		thread.start();
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

	public void Email(View view)
	{
		TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
		final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);

		emailIntent.setType("plain/text");
		emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{tvEmail.getText().toString()});
		emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "Study Event Inquiry");

		/* Send it off to the Activity-Chooser */
		startActivity(Intent.createChooser(emailIntent, "Send mail..."));   
	}

	public void onBackPressed()
	{
		Study.reload = false;
		super.onBackPressed();
	}
}