package seniorsoftware.tutorme;
import generics.DateObject;

import java.io.IOException;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.InsertQuery;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

public class CreateStudyEvent extends Activity 
{	
	final Activity act = this;

	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.create_event);

		ArrayList<String> subjects = new ArrayList<String>();
		subjects.add(0, "");
		for(String sub: CategoryTutors.subjects)
			subjects.add(sub);
		
		final Spinner spinner = (Spinner) findViewById(R.id.sSubject);
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, subjects);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinner.setAdapter(adapter);

		final TextView tvName = (TextView) findViewById(R.id.tvName);
		final TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
		final TextView tvPhone = (TextView) findViewById(R.id.tvPhone);
		final EditText etDescription = (EditText) findViewById(R.id.etDescription);
		Button btnCreate = (Button) findViewById(R.id.btnCreate);
		Button btnCancel = (Button) findViewById(R.id.btnCancel);
		final DatePicker dpDate = (DatePicker) findViewById(R.id.dpDateEvent);
		final EditText etEventName = (EditText) findViewById(R.id.etEventName);
		final TimePicker tpStartTime = (TimePicker) findViewById(R.id.tpTimeStart);
		final TimePicker tpEndTime = (TimePicker) findViewById(R.id.tpTimeEnd);
		final EditText etLoc = (EditText) findViewById(R.id.etLoc);

		tvName.setText("Kenny Wong");
		tvPhone.setText("2817335812");
		tvEmail.setText("kwong@trinity.edu");

		btnCreate.setOnClickListener(new View.OnClickListener()
		{					
			public void onClick(View view)
			{
				String eventName = etEventName.getText().toString();
				String location = etLoc.getText().toString();
				String subject = spinner.getSelectedItem().toString();
				DateObject dateStart = new DateObject(dpDate, tpStartTime);
				DateObject dateEnd = new DateObject(dpDate, tpEndTime);
				String details = etDescription.getText().toString();
				
				if(eventName.equals(""))
					Toast.makeText(getApplicationContext(), "You Must Enter an Event Name", Toast.LENGTH_SHORT).show();
				else if(location.equals(""))
					Toast.makeText(getApplicationContext(), "You Must Enter a Location", Toast.LENGTH_SHORT).show();
				else
				{
					String query = getQuery(eventName, subject, details, location, dateStart, dateEnd);
					createEventWebService(query);
				
					Toast.makeText(getApplicationContext(), "Event Created", Toast.LENGTH_SHORT).show();
					finish();
				}
			}
		});

		btnCancel.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Toast.makeText(getApplicationContext(), "No Event Created", Toast.LENGTH_SHORT).show();
				Intent i = getIntent();
				setResult(RESULT_CANCELED, i);
				finish();
			}
		});
	}

	protected String getQuery(String eventName, String subject, String details,
			String location, DateObject dateStart, DateObject dateEnd) 
	{
		return "INSERT INTO tm_Event (event_Name, details, location, date_Start, date_End, subject_id, user_id ) " +
				"VALUES ('" +
				eventName + "', '" +
				details + "', '" +
				location + "', '" +
				dateStart.toString() + "', '" +
				dateEnd.toString() + "', 13, " + HomePage.userID + ")";
	}

	public void createEventWebService(final String query)
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
	
	@Override
    public void onBackPressed()
    {
		Toast.makeText(getApplicationContext(), "Scroll down to save or back.", Toast.LENGTH_SHORT).show();
    	return;
    }
}