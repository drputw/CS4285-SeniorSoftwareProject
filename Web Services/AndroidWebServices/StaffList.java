package org.trinity.directory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import android.app.Activity;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

public class StaffList extends ListActivity {

	public static ArrayList<Person> staffList = null;
	private static ProgressDialog m_ProgressDialog = null; 
	private static PersonAdapter m_adapter;
	private static Runnable viewStaff = null;
	private static boolean loaded = false;
	
	//the runnable that gets called after the data is returned and parsed
	final Runnable returnRes = new Runnable(){

		public void run() {
			if(staffList != null && staffList.size() > 0){

				System.out.println("Updating adapter");
				System.out.println(staffList.size());
				m_adapter.notifyDataSetChanged();

				m_adapter.sort(new Comparator<Person>(){

					public int compare(Person object1, Person object2) {

						return object1.getLastName().compareToIgnoreCase(object2.getLastName());
					}

				});

			}
			m_ProgressDialog.dismiss();
			m_adapter.notifyDataSetChanged();
			loaded = true;
		}

	};
	
	

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setDefaultKeyMode(DEFAULT_KEYS_SEARCH_LOCAL);

		final String query = "SELECT * FROM test3 ORDER BY LastName";
		final String args = "";
		final Activity act = this;



		if(staffList == null)
			staffList = new ArrayList<Person>();


		ListView lv = getListView();
		lv.setTextFilterEnabled(true);

		if(m_adapter == null)
			m_adapter = new PersonAdapter(this, R.layout.list_item, staffList);

		setListAdapter(m_adapter);

		if(viewStaff == null){
			viewStaff = new Runnable(){

				public void run() {

					try {
						System.out.println("Started viewStaff thread");
						StaffQuery sq = new StaffQuery();
						sq.getInfo(query, args, act, returnRes);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (ParserConfigurationException e) {
						e.printStackTrace();
					} catch (SAXException e) {
						e.printStackTrace();
					}

				}

			};

			Thread thread = new Thread(null, viewStaff, "Background");
			thread.start();
		}


		if(!loaded)
			m_ProgressDialog = ProgressDialog.show(StaffList.this, "Please wait...", "Retrieving data", true);

		lv.setOnItemClickListener(new OnItemClickListener() {
			public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

				Intent i = new Intent(getBaseContext(), DetailView.class);
				i.putExtra("fullName", staffList.get(position).getFullName());
				i.putExtra("Phone", staffList.get(position).getPhoneNumber());
				i.putExtra("Office", staffList.get(position).getOffice());
				i.putExtra("Department", staffList.get(position).getDepartment());
				startActivity(i);

			}
		});
	}

	public void onPause(){

		m_ProgressDialog.dismiss();

		super.onPause();
	}

	//Creating and handling options menu
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle item selection
		switch (item.getItemId()) {
		case R.id.search_button:
			onSearchRequested();
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

	public boolean onSearchRequested(){

		SearchActivity.list = staffList;


		return super.onSearchRequested();
	}

	
}