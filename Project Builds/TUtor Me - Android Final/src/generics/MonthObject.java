package generics;

public class MonthObject
{	
    private int id;
    private String start;
    private String end;
    private String description;
    
    public MonthObject(int $id, String $start, String $end, String $description)
    {
    	id = $id;
    	start = $start;
    	end = $end;
    	description = $description;
    }
    
    public MonthObject()
    {
    	start = "";
    	end = "";
    	description = "";
    }
   
    public int getName()
    {
        return id;
    }
    
    public void setID(int $id)
    {
        this.id = $id;
    }
    
    public String getStartDate()
    {
        return start;
    }

    public String toString()
    {
    	return this.getDescription();
    }

	public String getEnd() {
		return end;
	}
	
	public String getDescription() {
		return description;
	}
}