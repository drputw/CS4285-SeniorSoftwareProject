package seniorsoftware.tutorme;

import generics.TutorObject;

import java.io.IOException;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.EditTutorQuery;
import queries.InsertQuery;
import android.app.Activity;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class EditTutor extends Activity 
{
	private static boolean loaded = false;
	private ProgressDialog m_ProgressDialog = null;
	public static TutorObject tutor = null;
	final Activity act = this;
	final Runnable returnRes = new Runnable()
	{
		public void run() {
			m_ProgressDialog.dismiss();
			loaded = true;
			updateCells();
		}
	};
	
    @Override
	public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.edit_tutor);
        
        if(tutor == null)
        	tutor = new TutorObject();
		
        
        Button btnCancel = (Button) findViewById(R.id.btnCancel);
        btnCancel.setOnClickListener(new View.OnClickListener()
        {
			public void onClick(View view)
			{
				Toast.makeText(getApplicationContext(), "No Changes Saved", Toast.LENGTH_SHORT).show();
				finish();
			}
		});
        
        Button btnSave = (Button) findViewById(R.id.btnSave);
        btnSave.setOnClickListener(new View.OnClickListener()
        {
			public void onClick(View view)
			{
				updateTutor();
				Toast.makeText(getApplicationContext(), "Profile Saved", Toast.LENGTH_SHORT).show();
				finish();
			}
		});
    }
    
    protected void updateTutor()
    {
    	EditText etTimes = (EditText) findViewById(R.id.etTimes);
        EditText etPhone = (EditText) findViewById(R.id.etPhone);
        EditText etDescription = (EditText) findViewById(R.id.etDescription);
    	
    	final String query = "UPDATE tm_User SET description = '" + etDescription.getText() + 
    			"', availability = '" + etTimes.getText() +
    			"', phone = '" + etPhone.getText() +
    			"' WHERE id = " + HomePage.userID;
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

	protected void updateCells()
    {
    	ArrayList<String> subjects = new ArrayList<String>();
		subjects.add(0, "");
		for(String sub: CategoryTutors.subjects)
			subjects.add(sub);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, subjects);
	    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
	    
	    Spinner spinner = (Spinner) findViewById(R.id.tutor_major);
	    spinner.setAdapter(adapter);
	    int index = findIndex(subjects, tutor.getMajor());
	    spinner.setSelection(index);
	    
	    Spinner spinner2 = (Spinner) findViewById(R.id.tutor_major2);
	    spinner2.setAdapter(adapter);
	    index = findIndex(subjects, tutor.getMajor2());
	    spinner2.setSelection(index);
	    
	    Spinner spinner3 = (Spinner) findViewById(R.id.tutor_major3);
	    spinner3.setAdapter(adapter);
	    index = findIndex(subjects, tutor.getMajor3());
	    spinner3.setSelection(index);
	    
	    Spinner spinner4 = (Spinner) findViewById(R.id.tutor_major3);
	    spinner4.setAdapter(adapter);
	    index = findIndex(subjects, tutor.getMajor4());
	    spinner4.setSelection(index);
	    
	    ArrayList<String> rank = getRank();
	    ArrayAdapter<String> rankAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, rank);
	    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
	    Spinner rankSpinner = (Spinner) findViewById(R.id.spinnerRank);
	    rankSpinner.setAdapter(rankAdapter);
	    index = findIndex(rank, tutor.getYear());
	    rankSpinner.setSelection(index);
    	
    	TextView tvName = (TextView) findViewById(R.id.tvName);
        tvName.setText(tutor.toString());
        
        EditText etTimes = (EditText) findViewById(R.id.etTimes);
        etTimes.setText(tutor.getAvailability());
        
        TextView tvEmail = (TextView) findViewById(R.id.tvEmail);
        tvEmail.setText(tutor.getEmail());
        
        EditText etPhone = (EditText) findViewById(R.id.etPhone);
        etPhone.setText(tutor.getPhone());
        
        EditText etDesciption = (EditText) findViewById(R.id.etDescription);
        etDesciption.setText(tutor.getDescription());
	}

	private ArrayList<String> getRank() {
		ArrayList<String> a = new ArrayList<String>();
		a.add("Freshman");
		a.add("Sophomore");
		a.add("Junior");
		a.add("Senior");
		return a;
	}

	private int findIndex(ArrayList<String> a, String s)
	{
		for(String item: a)
			if(item.equals(s))
				return a.indexOf(item);
		return 0;
	}

	public void onResume() {  
    	final String query = "SELECT user.id, user.firstname, user.lastname, user.email, class.class, " +
    			"user.phone, user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 " +
    			"FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id " +
    			"INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 " +
    			"LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 " +
    			"LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 " +
				"WHERE user.id = " + HomePage.userID;

		m_ProgressDialog = null;
		loaded = false;
    	
        super.onResume();  
        Runnable editTutor = null;
        
        if(editTutor == null)
		{
			editTutor = new Runnable()
			{
				public void run()
				{
					try {
						System.out.println("Started viewStaff thread");
						EditTutorQuery sq = new EditTutorQuery();
						sq.getInfo(query, "", act, returnRes);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (ParserConfigurationException e) {
						e.printStackTrace();
					} catch (SAXException e) {
						e.printStackTrace();
					}
				}
			};
			Thread thread = new Thread(null, editTutor, "Background");
			thread.start();
		}

		if(!loaded)
			m_ProgressDialog = ProgressDialog.show(EditTutor.this, "Please wait...", "Retrieving data", true);
    }

	@Override
    public void onBackPressed()
    {
    	Toast.makeText(getApplicationContext(), "Scroll down to save or back.", Toast.LENGTH_SHORT).show();
    	return;
    }
}