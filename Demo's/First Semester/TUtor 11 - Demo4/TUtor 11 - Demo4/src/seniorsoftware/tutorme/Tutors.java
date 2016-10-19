package seniorsoftware.tutorme;

import genericobjects.TutorObject;

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
    private ArrayList<TutorObject> tutors = null;
//    private CustomAdapter<TutorObject> tutor_adapter;
    private SpecialAdapter tutor_adapter;
    private final Object mLock = new Object();
    private Runnable viewOrders;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
    	
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        tutors = new ArrayList<TutorObject>();
        tutors = testData();
        String[] tutorNames = new String[99];
        for(int i = 0; i < tutors.size(); i++)
        	tutorNames[i] = tutors.get(i).getName();
        this.tutor_adapter = new SpecialAdapter(this, R.layout.tutor_row, tutors);
        setListAdapter(this.tutor_adapter);

        final Intent intent = new Intent().setClass(this, TutorDetails.class);
		ListView lv = getListView();
		lv.setTextFilterEnabled(true);

		
		
		lv.setOnItemClickListener(new OnItemClickListener()
		{
			public void onItemClick(AdapterView<?> parent, View view, int position, long id)
			{
				// When clicked, show a toast with the TextView text
				//Toast.makeText(getApplicationContext(), tutors.get(position).getName(), Toast.LENGTH_SHORT).show();
				intent.putExtra("tutor", tutors.get(position).getName());
				intent.putExtra("year", tutors.get(position).getYear());
		        startActivity(intent);
			}
		});
    }
    private Runnable returnRes = new Runnable()
    {
        public void run()
        
        {
            if(tutors != null && tutors.size() > 0){
                tutor_adapter.notifyDataSetChanged();
                for(int i=0;i<tutors.size();i++)
                tutor_adapter.add(tutors.get(i));
            }
            m_ProgressDialog.dismiss();
            tutor_adapter.notifyDataSetChanged();
        }
    };
    
    public void onBackPressed()
    {
    	HomePage ParentActivity;
        ParentActivity = (HomePage) this.getParent();
        ParentActivity.mainView();
    }
    
    private void getOrders()
    {
      try
      {
          tutors = new ArrayList<TutorObject>();
//          TutorObject o1 = new TutorObject("James Seales", "SR");
//          TutorObject o2 = new TutorObject("Matt Fitz", "SR");
//          tutors.add(o1);
//          tutors.add(o2);
//          Thread.sleep(5000);
//          Log.i("ARRAY", ""+ tutors.size());
        } catch (Exception e) {
          Log.e("BACKGROUND_PROC", e.getMessage());
        }
//        runOnUiThread(returnRes);
    }
    
    private ArrayList<TutorObject> testData()
    {
    	tutors = new ArrayList<TutorObject>();
        TutorObject o1 = new TutorObject("James Seales", "Senior", "Computer Science");
        TutorObject o2 = new TutorObject("Joshua Cavazos", "Senior", "Business Administration");
        TutorObject o3 = new TutorObject("Evan Barnett", "Junior", "Theatre");
        TutorObject o4 = new TutorObject("Amanda Tumey", "Sophomore", "Biology");
        TutorObject o5 = new TutorObject("Maurice Eggen", "Freshman", "Mathematics");
        TutorObject o6 = new TutorObject("Dustin Nelson", "Senior", "Music");
        tutors.add(o1);
        tutors.add(o2);
        tutors.add(o3);
        tutors.add(o4);
        tutors.add(o5);
        tutors.add(o6);
        
        return tutors;
    }
      
    private class TutorAdapter extends ArrayAdapter<TutorObject>
    {
        private ArrayList<TutorObject> allTutors;
        private TutorNameFilter filter;
        public ArrayList<TutorObject> filtered;
        private LayoutInflater inflater;


        public TutorAdapter(Context context, int textViewResourceId, ArrayList<TutorObject> items)
        {
            super(context, textViewResourceId, items);
            this.allTutors = items;
            this.filtered = this.allTutors;
            inflater= LayoutInflater.from(context);
        }
        @Override
        public View getView(int position, View convertView, ViewGroup parent)
        {
            View v;
            if (convertView == null) {
//                v = mInflater.inflate(resource, parent, false);
            	LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            	v = vi.inflate(R.layout.tutor_row, null);
            } else {
                v = convertView;
            }

//            if (v == null)
//            {
//                LayoutInflater vi = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
//                v = vi.inflate(R.layout.tutor_row, null);
//            }
            TutorObject o = filtered.get(position);
//            Toast.makeText(getApplicationContext(), "o.get: " + o.getName(), Toast.LENGTH_SHORT).show();
            
            if (o != null)
            {
            	TextView tt = (TextView) v.findViewById(R.id.tutorRow_major);
                TextView mt = (TextView) v.findViewById(R.id.tutorRow_name);
                TextView bt = (TextView) v.findViewById(R.id.tutorRow_year);
                ImageView iv = (ImageView) v.findViewById(R.id.tutorRow_icon);
                
                if (tt != null)
                {
                      tt.setText(o.getMajor());
                }
                if (mt != null)
                {
                      mt.setText(o.getName());
                }
                if(bt != null)
                {
                      bt.setText(o.getYear());
                }
                
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
        public void insert(TutorObject object, int index) {
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.add(index, object);
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
        public void remove(TutorObject object) {
        	Toast.makeText(getApplicationContext(), "remove", Toast.LENGTH_LONG).show();
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.remove(object);
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
            if (allTutors != null) {
                synchronized (mLock) {
                    allTutors.clear();
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
//                ArrayList<TutorObject> filt = new ArrayList<TutorObject>();
                
                if (allTutors == null) {
//                	Toast.makeText(getApplicationContext(), "alltutrs = filtered", Toast.LENGTH_LONG).show();
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
//                    ArrayList<TutorObject> lItems = new ArrayList<TutorObject>();
//                    synchronized (allTutors)
//                    {
//                        lItems.addAll(allTutors);
//                    }
//                    for(int i = 0, l = lItems.size(); i < l; i++)
//                    {
//                        TutorObject m = lItems.get(i);
//                        if(m.getName().toLowerCase().contains(constraint))
//                            filt.add(m);
//                    }
                	ArrayList<TutorObject> tutorValues = allTutors;
                	final int count = tutorValues.size();
                	ArrayList<TutorObject> newValues = new ArrayList<TutorObject>();
                	
                	for (int index = 0; index < count; index++)
                	{
                        TutorObject si = allTutors.get(index);
                        if(si.getName().toLowerCase().contains(constraint.toString()) ||
//                        		si.getYear().toLowerCase().contains(constraint.toString()) ||
                        		si.getMajor().toLowerCase().contains(constraint.toString()))
                        {
                          newValues.add(si);  
                        }
                    }

//                	Toast.makeText(getApplicationContext(), "char: " + constraint, Toast.LENGTH_SHORT).show();
                    result.count = newValues.size();
                    result.values = newValues;
                }
                
//                Toast.makeText(getApplicationContext(), "allTutors: '"+ allTutors.size() + "'\n" + "filtered: '"+ filtered.size() + "'\n"  
//                		+ "result.count: '"+ result.count + "'\n" + "result.alue: '"+ result.values + "'\n", Toast.LENGTH_LONG).show();
                return result;
            }
            
            @SuppressWarnings("unchecked")
            @Override
            protected void publishResults(CharSequence constraint, FilterResults results)
            {
                // NOTE: this function is *always* called from the UI thread.
                filtered = (ArrayList<TutorObject>)results.values;
//                clear();
//                for(int i = 0, l = filtered.size(); i < l; i++)
//                    add(filtered.get(i));
                notifyDataSetChanged();
//                notifyDataSetInvalidated();
            }
        }
    }
    
    public class SpecialAdapter extends TutorAdapter
    {    	
    	private int[] colors = new int[] { 0x30ffffff, 0x30808080 };    
    	    
	    private ArrayList<TutorObject> tutors;
	    
	    public SpecialAdapter(Context context, int textViewResourceId, ArrayList<TutorObject> items)
	    {
	    	super(context, textViewResourceId, items);
            this.tutors = items;
    	
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
        switch (item.getItemId())
        {
            case R.id.SearchTutor:
            	InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
            	inputMgr.toggleSoftInput(0, 0);
            	break;
        }
        return true;
    }
}

