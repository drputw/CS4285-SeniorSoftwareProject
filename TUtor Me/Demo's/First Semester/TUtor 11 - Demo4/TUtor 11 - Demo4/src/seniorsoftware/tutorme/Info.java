package seniorsoftware.tutorme;

import android.app.ExpandableListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.Gravity;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseExpandableListAdapter;
import android.widget.ExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.ExpandableListView.ExpandableListContextMenuInfo;
import android.widget.TextView;
import android.widget.Toast;

public class Info extends ExpandableListActivity
{
	 ExpandableListAdapter mAdapter;

	    @Override
	    public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState);

	        // Set up our adapter
	        mAdapter = new InfoExpandableListAdapter();
	        setListAdapter(mAdapter);
	        registerForContextMenu(getExpandableListView());
	    }
	    
	    public boolean onChildClick(ExpandableListView parent, View v, int groupPosition, int childPosition, long id) 
	    {
	    	final Intent fallCalendarIntent = new Intent().setClass(this, FallCalendar.class);
	        if((groupPosition == 0) && (childPosition == 0))
	        	startActivity(fallCalendarIntent);
	        
	        final Intent springCalendarIntent = new Intent().setClass(this, SpringCalendar.class);
	        if((groupPosition == 0) && (childPosition == 1))
	        	startActivity(springCalendarIntent);
	        
	        final Intent theCodeIntent = new Intent().setClass(this, TheCode.class);
	        if((groupPosition == 1) && (childPosition == 0))
	        	startActivity(theCodeIntent);
	        
	        final Intent backgroundIntent = new Intent().setClass(this, TheCodeBackground.class);
	        if((groupPosition == 1) && (childPosition == 1))
	        	startActivity(backgroundIntent);
	        
	        final Intent faqIntent = new Intent().setClass(this, FAQ.class);
	        if((groupPosition == 1) && (childPosition == 2))
	        	startActivity(faqIntent);
	        
	        return false;
	    }

	    @Override
	    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenuInfo menuInfo) {
	        menu.setHeaderTitle("Sample menu");
	        menu.add(0, 0, 0, R.string.hello);
	    }

	    @Override
	    public boolean onContextItemSelected(MenuItem item) {
	        ExpandableListContextMenuInfo info = (ExpandableListContextMenuInfo) item.getMenuInfo();

	        String title = ((TextView) info.targetView).getText().toString();

	        int type = ExpandableListView.getPackedPositionType(info.packedPosition);
	        if (type == ExpandableListView.PACKED_POSITION_TYPE_CHILD) {
	            int groupPos = ExpandableListView.getPackedPositionGroup(info.packedPosition); 
	            int childPos = ExpandableListView.getPackedPositionChild(info.packedPosition); 
	            Toast.makeText(this, title + ": Child " + childPos + " clicked in group " + groupPos,
	                    Toast.LENGTH_SHORT).show();
	            return true;
	        } else if (type == ExpandableListView.PACKED_POSITION_TYPE_GROUP) {
	            int groupPos = ExpandableListView.getPackedPositionGroup(info.packedPosition); 
	            Toast.makeText(this, title + ": Group " + groupPos + " clicked", Toast.LENGTH_SHORT).show();
	            return true;
	        }

	        return false;
	    }

	    /**
	     * A simple adapter which maintains an ArrayList of photo resource Ids. 
	     * Each photo is displayed as an image. This adapter supports clearing the
	     * list of photos and adding a new photo.
	     *
	     */
	    public class InfoExpandableListAdapter extends BaseExpandableListAdapter {
	        // Sample data set.  children[i] contains the children (String[]) for groups[i].
	        private String[] groups = { "Academic Calandar", "Honor Code" };
	        private String[][] children = {
	                { "Fall 2011", "Spring 2012"},
	                { "The Code", "Philosophy and Background", "FAQ" }
	        };

	        public Object getChild(int groupPosition, int childPosition) {
	            return children[groupPosition][childPosition];
	        }

	        public long getChildId(int groupPosition, int childPosition) {
	            return childPosition;
	        }

	        public int getChildrenCount(int groupPosition) {
	            return children[groupPosition].length;
	        }

	        public TextView getGenericView() {
	            // Layout parameters for the ExpandableListView
	            AbsListView.LayoutParams lp = new AbsListView.LayoutParams(
	                    ViewGroup.LayoutParams.MATCH_PARENT, 50);

	            TextView textView = new TextView(Info.this);
	            textView.setLayoutParams(lp);
	            // Center the text vertically
	            textView.setGravity(Gravity.CENTER_VERTICAL | Gravity.LEFT);
	            // Set the text starting position
	            textView.setPadding(50, 0, 0, 0);
	            
	            return textView;
	        }

	        public View getChildView(int groupPosition, int childPosition, boolean isLastChild,
	                View convertView, ViewGroup parent) {
	            TextView textView = getGenericView();
	            textView.setText(getChild(groupPosition, childPosition).toString());
	            return textView;
	        }

	        public Object getGroup(int groupPosition) {
	            return groups[groupPosition];
	        }

	        public int getGroupCount() {
	            return groups.length;
	        }

	        public long getGroupId(int groupPosition) {
	            return groupPosition;
	        }

	        public View getGroupView(int groupPosition, boolean isExpanded, View convertView,
	                ViewGroup parent) {
	            TextView textView = getGenericView();
	            textView.setText(getGroup(groupPosition).toString());
	            return textView;
	        }

	        public boolean isChildSelectable(int groupPosition, int childPosition) {
	            return true;
	        }

	        public boolean hasStableIds() {
	            return true;
	        }
	    }
    }