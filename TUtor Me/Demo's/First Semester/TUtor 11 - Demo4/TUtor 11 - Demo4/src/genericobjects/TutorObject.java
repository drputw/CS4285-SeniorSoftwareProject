package genericobjects;

public class TutorObject
{	
    private String name;
    private String year;
    private String major;
    
    public TutorObject(String $name, String $year, String $major)
    {
    	name = $name;
    	year = $year;
    	major = $major;
    }
    
    public TutorObject()
    {
    	name = "";
    	year = "";
    	major = "";
    }
   
    public String getName()
    {
        return name;
    }
    
    public void setName(String $name)
    {
        this.name = $name;
    }
    public String getYear()
    {
        return year;
    }

    public void setYear(String $year)
    {
        this.year = $year;
    }
    
    public String getMajor()
    {
        return major;
    }

    public void setMajor(String $major)
    {
        this.major = $major;
    }

    public String toString()
    {
    	return this.getName();
    }
}