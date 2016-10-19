package genericobjects;

import java.util.Date;

public class StudyObject
{	
    private String classNumber;
    private String className;
    private String organizer;
    private String loc;
    private int month;
    private int date;
    private int year;
    private int hour;
    private int min;
    
    public StudyObject(String $classNumber, String $className, String $organizer, String $loc, int $month, int $date, int $year, int $hour, int $min)
    {
    	classNumber = $classNumber;
    	className = $className;
    	organizer = $organizer;
    	loc = $loc;
    	month = $month;
    	date = $date;
    	year = $year;
    	hour = $hour;
    	min = $min;
    	
    }
    
//    public StudyObject(String string, String string2, String string3, int i, int j, int k)
//    {
//    	classNumber = "";
//    	className = "";
//    	organizer = "";
//    	month = 0;
//    	date = 0;
//    	year = 0;
//    	
//    }
//   
    public String getClassNumber()
    {
        return classNumber;
    }
    
    public void setClassNumber(String $classNumber)
    {
        this.classNumber = $classNumber;
    }
    
    public String getClassName()
    {
        return className;
    }
	    
    public void setClassName(String $className)
    {
        this.className = $className;
    }
    
    public String getOrganizer()
    {
        return organizer;
    }
	    
    public void setOrganizer(String organizer)
    {
        this.organizer = organizer;
    }
    
    public int getMonth() {
    	return month;
    }
 
    public void setMonth(int month) {
    	this.month = month;
    }
    
    public int getDate() {
    	return date;
    }
    
    public void setDate(int date) {
    	this.date = date;
    }
    
    public int getYear() {
    	return year;
    }
    
    public void setYear(int year) {
    	this.year = year;
    }

    public int getHour() {
    	return hour;
    }
    
    public void setHour(int hour) {
    	this.hour = hour;
    }
    
    public int getMin() {
    	return min;
    }
    
    public void setMin(int min) {
    	this.min = min;
    }
    
    public String getLoc() {
    	return loc;
    }
    
    public void setLoc(String loc) {
    	this.loc = loc;
    }
    
//    public int getAttending() {
//    	return attending;
//    }
//    
//    public void setAttending() {
//    	this.attending++;
//    }
	
}