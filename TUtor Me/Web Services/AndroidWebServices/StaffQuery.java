package org.trinity.directory;

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

public class StaffQuery extends TrinityRestQueryGuts {
	
	static final String teamNumber = "5";
	static final String salt = "i,JhN73EA7S1$-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"; 

	public StaffQuery(){
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
			System.out.println("How many? "+ StaffList.staffList.size());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("There was a problem with the xml parsing");
		}
		
	}
	
	private class StaffHandler extends DefaultHandler{

		private boolean in_row = false;
		private boolean in_field = false;
		private int field = -1;
		private Person currentFaculty;
		private String firstName = null;
		private String lastName = null;
		private String phone = null;
		private String office = null;
		private String department = null;

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
				currentFaculty = new Person(firstName, lastName, phone, office, department);
				StaffList.staffList.add(currentFaculty);

			}
		}

		@Override
		public void characters(char ch[], int start, int length) {

			if(this.in_field == true){
				if(field == 1){
					lastName = new String(ch, start, length);
					System.out.println("Last name: " + lastName);
					this.in_field = false;
				}
				else if(field == 2){
					firstName = new String(ch, start, length);
					System.out.println("First name: "+ firstName);
					this.in_field = false;
				}
				else if(field == 3){
					phone = new String(ch, start, length);
					System.out.println("Phone: "+phone);
					this.in_field = false;
				}
				else if(field == 5){
					office = new String(ch, start, length);
					System.out.println("Office: "+office);
					this.in_field = false;
				}
				else if(field == 6){
					department = new String(ch, start, length);
					System.out.println("Department: "+department);
					this.in_field = false;
				}
			}
		}

	}
	

}
