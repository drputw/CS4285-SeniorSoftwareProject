package seniorsoftware.tutorme;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class EditTutor extends Activity 
{
    @Override
	public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.edit_tutor);
        
	    ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(
	            this, R.array.subjects_array, android.R.layout.simple_spinner_item);
	    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
	    Spinner spinner = (Spinner) findViewById(R.id.tutor_major1);
	    spinner.setAdapter(adapter);
	    
	    Spinner spinner2 = (Spinner) findViewById(R.id.tutor_major2);
	    spinner2.setAdapter(adapter);
	    
	    Spinner spinner3 = (Spinner) findViewById(R.id.tutor_major3);
	    spinner3.setAdapter(adapter);
        
        TextView tvName = (TextView) findViewById(R.id.tvName);
        Button btnCancel = (Button) findViewById(R.id.btnCancel);
        Button btnSave = (Button) findViewById(R.id.btnSave);
        
        tvName.bringToFront();
        
        btnCancel.setOnClickListener(new View.OnClickListener() {

			public void onClick(View view) {
				// TODO Auto-generated method stub
				Intent i = getIntent();
				setResult(RESULT_CANCELED, i);
				finish();

			}
		});
        
        btnSave.setOnClickListener(new View.OnClickListener() {

			public void onClick(View view) {
				// TODO Auto-generated method stub
				Intent i = getIntent();				
				setResult(RESULT_OK, i);
				Toast.makeText(getApplicationContext(), "Profile Saved", Toast.LENGTH_SHORT).show();
				finish();

			}
		});
    }
}





