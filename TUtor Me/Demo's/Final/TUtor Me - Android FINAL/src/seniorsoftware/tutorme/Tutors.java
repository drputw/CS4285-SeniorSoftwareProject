package seniorsoftware.tutorme;

import generics.TutorObject;

import java.io.IOException;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import queries.TutorQuery;
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

public class Tutors extends ListActivity
{
    private ProgressDialog m_ProgressDialog = null;
    public static ArrayList<TutorObject> tutors = null;
    private SpecialAdapter tutor_adapter = null;
    private final Object mLock = new Object();
    
    private static Runnable viewTutor = null;
	private static boolean loaded = false;
	public static boolean reload = true;
	
	//the runnable that gets called after the data is returned and parsed
	final Runnable returnRes = new Runnable()
	{
		public void run()
		{
			if(tutors != null && tutors.size() > 0)
			{
				System.out.println("Updating adapter");
				System.out.println(tutors.size());
				tutor_adapter.notifyDataSetChanged();
			}
			m_ProgressDialog.dismiss();
			tutor_adapter.notifyDataSetChanged();
			loaded = true;
		}
	};

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
    	setDefaultKeyMode(DEFAULT_KEYS_SEARCH_LOCAL);
    	
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
    }
    
    public void onResume()
    {
    	super.onResume();
    	
    	final Intent intent = new Intent().setClass(this, TutorDetails.class);
		ListView lv = getListView();
		lv.setTextFilterEnabled(true);
	

		lv.setOnItemClickListener(new OnItemClickListener()
		{
			public void onItemClick(AdapterView<?> parent, View view, int position, long id)
			{
				// When clicked, show a toast with the TextView text
				//Toast.makeText(getApplicationContext(), tutors.get(position).getName(), Toast.LENGTH_SHORT).show();
				TutorObject o = tutors.get(position);
				intent.putExtra("tutor", o.toString());
				intent.putExtra("year", o.getYear());
				intent.putExtra("major", o.getMajor());
				intent.putExtra("email", o.getEmail());
				intent.putExtra("phone", o.getPhone());
				intent.putExtra("id", o.getID());
				intent.putExtra("availability", o.getAvailability());
				intent.putExtra("description", o.getDescription());
				intent.putExtra("major2", o.getMajor2());
				intent.putExtra("major3", o.getMajor3());
				intent.putExtra("major4", o.getMajor4());
		        startActivity(intent);
			}
		});
    	
    	
    	HomePage hp = (HomePage) this.getParent();
    	hp.changeTitle(HomePage.filter);

    	if(reload)
    	{
    		refresh();
    	}
    	else
    		reload = true;
    	
    	tutor_adapter = new SpecialAdapter(this, R.layout.tutor_row, tutors);
    	setListAdapter(this.tutor_adapter);
    }
    
    private void refresh() {
    	viewTutor = null;
    	tutors = null;
    	loaded = false;
		callService();
		
	}

	public void callService()
    {
		if(tutors == null)
        	tutors = new ArrayList<TutorObject>();
		
		if(viewTutor == null)
		{
	    	viewTutor = new Runnable()
			{
				public void run()
				{
					try {
						System.out.println("Started viewTutors thread");
						TutorQuery sq = new TutorQuery();
						String query = getQueryString();
						sq.getInfo(query, "", Tutors.this, returnRes);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (ParserConfigurationException e) {
						e.printStackTrace();
					} catch (SAXException e) {
						e.printStackTrace();
					}
				}
			};
	
			Thread thread = new Thread(null, viewTutor, "Background");
			thread.start();
		}
		
		if(!loaded)
			m_ProgressDialog = ProgressDialog.show(Tutors.this, "Please wait...", "Retrieving data", true);
    }
    
     private static String getQueryString()
     { 
		if(HomePage.filter.equals("All"))
			return "SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, " +
					"user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 " +
					"FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id " +
					"INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 " +
					"LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 " +
					"LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 " +
					"LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 " +
					"WHERE user.isTutor =1 ORDER BY user.lastname ASC";
		
		if(HomePage.filter.equals("By Rank"))
			return "SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, " +
					"user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 " +
					"FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id " +
					"INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 " +
					"LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 " +
					"LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 " +
					"LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 " +
					"WHERE user.isTutor =1 ORDER BY class.id Desc, user.lastname Asc";
		
		if(HomePage.filter.equals("Recently Added"))
			return "SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, " +
					"user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 " +
					"FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id " +
					"INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 " +
					"LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 " +
					"LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 " +
					"LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 " +
					"WHERE user.isTutor =1 ORDER BY user.lastname ASC";
		
		return "SELECT user.id, user.firstname, user.lastname, user.email, class.class, user.phone, " +
				"user.description, user.availability, major_1.major, major_2.major2, major_3.major3, major_4.major4 " +
				"FROM tm_User AS user INNER JOIN tm_Classification AS class ON user.classification = class.id " +
				"INNER JOIN tm_Major AS major_1 ON major_1.id = user.major_1 " +
				"LEFT JOIN tm_Major2 AS major_2 ON major_2.id = user.major_2 " +
				"LEFT JOIN tm_Major3 AS major_3 ON major_3.id = user.major_3 " +
				"LEFT JOIN tm_Major4 AS major_4 ON major_4.id = user.major_4 " +
				"WHERE major_1.major = '" + HomePage.filter + "' " +
				"OR major_2.major2 = '" + HomePage.filter + "' " +
				"OR major_3.major3 = '" + HomePage.filter + "' " +
				"OR major_4.major4 = '" + HomePage.filter + "' " +
				"AND user.isTutor = 1 " +
				"ORDER BY user.lastname ASC";
	}

	public void onBackPressed()
    {
    	HomePage ParentActivity;
        ParentActivity = (HomePage) this.getParent();
        ParentActivity.mainView();
    }
      
    private class TutorAdapter extends ArrayAdapter<TutorObject>
    {
        private ArrayList<TutorObject> allTutors;
        private TutorNameFilter filter;
        public ArrayList<TutorObject> filtered;


        public TutorAdapter(Context context, int textViewResourceId, ArrayList<TutorObject> items)
        {
            super(context, textViewResourceId, items);
            this.allTutors = items;
            this.filtered = this.allTutors;
        }
        @Override
        public View getView(int position, View convertView, ViewGroup parent)
        {
            View v;
            if (convertView == null) {
            	LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            	v = vi.inflate(R.layout.tutor_row, null);
            } else {
                v = convertView;
            }

            TutorObject o = filtered.get(position);
            
            if (o != null)
            {
            	TextView tt = (TextView) v.findViewById(R.id.tutorRow_major);
                TextView mt = (TextView) v.findViewById(R.id.tutorRow_name);
                TextView bt = (TextView) v.findViewById(R.id.tutorRow_year);
                ImageView iv = (ImageView) v.findViewById(R.id.tutorRow_icon);
                String s = o.getMajor();
                if(o.getMajor2().length() > 3)
                	s = s.concat(", " + o.getMajor2());
                if(o.getMajor3().length() > 3)
                	s = s.concat(", " + o.getMajor3());
                if(o.getMajor4().length() > 3)
                	s = s.concat(", " + o.getMajor4());
                
                if (tt != null)
                      tt.setText(s);
                if (mt != null)
                      mt.setText(o.toString());
                if(bt != null)
                      bt.setText(o.getYear());
 
	            iv.setImageResource(R.drawable.tutor);
	            if(o.getMajor().toLowerCase().contains("computer"))
	            	iv.setImageResource(R.drawable.computer);
	            if(o.getMajor().toLowerCase().contains("business"))
	            	iv.setImageResource(R.drawable.business);
	            if(o.getMajor().toLowerCase().contains("theatre"))
	            	iv.setImageResource(R.drawable.theatre);
	            if(o.getMajor().toLowerCase().contains("biology"))
	            	iv.setImageResource(R.drawable.science);
	            if(o.getMajor().toLowerCase().contains("math"))
	            	iv.setImageResource(R.drawable.math);
	            if(o.getMajor().toLowerCase().contains("music"))
	            	iv.setImageResource(R.drawable.music);
            }
            return v;
        }
        
        @Override
        public Filter getFilter()
        {
            if(filter == null)
                filter = new TutorNameFilter();
            return filter;
        }

        @Override
        public void add(TutorObject object) {
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.add(object);
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
        public void insert(TutorObject object, int index) {
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.add(index, object);
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
        public void remove(TutorObject object) {
        	Toast.makeText(getApplicationContext(), "remove", Toast.LENGTH_LONG).show();
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.remove(object);
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
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.clear();
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
        public TutorObject getItem(int position) {
            return filtered.get(position);
        }
        
        private class TutorNameFilter extends Filter
        {
            @Override
            protected FilterResults performFiltering(CharSequence constraint)
            {
                // NOTE: this function is *always* called from a background thread, and
                // not the UI thread.
                constraint = constraint.toString().toLowerCase();
                FilterResults result = new FilterResults();
                
                if (allTutors == null) {
                    synchronized (mLock) {
                        allTutors = filtered;
                    }
                }
                
                if (constraint == null || constraint.length() == 0)
                {
                    synchronized(mLock)
                    {
                    	ArrayList<TutorObject> tutorList = allTutors;
                        result.values = tutorList;
                        result.count = tutorList.size();
                    }
                }
                else
                {
                	ArrayList<TutorObject> tutorValues = allTutors;
                	final int count = tutorValues.size();
                	ArrayList<TutorObject> newValues = new ArrayList<TutorObject>();
                	
                	for (int index = 0; index < count; index++)
                	{
                        TutorObject o = allTutors.get(index);
                        if(o.getFirstName().toLowerCase().contains(constraint.toString()) ||
                        		o.getLastName().toLowerCase().contains(constraint.toString()) ||
                        		o.getMajor().toLowerCase().contains(constraint.toString()) ||
                        		o.getMajor2().toLowerCase().contains(constraint.toString()) ||
                        		o.getMajor3().toLowerCase().contains(constraint.toString()) ||
                        		o.getMajor4().toLowerCase().contains(constraint.toString()))
                        {
                          newValues.add(o);  
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
                filtered = (ArrayList<TutorObject>)results.values;
                notifyDataSetChanged();
                
                final Intent intent = new Intent(getContext(), TutorDetails.class);
        		ListView lv = getListView();
        		lv.setTextFilterEnabled(true);

        		lv.setOnItemClickListener(new OnItemClickListener()
        		{
        			public void onItemClick(AdapterView<?> parent, View view, int position, long id)
        			{
        				// When clicked, show a toast with the TextView text
        				//Toast.makeText(getApplicationContext(), tutors.get(position).getName(), Toast.LENGTH_SHORT).show();
        				TutorObject o = filtered.get(position);
        				intent.putExtra("tutor", o.toString());
        				intent.putExtra("year", o.getYear());
        				intent.putExtra("major", o.getMajor());
        				intent.putExtra("major2", o.getMajor2());
        				intent.putExtra("major3", o.getMajor3());
        				intent.putExtra("major4", o.getMajor4());
        				intent.putExtra("email", o.getEmail());
        				intent.putExtra("phone", o.getPhone());
        				intent.putExtra("id", o.getID());
        				intent.putExtra("availability", o.getAvailability());
        				intent.putExtra("description", o.getDescription());
        		        startActivity(intent);
        			}
        		});
            }
        }
    }
    
    public class SpecialAdapter extends TutorAdapter
    {    	
    	private int[] colors = new int[] { 0x30ffffff, 0x30808080 };

	    public SpecialAdapter(Context context, int textViewResourceId, ArrayList<TutorObject> items)
	    {
	    	super(context, textViewResourceId, items);
	    }
    	    
	    @Override
	    public View getView(int position, View convertView, ViewGroup parent)
	    {
			View view = super.getView(position, convertView, parent);
			int colorPos = position % colors.length;
			view.setBackgroundColor(colors[colorPos]);
			return view;
	  	}
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.tutor_menu, menu);
        return true;
    }
    
    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
    	if(item.getTitle().equals("Refresh"))
		{
    		refresh();
    		
//	    	tutor_adapter = new SpecialAdapter(this, R.layout.tutor_row, tutors);
//	    	setListAdapter(this.tutor_adapter);
		}
    	
    	if(item.getTitle().equals("Search"))
		{
			InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
			inputMgr.toggleSoftInput(0, 0);
		}
        return true;
    }
}