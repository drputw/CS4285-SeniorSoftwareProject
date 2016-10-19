package queries;

import generics.StudyObject;
import generics.TrinityRestQueryGuts;

import java.io.BufferedReader;
import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

import seniorsoftware.tutorme.Study;

public class EventsQuery extends TrinityRestQueryGuts {
	
	static final String teamNumber = "11";
	static final String salt = "i,JhN73EA7S1$-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"; 

	public EventsQuery(){
		TrinityRestQueryGuts.salt = salt;
		TrinityRestQueryGuts.teamNumber = teamNumber;
	}
	
	@Override
	public void parseXML(BufferedReader input)
			throws ParserConfigurationException, SAXException {
		
		SAXParserFactory spf = SAXParserFactory.newInstance();
		SAXParser sp = spf.newSAXParser();
		XMLReader xr = sp.getXMLReader();
		
		StaffHandler fh = new StaffHandler();
		xr.setContentHandler(fh);

		try {
			xr.parse(new InputSource(input));
			System.out.println("How many? "+ Study.study.size());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("There was a problem with the xml parsing");
		}
		
	}
	
	private class StaffHandler extends DefaultHandler{

		private boolean in_row = false;
		private boolean in_field = false;
		private int field = -1;
		private StudyObject events;
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

		@Override
		public void startDocument() throws SAXException {
			//Nothing to do
		}

		@Override
		public void endDocument() throws SAXException {
			// Nothing to do
		}

		@Override
		public void startElement(String namespaceURI, String localName,
				String qName, Attributes atts) throws SAXException {

			if (localName.equals("row")) {
				this.in_row = true;
			}else if (this.in_row == true) {
				this.in_field = true;
				field++;
			}
		}

		@Override
		public void endElement(String namespaceURI, String localName, String qName)
		throws SAXException {

			if (localName.equals("row")) {
				this.in_row = false;
				field = -1;
				events = new StudyObject(id, eventName, email, phone, firstName,
			    		lastName, courseNumber, courseName, details, dateStart,
			    		dateEnd, dateCreated, location, subject, rsvp);
				Study.study.add(events);
			}
		}

		@Override
		public void characters(char ch[], int start, int length) {

			if(this.in_field == true){
				if(field == 0){
					id = Integer.parseInt(new String(ch, start, length));
					System.out.println("ID: "+ id);
					this.in_field = false;
				}
				if(field == 7){
					eventName = new String(ch, start, length);
					System.out.println("Event Name: "+ eventName);
					this.in_field = false;
				}
				else if(field == 1){
					email = new String(ch, start, length);
					System.out.println("Email: "+email);
					this.in_field = false;
				}
				else if(field == 2){
					phone = new String(ch, start, length);
					System.out.println("Phone: "+phone);
					this.in_field = false;
				}
				else if(field == 3){
					firstName = new String(ch, start, length);
					System.out.println("First name: " + firstName);
					this.in_field = false;
				}
				else if(field == 4){
					lastName = new String(ch, start, length);
					System.out.println("Last name: " + lastName);
					this.in_field = false;
				}
				else if(field == 5){
					courseNumber = new String(ch, start, length);
					System.out.println("Course Number: " + courseNumber);
					this.in_field = false;
				}
				else if(field == 6){
					courseName = new String(ch, start, length);
					System.out.println("Course Name: " + courseName);
					this.in_field = false;
				}
				else if(field == 8){
					details = new String(ch, start, length);
					System.out.println("Details: " + details);
					this.in_field = false;
				}
				else if(field == 9){
					dateStart = new String(ch, start, length);
					System.out.println("Start Date: " + dateStart);
					this.in_field = false;
				}
				else if(field == 10){
					dateEnd = new String(ch, start, length);
					System.out.println("End Date: " + dateEnd);
					this.in_field = false;
				}
				else if(field == 11){
					dateCreated = new String(ch, start, length);
					System.out.println("Created Date: " + dateCreated);
					this.in_field = false;
				}
				else if(field == 12){
					location = new String(ch, start, length);
					System.out.println("Location: " + location);
					this.in_field = false;
				}
				else if(field == 13){
					subject = new String(ch, start, length);
					System.out.println("Subject: " + subject);
					this.in_field = false;
				}
				else if(field == 14){
					rsvp = Integer.parseInt(new String(ch, start, length));
					System.out.println("RSVP: " + rsvp);
					this.in_field = false;
				}
			}
		}
	}
}