package generics;

import seniorsoftware.tutorme.HomePage;

public class TutorObject
{
	private int id;
	private String firstName;
    private String lastName;
    private String year;
    private String major;
    private String major2;
    private String major3;
    private String major4;
    private String email;
    private String phone;
    private String description;
    private String availability;
    
    public TutorObject(int $id, String $firstName, String $lastName, String $year, 
    		String $major, String $email, String $phone, String $description, String $availability, 
    		String $major2, String $major3, String $major4)
    {
    	id = $id;
    	firstName = $firstName;
    	lastName = $lastName;
    	year = $year;
    	major = $major;
    	email = $email;
    	phone = $phone;
    	description = $description;
    	availability = $availability;
    	major2 = $major2;
    	major3 = $major3;
    	major4 = $major4;
    }
    
    public TutorObject()
    {
    	id = Integer.parseInt(HomePage.userID);
    	firstName = "";
    	lastName = "";
    	year = "";
    	major = "";
    	email = "";
    	phone = "";
    	description = "";
    	availability = "";
    	major2 = "";
    	major3 = "";
    	major4 = "";
    }
    
    public int getID() {
    	return id;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public String getYear() {
        return year;
    }

    public String getMajor() {
        return major;
    }

    public String toString() {
    	return firstName + " " + lastName;
    }

	public String getEmail() {
		return email;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public String getDescription() {
		return description;
	}
	
	public String getAvailability() {
		return availability;
	}
	
	public String getMajor2() {
		return major2;
	}
	
	public String getMajor3() {
		return major3;
	}
	
	public String getMajor4() {
		return major4;
	}
}