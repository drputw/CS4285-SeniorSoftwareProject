package generics;

public class StudyObject
{	
	private int id;
    private String eventName;
    private String email;
    private String phone;
    private String firstName;
    private String lastName;
    private String courseNumber;
    private String courseName;
    private String details;
    private String dateStart;
    private String dateEnd;
    private String dateCreated;
    private String location;
    private String subject;
    private int rsvp;
    
    public StudyObject(int $id, String $eventName, String $email, String $phone, String $firstName,
    		String $lastName, String $courseNumber, String $courseName, String $details, String $dateStart,
    		String $dateEnd, String $dateCreated, String $location, String $subject, int $RSVP)
    {
    	id = $id;
    	eventName = $eventName;
        email = $email;
        phone = $phone;
        firstName = $firstName;
        lastName = $lastName;
        courseNumber = $courseNumber;
        courseName = $courseName;
        details = $details;
        dateStart = $dateStart;
        dateEnd = $dateEnd;
        dateCreated = $dateCreated;
        location = $location;
        subject = $subject;
        rsvp = $RSVP;
    }
    
    public int getID() {
    	return id;
    }
    
    public String getEventName() {
    	return eventName;
    }
    public String getEmail() {
    	return email;
    }
    
    public String getPhone() {
    	return phone;
    }
    
    public String getFirstName() {
    	return firstName;
    }
    
    public String getLastName() {
    	return lastName;
    }
    
    public String getOrganizer() {
    	return firstName + " " + lastName;
    }
    
    public String getCourseNumber() {
    	return courseNumber;
    }
    public String getCourseName() {
    	return courseName;
    }
    public String getDetails() {
    	return details;
    }
    
    public String getDateStart() {
    	return dateStart;
    }
    
    public String getDateEnd() {
    	return dateEnd;
    }
    
    public String getDateCreated() {
    	return dateCreated;
    }
    
    public String getLocation() {
    	return location;
    }
    
    public String getSubject() {
    	return subject;
    }
    
    public int getRSVP() {
    	return rsvp;
    }
}