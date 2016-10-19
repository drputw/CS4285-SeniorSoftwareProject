package seniorsoftware.tutorme;

import android.app.ExpandableListActivity;
import android.os.Bundle;
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

public class FAQ extends ExpandableListActivity
{
	 ExpandableListAdapter mAdapter;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

	        // Set up our adapter
        mAdapter = new InfoExpandableListAdapter();
        setListAdapter(mAdapter);
        registerForContextMenu(getExpandableListView());
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

    public class InfoExpandableListAdapter extends BaseExpandableListAdapter {
        // Sample data set.  children[i] contains the children (String[]) for groups[i].
    	private String[] groups = { "What are the mitigating factors that could influence my sanction if found responsible?",
        		"Who can I talk to about acceptable citations before turning in an assignment?",
        		"What violations are covered by the AHC?",
        		"What happens when a complaint is filed against me?",
        		"What recourse do I have to appeal a sanction?"};
        private String[][] children = {
                {"There are three mitigating factors which could influence your sanction. The first factor is the amount of plagiarism; the second is cooperation before and during a hearing, including entering a plea of responsible; and the third is “extenuating circumstances”.  All of these factors are dependent upon the individual case and may not be used at all if the hearing panel does not find them applicable."},
                {"The easiest way to make sure everything with your assignment is in order is to talk with your professors.  They are the ones grading what you turn in, so they know what they expect.  If the professor is unclear or other ambiguities present themselves, ask questions. You can always email the Honor Council to ask questions about proper citations. Finally, consult a style guide such as the MLA Handbook, or the Writing Center in the library."},
                {"The Academic Honor Council deals strictly with academic integrity violations that occur at any time during any class offered at Trinity.   We have nothing to do with other conduct related violations, such as getting written up for possession of alcohol."},
                {"An email will be sent to you informing you that a complaint has been filed and accepted. Contained within this email will be information regarding the date and time of your hearing.  An advocate-presenter will also get in contact with you to help you prepare for the hearing.  The advocate-presenter is not a legal representative and will only present relevant evidence that you supply."},
                {"Once a sanction has been issued, there are two ways in which a sanction may be appealed. The first is if a procedural error occurred during the hearing; however, two faculty advisors are present during each hearing to call points-of-order, which are designed to prevent such errors from occurring.  The second option is if you discover new evidence or witnesses, which completely changes the nature of the case."}
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

        public TextView getGenericGroupView() {
            AbsListView.LayoutParams lp = new AbsListView.LayoutParams(
                    ViewGroup.LayoutParams.FILL_PARENT, 100);

            TextView textView = new TextView(FAQ.this);
            textView.setLayoutParams(lp);
            textView.setGravity(Gravity.CENTER_VERTICAL | Gravity.CENTER);
            textView.setPadding(50, 0, 0, 0);
            
            return textView;
        }

        public TextView getGenericChildView() {
            // Layout parameters for the ExpandableListView
            AbsListView.LayoutParams lp = new AbsListView.LayoutParams(
                    ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);

            TextView textView = new TextView(FAQ.this);
            textView.setLayoutParams(lp);
            // Center the text vertically
            textView.setGravity(Gravity.CENTER_VERTICAL | Gravity.CENTER);
            // Set the text starting position
            
            return textView;
        }
        
        public View getChildView(int groupPosition, int childPosition, boolean isLastChild,
                View convertView, ViewGroup parent) {
            TextView textView = getGenericChildView();
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
            TextView textView = getGenericGroupView();
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