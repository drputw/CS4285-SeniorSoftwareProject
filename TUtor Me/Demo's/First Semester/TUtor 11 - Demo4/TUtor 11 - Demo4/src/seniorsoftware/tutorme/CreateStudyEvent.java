package seniorsoftware.tutorme;

import genericobjects.StudyObject;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
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
	Editable ClassSec;
	Editable ClassDes;
	String className;
	String course;
	String loc;
	StudyObject ret;
	String newrec;
	int month, day, year, hour, min;




	@Override
	public void onCreate(Bundle savedInstanceState)
	{

		super.onCreate(savedInstanceState);
		setContentView(R.layout.create_event);

		Spinner spinner = (Spinner) findViewById(R.id.sSubject);
		ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(
				this, R.array.subjects_array, android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinner.setAdapter(adapter);


		//		Intent intent = getIntent();
		//		newrec = intent.getStringExtra(newrec);
		//
		final TextView tvName = (TextView) findViewById(R.id.tvName);
		Button btnCreate = (Button) findViewById(R.id.btnCreate);
		Button btnCancel = (Button) findViewById(R.id.btnCancel);
		final DatePicker dpDate = (DatePicker) findViewById(R.id.dpNewEvent);
		final EditText etClass = (EditText) findViewById(R.id.etClassName);
		final EditText etCourse = (EditText) findViewById(R.id.etCourse);
		final TimePicker tpTime = (TimePicker) findViewById(R.id.tpNewEvent);
		final EditText etLoc = (EditText) findViewById(R.id.etLoc);

		tvName.setText("James Seales");


		btnCreate.setOnClickListener(new View.OnClickListener() {					
			public void onClick(View view) {
				//		
				if(etClass.getText().toString().equals("")){
					Toast.makeText(getApplicationContext(), "You Must Enter a Class Name", Toast.LENGTH_SHORT).show();
				}
				if(etCourse.getText().toString().equals("")){					
					Toast.makeText(getApplicationContext(), "You Must Enter a Course Name", Toast.LENGTH_SHORT).show();
				}
				if(etLoc.getText().toString().equals("")){					
					Toast.makeText(getApplicationContext(), "You Must Enter a Location", Toast.LENGTH_SHORT).show();
				}
				else {
					className = etClass.getText().toString();
					course = etCourse.getText().toString();
					month = dpDate.getMonth();
					day = dpDate.getDayOfMonth();
					year = dpDate.getYear();
					hour = tpTime.getCurrentHour();
					min = tpTime.getCurrentMinute();
					loc = etLoc.getText().toString();

					Intent i = getIntent();
					i.putExtra("retOrganizerName", tvName.toString());
					i.putExtra("retClassName", className);
					i.putExtra("retCourse", course);
					i.putExtra("retLoc", loc);
					i.putExtra("retMonth", month);
					i.putExtra("retDay", day);
					i.putExtra("retYear", year);
					i.putExtra("retHour", hour);
					i.putExtra("retMin", min);

					setResult(RESULT_OK, i);
					finish();
					// TODO Auto-generated method stub
				}
			}
		});

		btnCancel.setOnClickListener(new View.OnClickListener() {

			public void onClick(View view) {
				// TODO Auto-generated method stub
				Intent i = getIntent();
				setResult(RESULT_CANCELED, i);
				finish();

			}
		});


	}}