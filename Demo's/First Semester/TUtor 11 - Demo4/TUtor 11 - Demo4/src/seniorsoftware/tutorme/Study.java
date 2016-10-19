package seniorsoftware.tutorme;

import genericobjects.StudyObject;

import java.util.ArrayList;
import java.util.Calendar;

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

public class Study extends ListActivity
{   
	private ProgressDialog m_ProgressDialog = null;
	private ArrayList<StudyObject> study = null;
	private StudyAdapter study_adapter;
	private final Object mLock = new Object();
	private static final int Create_Study_Event = 1010;
	private String organizerName = "James Seales";
	private String className = "Senior Software";
	private String course = "CSCI 4302-1";
	private String loc = "North/South Foyer";
	private int year;
    private int month;
    private int day;
    private int hour;
    private int min;
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
		final Calendar c = Calendar.getInstance();
	    year = c.get(Calendar.YEAR);
	    month = c.get(Calendar.MONTH);
	    day = c.get(Calendar.DAY_OF_MONTH);
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
	
	
	private ArrayList<StudyObject> testData()
	{
		study = new ArrayList<StudyObject>();
		StudyObject o1 = new StudyObject("CSCI 4385-1", "Senior Software 1", "James Seales","Majors Lab", 10, 13, 2012, 7, 30);
		StudyObject o2 = new StudyObject("CSCI 3323-1", "Principles of Operating Systems", "Berna Massingill", "Halsell 340", 8, 29, 2012, 8, 00);
		StudyObject o3 = new StudyObject("ENG 2301-2", "British-Lit: Epic to Romantic", "Kenny Wong", "Beze Underground", 5, 7, 2012, 9, 15);
		StudyObject o4 = new StudyObject("CSCI 2094-1", "Computer Seminar", "Gerald Pitts", "Majors Lab", 7, 28, 2012, 4, 30);
		StudyObject o5 = new StudyObject("BUSN 2301-1", "Corporate Social Responsibility", "Linda Specht", "The Cave", 12, 25, 2012, 7, 00);
		StudyObject o6 = new StudyObject("COMM 1302-1", "Introduction to Film Studies", "Patrick Keating", "North/South Foyer", 11, 17, 2012, 5, 30);
		study.add(o1);
		study.add(o2);
		study.add(o3);
		study.add(o4);
		study.add(o5);
		study.add(o6);

		return study;
	}

	private class StudyAdapter extends ArrayAdapter<StudyObject>
	{
		private ArrayList<StudyObject> allStudy;
		private StudyNameFilter filter;
		public ArrayList<StudyObject> filtered;
		private LayoutInflater inflater;


		public StudyAdapter(Context context, int textViewResourceId, ArrayList<StudyObject> items)
		{
			super(context, textViewResourceId, items);
			this.allStudy = items;
			this.filtered = this.allStudy;
			inflater= LayoutInflater.from(context);
		}
		@Override
		public View getView(int position, View convertView, ViewGroup parent)
		{
			View v = convertView;
			if (convertView == null) {
				//              v = mInflater.inflate(resource, parent, false);
				LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
				v = vi.inflate(R.layout.study_row, null);
			} else {
				v = convertView;
			}

			StudyObject o = filtered.get(position);
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
			if(position == 6)
				iv.setImageResource(R.drawable.calendardecember25);
			if(position == 7)
				iv.setImageResource(R.drawable.calendardecember25);
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
					//                    if (mNotifyOnChange) 
					notifyDataSetChanged();
				}
			} else {
				filtered.add(object);
				//                if (mNotifyOnChange) notifyDataSetChanged();
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
					//                    if (mNotifyOnChange) notifyDataSetChanged();
				}
			} else {
				filtered.add(index, object);
				//                if (mNotifyOnChange) notifyDataSetChanged();
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
			//            if (mNotifyOnChange) notifyDataSetChanged();
		}

		/**
		 * Remove all elements from the list.
		 */
		@Override
		public void clear() {
			//        	Toast.makeText(getApplicationContext(), "clear", Toast.LENGTH_LONG).show();
			if (allStudy != null) {
				synchronized (mLock) {
					allStudy.clear();
				}
			} else {
				filtered.clear();
			}
			//            if (mNotifyOnChange) notifyDataSetChanged();
		}

		//        public Context getContext() {
		//            return mContext;
		//        }

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
				// NOTE: this function is *always* called from a background thread, and
				// not the UI thread.
				constraint = constraint.toString().toLowerCase();
				FilterResults result = new FilterResults();
				//                ArrayList<StudyObject> filt = new ArrayList<StudyObject>();

				if (allStudy == null) {
					//                	Toast.makeText(getApplicationContext(), "alltutrs = filtered", Toast.LENGTH_LONG).show();
					synchronized (mLock) {
						allStudy = filtered;
					}
				}

				if (constraint == null || constraint.length() == 0)
				{
					synchronized(mLock)
					{
						ArrayList<StudyObject> tutorList = allStudy;
						result.values = tutorList;
						result.count = tutorList.size();
					}
				}
				else
				{
					//                    ArrayList<StudyObject> lItems = new ArrayList<StudyObject>();
					//                    synchronized (allStudy)
					//                    {
					//                        lItems.addAll(allStudy);
					//                    }
					//                    for(int i = 0, l = lItems.size(); i < l; i++)
					//                    {
					//                        StudyObject m = lItems.get(i);
					//                        if(m.getName().toLowerCase().contains(constraint))
					//                            filt.add(m);
					//                    }
					ArrayList<StudyObject> tutorValues = allStudy;
					final int count = tutorValues.size();
					ArrayList<StudyObject> newValues = new ArrayList<StudyObject>();

					for (int index = 0; index < count; index++)
					{
						StudyObject si = allStudy.get(index);
						if(si.getClassName().toLowerCase().contains(constraint.toString()) ||
								si.getOrganizer().toLowerCase().contains(constraint.toString()) ||
								si.getClassNumber().toLowerCase().contains(constraint.toString()))
						{
							newValues.add(si);  
						}
					}

					//                	Toast.makeText(getApplicationContext(), "char: " + constraint, Toast.LENGTH_SHORT).show();
					result.count = newValues.size();
					result.values = newValues;
				}

				//                Toast.makeText(getApplicationContext(), "allStudy: '"+ allStudy.size() + "'\n" + "filtered: '"+ filtered.size() + "'\n"  
				//                		+ "result.count: '"+ result.count + "'\n" + "result.alue: '"+ result.values + "'\n", Toast.LENGTH_LONG).show();
				return result;
			}

			@SuppressWarnings("unchecked")
			@Override
			protected void publishResults(CharSequence constraint, FilterResults results)
			{
				// NOTE: this function is *always* called from the UI thread.
				filtered = (ArrayList<StudyObject>)results.values;
				//                clear();
				//                for(int i = 0, l = filtered.size(); i < l; i++)
				//                    add(filtered.get(i));
				notifyDataSetChanged();
				//                notifyDataSetInvalidated();
			}
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
	public boolean onOptionsItemSelected(MenuItem item)
	{

		switch (item.getItemId())
		{
		case R.id.createEvent:
			newEvent();
			break;
			
		case R.id.SearchStudy:
			InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
			inputMgr.toggleSoftInput(0, 0);
			break;
		}
		return true;
	}

	private void newEvent() {
		//Intent i = new Intent(this, CreateStudyEvent.class);
		Intent i = new Intent().setClass(this, CreateStudyEvent.class);
		//Toast.makeText(getApplicationContext(), "Hello", Toast.LENGTH_SHORT).show();
		i.putExtra("Name", organizerName);
		i.putExtra("className", className);
		i.putExtra("course", course);
		i.putExtra("loc", loc);
		i.putExtra("month", month);
		i.putExtra("day", day);
		i.putExtra("year", year);
		i.putExtra("hour", hour);
		i.putExtra("min", min);
		//startActivity(i);
		//Toast.makeText(getApplicationContext(), className, Toast.LENGTH_SHORT).show();
		startActivityForResult(i, Create_Study_Event);
	}

	protected void onActivityResult(int requestCode,  int resultCode, Intent data) {
		if (requestCode == Create_Study_Event && resultCode == RESULT_OK) {
			organizerName = data.getExtras().getString("retOrganizerName");
			className = data.getExtras().getString("retClassName");
			course = data.getExtras().getString("retCourse");
			loc = data.getExtras().getString("retLoc");
			month = data.getExtras().getInt("retMonth");
			day = data.getExtras().getInt("retDay");
			year = data.getExtras().getInt("retYear");
			hour = data.getExtras().getInt("retHour");
			min = data.getExtras().getInt("retMin");
			
			
			StudyObject newobj = new StudyObject(course, className, "James Seales", loc, month, day, year, hour, min);
			study.add(newobj);
//			View v = super.getListView();
//			ImageView iv = (ImageView) v.findViewById(R.id.icon);
//			iv.setImageResource(R.drawable.study);
//			study.get(5).setImageResource(R.drawable.calendardecember25);
			Toast.makeText(getApplicationContext(), loc, Toast.LENGTH_SHORT).show();
//			Toast.makeText(getApplicationContext(), className, Toast.LENGTH_SHORT).show();
//			Toast.makeText(getApplicationContext(), course, Toast.LENGTH_SHORT).show();
		}		
	}
}