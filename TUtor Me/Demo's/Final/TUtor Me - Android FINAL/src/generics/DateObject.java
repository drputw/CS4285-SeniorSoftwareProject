package generics;

import android.widget.DatePicker;
import android.widget.TimePicker;

public class DateObject
{
	private String year;
	private String month;
	private String date;
	private String hour;
	private String minute;
	private String second;
	
	public DateObject(String s)
	{
		year = s.substring(0,4);
		month = s.substring(5,7);
		date = s.substring(8,10);
		hour = s.substring(11,13);
		minute = s.substring(14,16);
		second = s.substring(17);
	}
	
	public DateObject(String y, String m, String d, String h, String mi, String s)
	{
		year = y;
		month = m;
		date = d;
		hour = h;
		minute = mi;
		second = s;
	}
	
	public DateObject(DatePicker dpDate, TimePicker tp)
	{
		year = String.valueOf(dpDate.getYear());
		month = convertDateTime(dpDate.getMonth()+1);
		date = convertDateTime(dpDate.getDayOfMonth());
		hour = convertDateTime(tp.getCurrentHour());
		minute = convertDateTime(tp.getCurrentMinute());
		second = "00";
	}

	public String getYear() {
		return year;
	}
	
	public String getMonth() {
		return month;
	}
	
	public String getDate() {
		return date;
	}
	
	public String getHour() {
		return hour;
	}
	
	public String getMinute() {
		return minute;
	}
	
	public String getSecond() {
		return second;
	}
	
	public String toString() {
		return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
	}
	
	public String getMonthAlpha() {
		if(month.equals("01"))
			return "January";
		if(month.equals("02"))
			return "Febuary";
		if(month.equals("03"))
			return "March";
		if(month.equals("04"))
			return "April";
		if(month.equals("05"))
			return "May";
		if(month.equals("06"))
			return "June";
		if(month.equals("07"))
			return "July";
		if(month.equals("08"))
			return "August";
		if(month.equals("09"))
			return "September";
		if(month.equals("10"))
			return "October";
		if(month.equals("11"))
			return "November";
		if(month.equals("12"))
			return "December";
		return "Something went wrong here....";
	}
	
	public String getFullDate() {
		String s;
		s = getMonthAlpha() + " " + date + "," + year + " ";
		if(Integer.parseInt(hour) / 12 > 0)
			s = s + (Integer.parseInt(hour)-12) + ":" + minute + ":" + second + "pm CDT";
		else
			s = s + hour + ":" + minute + ":" + second + "am CDT";
		return s;
	}
	
	private String convertDateTime(int i)
	{
		String s = String.valueOf(i);
		if(s.length() == 1)
			return "0" + s;
		return s;
	}
}