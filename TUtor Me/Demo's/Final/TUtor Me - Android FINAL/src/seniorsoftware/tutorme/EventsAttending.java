package seniorsoftware.tutorme;

import generics.DateObject;
import generics.StudyObject;

import java.io.IOException;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.EventsAttendingQuery;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.Filter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class EventsAttending extends ListActivity
{   
	private ProgressDialog m_ProgressDialog = null;
	public static ArrayList<StudyObject> study = null;
	private StudyAdapter study_adapter = null;
	private final Object mLock = new Object();

    private static Runnable viewStudy = null;
	private static boolean loaded = false;
	public static boolean reload = true;
	
	//the runnable that gets called after the data is returned and parsed
	final Runnable returnRes = new Runnable(){

		public void run() {
			if(study != null && study.size() > 0){

				System.out.println("Updating adapter");
				System.out.println(study.size());
				study_adapter.notifyDataSetChanged();
			}
			m_ProgressDialog.dismiss();
			study_adapter.notifyDataSetChanged();
			loaded = true;
		}
	};
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		setDefaultKeyMode(DEFAULT_KEYS_SEARCH_LOCAL);
    	
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        final Intent intent = new Intent().setClass(this, EventDetails.class);
		ListView lv = getListView();
		lv.setTextFilterEnabled(true);

		lv.setOnItemClickListener(new OnItemClickListener()
		{
			public void onItemClick(AdapterView<?> parent, View view, int position, long id)
			{
				StudyObject o = study.get(position);
				intent.putExtra("id", o.getID());
				intent.putExtra("eventName", o.getEventName());
				intent.putExtra("email", o.getEmail());
				intent.putExtra("phone", o.getPhone());
				intent.putExtra("organizer", o.getOrganizer());
				intent.putExtra("courseNumber", o.getCourseNumber());
				intent.putExtra("courseName", o.getCourseName());
				intent.putExtra("details", o.getDetails());
				intent.putExtra("dateStart", o.getDateStart());
				intent.putExtra("dateEnd", o.getDateEnd());
				intent.putExtra("dateCreated", o.getDateCreated());
				intent.putExtra("location", o.getLocation());
				intent.putExtra("subject", o.getSubject());
				intent.putExtra("rsvp", o.getRSVP());

				EventDetails.checkit = true;
				startActivity(intent);
			}
		});
	}
	
	public void onResume()
	{
		super.onResume();
		
		viewStudy = null;
    	study = null;
    	loaded = false;
    	callService();
    	
    	study_adapter = new SpecialAdapter(this, R.layout.study_row, study);
    	setListAdapter(this.study_adapter);
	}
	
	public void callService()
	{	
		if(study == null)
        	study = new ArrayList<StudyObject>();
		
		if(viewStudy == null)
		{
			viewStudy = new Runnable()
			{
				public void run()
				{
					try {
						System.out.println("Started viewStaff thread");
						EventsAttendingQuery sq = new EventsAttendingQuery();
						String query = getQueryString(); 
						sq.getInfo(query, "", EventsAttending.this, returnRes);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (ParserConfigurationException e) {
						e.printStackTrace();
					} catch (SAXException e) {
						e.printStackTrace();
					}
				}
			};

			Thread thread = new Thread(null, viewStudy, "Background");
			thread.start();
		}

		if(!loaded)
			m_ProgressDialog = ProgressDialog.show(EventsAttending.this, "Please wait...", "Retrieving data", true);
	}
	
	protected String getQueryString()
	{
		return "Select event.id, user.email, user.phone, user.firstname, user.lastname, " +
				"event.details, event.date_Start, event.date_End, event.date_Created, event.location, " +
				"event.event_Name, course.Course, course.name, major.major, COUNT(*) AS COUNT " +
				"From tm_RSVP as rsvp Inner Join tm_Event as event On rsvp.event_ID = event.id " +
				"Inner Join tm_User as user On event.user_ID = user.id " +
				"Inner Join tm_Major as major ON event.subject_id = major.id " +
				"Left Join tm_Courses as course On course.ID = event.course_id where rsvp.user_ID = " + HomePage.userID + " GROUP BY event.id ORDER BY event.event_name Asc";
	}

	private class StudyAdapter extends ArrayAdapter<StudyObject>
	{
		private ArrayList<StudyObject> allStudy;
		private StudyNameFilter filter;
		public ArrayList<StudyObject> filtered;


		public StudyAdapter(Context context, int textViewResourceId, ArrayList<StudyObject> items)
		{
			super(context, textViewResourceId, items);
			this.allStudy = items;
			this.filtered = this.allStudy;
		}
		@Override
		public View getView(int position, View convertView, ViewGroup parent)
		{
			View v = convertView;
			if (convertView == null) {
				LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
				v = vi.inflate(R.layout.study_row, null);
			} else {
				v = convertView;
			}

			StudyObject o = filtered.get(position);
			if (o != null)
			{
				TextView tt = (TextView) v.findViewById(R.id.studyRow_classSubject);
				TextView mt = (TextView) v.findViewById(R.id.studyRow_className);
				TextView bt = (TextView) v.findViewById(R.id.studyRow_organizer);
				if (tt != null)
				{
					tt.setText(o.getSubject());
				}
				if(mt != null)
				{
					mt.setText(o.getEventName());
				}
				if(bt != null)
				{
					bt.setText(o.getOrganizer());
				}
			}
			DateObject dateObject = new DateObject(o.getDateStart());
			
			ImageView iv = (ImageView) v.findViewById(R.id.iconCalendar);
			iv.setImageResource(R.drawable.calendar);
			
			TextView tvMonth = (TextView) v.findViewById(R.id.iconMonth);
			tvMonth.setText(dateObject.getMonthAlpha());
			
			TextView tvDate = (TextView) v.findViewById(R.id.iconDate);
			tvDate.setText(dateObject.getDate());
			return v;
		}

		@Override
		public Filter getFilter()
		{
			if(filter == null)
				filter = new StudyNameFilter();
			return filter;
		}

		@Override
		public void add(StudyObject object) {
			if (allStudy != null) {
				synchronized (mLock) {
					allStudy.add(object);
					notifyDataSetChanged();
				}
			} else {
				filtered.add(object);
				notifyDataSetChanged();
			}
		}

		/**
		 * Inserts the spcified object at the specified index in the array.
		 *
		 * @param object The object to insert into the array.
		 * @param index The index at which the object must be inserted.
		 */
		@Override
		public void insert(StudyObject object, int index) {
			if (allStudy != null) {
				synchronized (mLock) {
					allStudy.add(index, object);
				}
			} else {
				filtered.add(index, object);
			}
		}

		/**
		 * Removes the specified object from the array.
		 *
		 * @param object The object to remove.
		 */
		@Override
		public void remove(StudyObject object) {
			Toast.makeText(getApplicationContext(), "remove", Toast.LENGTH_LONG).show();
			if (allStudy != null) {
				synchronized (mLock) {
					allStudy.remove(object);
				}
			} else {
				filtered.remove(object);
			}
		}

		/**
		 * Remove all elements from the list.
		 */
		@Override
		public void clear() {
			if (allStudy != null) {
				synchronized (mLock) {
					allStudy.clear();
				}
			} else {
				filtered.clear();
			}
		}

		/**
		 * {@inheritDoc}
		 */
		public int getCount() {
			return filtered.size();
		}

		/**
		 * {@inheritDoc}
		 */
		public StudyObject getItem(int position) {
			return filtered.get(position);
		}

		private class StudyNameFilter extends Filter
		{

			@Override
			protected FilterResults performFiltering(CharSequence constraint)
			{
				constraint = constraint.toString().toLowerCase();
				FilterResults result = new FilterResults();

				if (allStudy == null) {
					synchronized (mLock) {
						allStudy = filtered;
					}
				}

				if (constraint == null || constraint.length() == 0)
				{
					synchronized(mLock)
					{
						ArrayList<StudyObject> studyList = allStudy;
						result.values = studyList;
						result.count = studyList.size();
					}
				}
				else
				{
					ArrayList<StudyObject> studyValues = allStudy;
					final int count = studyValues.size();
					ArrayList<StudyObject> newValues = new ArrayList<StudyObject>();

					for (int index = 0; index < count; index++)
					{
						StudyObject si = allStudy.get(index);
						if(si.getOrganizer().toLowerCase().contains(constraint.toString()) ||
								si.getCourseName().toLowerCase().contains(constraint.toString()) ||
								si.getEventName().toLowerCase().contains(constraint.toString()) ||
								si.getCourseNumber().toLowerCase().contains(constraint.toString()))
						{
							newValues.add(si);  
						}
					}
					result.count = newValues.size();
					result.values = newValues;
				}
				return result;
			}

			@SuppressWarnings("unchecked")
			@Override
			protected void publishResults(CharSequence constraint, FilterResults results)
			{
				// NOTE: this function is *always* called from the UI thread.
				filtered = (ArrayList<StudyObject>)results.values;

				notifyDataSetChanged();
				
		        final Intent intent = new Intent(getContext(), EventDetails.class);
				ListView lv = getListView();
				lv.setTextFilterEnabled(true);

				lv.setOnItemClickListener(new OnItemClickListener()
				{
					public void onItemClick(AdapterView<?> parent, View view, int position, long id)
					{
						StudyObject o = filtered.get(position);
						intent.putExtra("id", o.getID());
						intent.putExtra("eventName", o.getEventName());
						intent.putExtra("email", o.getEmail());
						intent.putExtra("phone", o.getPhone());
						intent.putExtra("firstName", o.getFirstName());
						intent.putExtra("lastName", o.getLastName());
						intent.putExtra("courseNumber", o.getCourseNumber());
						intent.putExtra("courseName", o.getCourseName());
						intent.putExtra("details", o.getDetails());
						intent.putExtra("dateStart", o.getDateStart());
						intent.putExtra("dateEnd", o.getDateEnd());
						intent.putExtra("dateCreated", o.getDateCreated());
						intent.putExtra("location", o.getLocation());
						intent.putExtra("subject", o.getSubject());
						intent.putExtra("rsvp", o.getRSVP());

						startActivity(intent);
					}
				});
			}
		}
	}



	public class SpecialAdapter extends StudyAdapter {    	
		private int[] colors = new int[] { 0x30ffffff, 0x30808080 };    

		public SpecialAdapter(Context context, int textViewResourceId, ArrayList<StudyObject> items) {
			super(context, textViewResourceId, items);
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
	public boolean onOptionsItemSelected(MenuItem item)
	{
		if(item.getTitle().equals("Create Event"))
		{
			final Intent i = new Intent().setClass(this, CreateStudyEvent.class);
			startActivity(i);
		}
		if(item.getTitle().equals("Search"))
		{
			InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
			inputMgr.toggleSoftInput(0, 0);
		}
		return true;
	}
}