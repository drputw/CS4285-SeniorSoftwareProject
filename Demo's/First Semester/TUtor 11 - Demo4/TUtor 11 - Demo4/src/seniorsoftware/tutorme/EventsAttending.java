package seniorsoftware.tutorme;

import genericobjects.StudyObject;

import java.util.ArrayList;

import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class EventsAttending extends ListActivity
{   
	private ProgressDialog m_ProgressDialog = null;
	private static ArrayList<StudyObject> study = null;
	private StudyAdapter study_adapter;
	private String newrec;
	public int Create_Study_Event = 0101;
	//    Intent intent;
	//    private Runnable viewOrders;


	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		study = new ArrayList<StudyObject>();
		study = testData();
		this.study_adapter = new SpecialAdapter(this, R.layout.study_row, study);
		setListAdapter(this.study_adapter);

		//        viewOrders = new Runnable()
		//        {
		//            @Override
		//            public void run()
		//            {
		//                getOrders();
		//            }
		//        };
		//        Thread thread =  new Thread(null, viewOrders, "MagentoBackground");
		//        thread.start();
		//        m_ProgressDialog = ProgressDialog.show(Study.this,    
		//              "Please wait...", "Retrieving data ...", true);
		
		ListView lv = getListView();
		lv.setTextFilterEnabled(true);

		final Intent intent = new Intent(this, EventDetails.class);
		lv.setOnItemClickListener(new OnItemClickListener()
		{
			public void onItemClick(AdapterView<?> parent, View view, int position, long id)
			{
				// When clicked, show a toast with the TextView text
				//Toast.makeText(getApplicationContext(), "Hello", Toast.LENGTH_SHORT).show();
				intent.putExtra("Name", study.get(position).getClassName());
				intent.putExtra("Course", study.get(position).getClassNumber());
				intent.putExtra("Organizer", study.get(position).getOrganizer());
				intent.putExtra("loc", study.get(position).getLoc());
				intent.putExtra("month", study.get(position).getMonth());
				intent.putExtra("day", study.get(position).getDate());
				intent.putExtra("year", study.get(position).getYear());
				intent.putExtra("hour", study.get(position).getHour());
				intent.putExtra("min", study.get(position).getMin());
				intent.putExtra("id", position);

				startActivity(intent);

				//newEvent();
			}
		});
		
	}
	private Runnable returnRes = new Runnable()
	{
		public void run()
		{
			if(study != null && study.size() > 0){
				study_adapter.notifyDataSetChanged();
				for(int i=0;i<study.size();i++)
					study_adapter.add(study.get(i));
			}
			m_ProgressDialog.dismiss();
			study_adapter.notifyDataSetChanged();
		}
	};
	private void getOrders()
	{
		try
		{
			study = new ArrayList<StudyObject>();
			StudyObject o1 = new StudyObject("CSCI 4301", "Senior Software", "James Seales","Majors Lab", 0, 0, 0, 7 , 30);
			StudyObject o2 = new StudyObject("CSCI 1301", "PoP 1", "Matt Fitzpatrick","Majors Lab",0, 0, 0,0,0);
			study.add(o1);
			study.add(o2);
			//          Thread.sleep(5000);
			//          Log.i("ARRAY", ""+ study.size());
		} catch (Exception e) {
			Log.e("BACKGROUND_PROC", e.getMessage());
		}
		//        runOnUiThread(returnRes);
	}

	public static ArrayList<StudyObject> getStudy() {
		return study;
	}
	
	
	private ArrayList<StudyObject> testData()
	{
		study = new ArrayList<StudyObject>();
		StudyObject o1 = new StudyObject("CSCI 4385-1", "Senior Software 1", "James Seales","Majors Lab",10, 13, 2012, 7, 30);
		StudyObject o2 = new StudyObject("CSCI 3323-1", "Principles of Operating Systems", "Berna Massingill","Majors Lab", 8, 29, 2012, 8, 15);
		StudyObject o3 = new StudyObject("ENG 2301-2", "British-Lit: Epic to Romantic", "Kenny Wong", "Beze Underground", 5, 7, 2012, 6, 30);
		study.add(o1);
		study.add(o2);
		study.add(o3);


		return study;
	}

	private class StudyAdapter extends ArrayAdapter<StudyObject>
	{
		private ArrayList<StudyObject> study;

		public StudyAdapter(Context context, int textViewResourceId, ArrayList<StudyObject> items)
		{
			super(context, textViewResourceId, items);
			this.study = items;
		}
		@Override
		public View getView(int position, View convertView, ViewGroup parent)
		{
			View v = convertView;
			if (v == null)
			{
				LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
				v = vi.inflate(R.layout.study_row, null);
			}
			StudyObject o = study.get(position);
			if (o != null)
			{
				TextView tt = (TextView) v.findViewById(R.id.studyRow_classNumber);
				TextView mt = (TextView) v.findViewById(R.id.studyRow_className);
				TextView bt = (TextView) v.findViewById(R.id.studyRow_organizer);
				if (tt != null)
				{
					tt.setText(o.getClassNumber());
				}
				if(mt != null)
				{
					mt.setText(o.getClassName());
				}
				if(bt != null)
				{
					bt.setText(o.getOrganizer());
				}
			}
			ImageView iv = (ImageView) v.findViewById(R.id.icon);
			iv.setImageResource(R.drawable.study);
			if(position == 0)
				iv.setImageResource(R.drawable.calendaroctober13);
			if(position == 1)
				iv.setImageResource(R.drawable.calendaraugust29);
			if(position == 2)
				iv.setImageResource(R.drawable.calendarmay7);
			if(position == 3)
				iv.setImageResource(R.drawable.calendarjuly28);
			if(position == 4)
				iv.setImageResource(R.drawable.calendardecember25);
			if(position == 5)
				iv.setImageResource(R.drawable.calendarnovember17);
			return v;
		}
	}

	public class SpecialAdapter extends StudyAdapter {    	
		private int[] colors = new int[] { 0x30ffffff, 0x30808080 };    

		private ArrayList<StudyObject> study;

		public SpecialAdapter(Context context, int textViewResourceId, ArrayList<StudyObject> items) {
			super(context, textViewResourceId, items);
			this.study = items;

		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			View view = super.getView(position, convertView, parent);
			int colorPos = position % colors.length;
			view.setBackgroundColor(colors[colorPos]);
			return view;
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.study_menu, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.createEvent:     
			//Toast.makeText(this, "You pressed the create event icon!", Toast.LENGTH_LONG).show();
			final Intent intent = new Intent().setClass(this, CreateStudyEvent.class);

			intent.putExtra("newrec", newrec);
			startActivityForResult(intent, Create_Study_Event);

			break;

		}
		return true;
	}

	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if(resultCode==RESULT_OK && requestCode==1){
			newrec = data.getStringExtra(newrec);

			Toast.makeText(getApplicationContext(), newrec, Toast.LENGTH_SHORT).show();
			StudyObject o8 = new StudyObject("CSCI 3366-1", "Database Systems", "Tom Hicks", "Majors Lab", 0, 0, 0,0,0);
			study.add(o8);
			

			super.onActivityResult(requestCode, resultCode, data);
		}
	}
}