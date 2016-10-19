package queries;

import generics.TrinityRestQueryGuts;
import generics.TutorObject;

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

import seniorsoftware.tutorme.EditTutor;

public class EditTutorQuery extends TrinityRestQueryGuts {
	
	static final String teamNumber = "11";
	static final String salt = "i,JhN73EA7S1$-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"; 

	public EditTutorQuery(){
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
//			System.out.println("How many? "+ Tutors.tutors.size());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("There was a problem with the xml parsing");
		}
	}
	
	private class StaffHandler extends DefaultHandler{

		private boolean in_row = false;
		private boolean in_field = false;
		private int field = -1;
		private TutorObject tutor;
		private int id = 0;
		private String firstName = null;
		private String lastName = null;
		private String email = null;
		private String phone = null;
		private String rank = null;
		private String major = null;
		private String description = null;
		private String availability = null;
		private String major2 = null;
		private String major3 = null;
		private String major4 = null;

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
				
				tutor = new TutorObject(id, firstName, lastName, rank, major,
						email, phone, description, availability, major2, major3, major4);
				EditTutor.tutor = tutor;
			}
		}

		@Override
		public void characters(char ch[], int start, int length) {

			if(this.in_field == true){
				if(field == 0){
					id = Integer.parseInt(new String(ch, start, length));
					System.out.println("ID: " + id);
					this.in_field = false;
				}
				else if(field == 1){
					firstName = new String(ch, start, length);
					System.out.println("First name: "+ firstName);
					this.in_field = false;
				}
				else if(field == 2){
					lastName = new String(ch, start, length);
					System.out.println("Last name: " + lastName);
					this.in_field = false;
				}
				else if(field == 3){
					email = new String(ch, start, length);
					System.out.println("Email: "+email);
					this.in_field = false;
				}
				else if(field == 4){
					rank = new String(ch, start, length);
					System.out.println("Rank: "+rank);
					this.in_field = false;
				}
				else if(field == 5){
					phone = new String(ch, start, length);
					System.out.println("Phone: "+phone);
					this.in_field = false;
				}
				else if(field == 6){
					description = new String(ch, start, length);
					System.out.println("Description: " + description);
					this.in_field = false;
				}
				else if(field == 7){
					availability = new String(ch, start, length);
					System.out.println("Availability: " + availability);
					this.in_field = false;
				}
				else if(field == 8){
					major = new String(ch, start, length);
					System.out.println("Major: " + major);
					this.in_field = false;
				}
				else if(field == 9){
					major2 = new String(ch, start, length);
					System.out.println("Major2: " + major2);
					this.in_field = false;
				}
				else if(field == 10){
					major3 = new String(ch, start, length);
					System.out.println("Major3: " + major3);
					this.in_field = false;
				}
				else if(field == 11){
					major4 = new String(ch, start, length);
					System.out.println("Major4: " + major4);
					this.in_field = false;
				}
			}
		}
	}
}