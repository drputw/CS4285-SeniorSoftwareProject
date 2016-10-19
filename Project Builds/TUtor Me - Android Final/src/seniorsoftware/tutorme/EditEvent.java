package seniorsoftware.tutorme;

import generics.DateObject;

import java.io.IOException;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.InsertQuery;
import android.app.Activity;
import android.os.Bundle;
import android.text.Editable;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.DatePicker.OnDateChangedListener;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

public class EditEvent extends Activity 
{
	Editable ClassSec;
	Editable ClassDes;
	int id;
	String eventName, courseNumber, courseName, organizer, subject, location, details;
	DateObject dateStart, dateEnd;
	static ArrayList<String> subjects;
	final Activity act = this;

	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.edit_event);		

		Button btnCreate = (Button) findViewById(R.id.btnCreate);
		Button delButton = (Button) findViewById(R.id.btnDelete);
		Button btnCancel = (Button) findViewById(R.id.btnCancel);

		btnCreate.setOnClickListener(new View.OnClickListener() {					
			public void onClick(View view) {
				updateEvent();
				Toast.makeText(getApplicationContext(), "Event Updated", Toast.LENGTH_SHORT).show();
				finish();
			}
		});

		btnCancel.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				 Toast.makeText(getApplicationContext(), "No Changes Have Been Made", Toast.LENGTH_SHORT).show();
				finish();

			}
		});
		
		delButton.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Toast.makeText(getApplicationContext(), "Event Deleted", Toast.LENGTH_SHORT).show();
				finish();
			}
		});
	}
	
	public void onResume()
	{
		super.onResume();
		
		ArrayList<String> subjects = new ArrayList<String>();
		subjects.add(0, "");
		for(String sub: CategoryTutors.subjects)
			subjects.add(sub);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, subjects);
	    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		
		final TextView tvName = (TextView) findViewById(R.id.tvName);
		final TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
		final TextView tvPhone = (TextView) findViewById(R.id.tvPhone);
		final EditText etDescription = (EditText) findViewById(R.id.etDescription);
		final DatePicker dpDate = (DatePicker) findViewById(R.id.dpDateEvent);
		final EditText etEventName = (EditText) findViewById(R.id.etEventName);
		final TimePicker tpStartTime = (TimePicker) findViewById(R.id.tpTimeStart);
		final TimePicker tpEndTime = (TimePicker) findViewById(R.id.tpTimeEnd);
		final EditText etLoc = (EditText) findViewById(R.id.etLoc);
		
		id = Integer.parseInt(getIntent().getExtras().get("id").toString());
		eventName = getIntent().getExtras().get("eventName").toString();
		courseName = getIntent().getExtras().get("courseName").toString();
		subject = getIntent().getExtras().get("subject").toString();
		courseNumber = getIntent().getExtras().get("courseNumber").toString();
		location = getIntent().getExtras().get("location").toString();
		details = getIntent().getExtras().get("details").toString();
		dateStart = new DateObject(getIntent().getExtras().get("dateStart").toString());
		dateEnd = new DateObject(getIntent().getExtras().get("dateEnd").toString());
		
		tvName.setText("Kenny Wong");
		tvPhone.setText("2817335812");
		tvEmail.setText("kwong@trinity.edu");
		etEventName.setText(eventName);
		etLoc.setText(location);
		etDescription.setText(details);
		
		Spinner spinner = (Spinner) findViewById(R.id.sSubject);
	    spinner.setAdapter(adapter);
	    int index = findIndex(subjects, subject);
	    spinner.setSelection(index);
		
		OnDateChangedListener dateListener = new OnDateChangedListener() {
			public void onDateChanged(DatePicker view, int year, int monthOfYear,int dayOfMonth) {
			    // Notify the user.
			}
		};
		
		dpDate.init(Integer.parseInt(dateStart.getYear()), Integer.parseInt(dateStart.getMonth())-1, Integer.parseInt(dateStart.getDate()), dateListener);
		tpStartTime.setCurrentHour(Integer.parseInt(dateStart.getHour()));
		tpStartTime.setCurrentMinute(Integer.parseInt(dateStart.getMinute()));
		tpEndTime.setCurrentHour(Integer.parseInt(dateEnd.getHour()));
		tpEndTime.setCurrentMinute(Integer.parseInt(dateEnd.getMinute()));
	}
	
	protected void updateEvent()
    {
		final EditText etDescription = (EditText) findViewById(R.id.etDescription);
		final DatePicker dpDate = (DatePicker) findViewById(R.id.dpDateEvent);
		final EditText etEventName = (EditText) findViewById(R.id.etEventName);
		final TimePicker tpStartTime = (TimePicker) findViewById(R.id.tpTimeStart);
		final TimePicker tpEndTime = (TimePicker) findViewById(R.id.tpTimeEnd);
		final EditText etLoc = (EditText) findViewById(R.id.etLoc);
		
		String eventName = etEventName.getText().toString();
		String location = etLoc.getText().toString();
		DateObject dateStart = new DateObject(dpDate, tpStartTime);
		DateObject dateEnd = new DateObject(dpDate, tpEndTime);
		String details = etDescription.getText().toString();
    	
    	final String query = "Update tm_Event SET " +
    			"event_Name =  '" + eventName + 
    			"', details = '" + details +
    			"', location = ' " + location +
    			"', date_Start = '" + dateStart +
    			"', date_End =' " + dateEnd +
    			"' WHERE user_id = " + HomePage.userID;
    	
    	System.out.println(query);
    	
    	Runnable runnable = new Runnable()
		{
			public void run()
			{
				try {
					System.out.println("Started editTutor thread");
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
	
	private int findIndex(ArrayList<String> a, String s)
	{
		for(String item: a)
			if(item.equals(s))
				return a.indexOf(item);
		return 0;
	}

	@Override
    public void onBackPressed()
    {
		Toast.makeText(getApplicationContext(), "Scroll Down To Save Or Cancel", Toast.LENGTH_SHORT).show();
    	return;
    }
}