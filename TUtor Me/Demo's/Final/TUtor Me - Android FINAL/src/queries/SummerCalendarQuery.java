package queries;

import generics.MonthObject;
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

import seniorsoftware.tutorme.SummerCalendar;

public class SummerCalendarQuery extends TrinityRestQueryGuts {
	
	static final String teamNumber = "11";
	static final String salt = "i,JhN73EA7S1$-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"; 

	public SummerCalendarQuery(){
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
			System.out.println("How many? "+ SummerCalendar.may.size());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("There was a problem with the xml parsing");
		}
	}
	
	private class StaffHandler extends DefaultHandler{

		private boolean in_row = false;
		private boolean in_field = false;
		private int field = -1;
		private String month;
		private int id;
		private String begin;
		private String end;
		private String description;

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
				
				if(month.equals("May"))
					SummerCalendar.may.add(new MonthObject(id, begin, end, description));
				if(month.equals("June"))
					SummerCalendar.june.add(new MonthObject(id, begin, end, description));
				if(month.equals("July"))
					SummerCalendar.july.add(new MonthObject(id, begin, end, description));
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
				if(field == 1){
					month = new String(ch, start, length);
					System.out.println("Month: "+ month);
					this.in_field = false;
				}
				if(field == 2){
					begin = new String(ch, start, length);
					System.out.println("Start: "+ start);
					this.in_field = false;
				}
				if(field == 3){
					end = new String(ch, start, length);
					System.out.println("Category: "+ end);
					this.in_field = false;
				}
				if(field == 4){
					description = new String(ch, start, length);
					System.out.println("Description: "+ description);
					this.in_field = false;
				}
			}
		}
	}
}