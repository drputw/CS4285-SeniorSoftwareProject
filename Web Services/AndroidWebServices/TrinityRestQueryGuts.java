package org.trinity.directory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;


import android.app.Activity;

public abstract class TrinityRestQueryGuts {

	private String url;
	private String digest;
	public static  String teamNumber = "";
	public static  String salt = "";
	private static final char[] HEX_CHARS = "0123456789ABCDEF".toCharArray();
	private MessageDigest md;

	
	
	//Connection and parsing:
	public void getInfo(String query, String args, Activity activity, Runnable returnRes) throws IOException, ParserConfigurationException, SAXException{

		System.setProperty("http.keepAlive", "false");
		String url = null;

		try {
			url = getURL(query, args);
			System.out.println(url);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		URL db = null;
		try {
			db = new URL(url);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}

		HttpURLConnection httpconn = (HttpURLConnection) db.openConnection();

		System.out.println("Response code: "+httpconn.getResponseCode());

		if(httpconn.getResponseCode() == HttpURLConnection.HTTP_OK){

			BufferedReader input = new BufferedReader(new InputStreamReader(httpconn.getInputStream()));

			parseXML(input);
		}

		httpconn.disconnect();

		System.out.println("Parsed XML + " + activity.getLocalClassName());

		
		//runs the Runnable that returns the results on the activity that called this method
		activity.runOnUiThread(returnRes);

	}

	public abstract void parseXML(BufferedReader input) throws ParserConfigurationException, SAXException;
	
	
	
	//create the url
	public String getURL(String query, String args) throws URISyntaxException, UnsupportedEncodingException, NoSuchAlgorithmException{

		System.out.println("query: " + query + "... args: " + args);
		
		md = MessageDigest.getInstance("MD5");

		String payload = teamNumber + query + args;

		int lenPl = payload.length();
		if(lenPl > 200){
			payload = payload.substring(0, 200);
			lenPl = 200;
		}

		int lenSalt = 255 - lenPl;
		payload = payload + salt.substring(0, lenSalt);


		try {
			
			digest = md5(payload);
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		System.out.println(digest);

		//https://devsoap.fulgentcorp.com/trinityrestserver.php?teamnumber=", 4, @"&querypart=", query, @"&argpart=", args, @"&hash=", digest
		URI escapedURL = new URI("https","devsoap.fulgentcorp.com","/trinityrestserver.php", "teamnumber="+teamNumber+"&querypart="+query+"&argpart="+args+"&hash="+digest, null);
		url = escapedURL.toASCIIString().replace("+", "%2B");

		return url;
	}

	private String md5(String s) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		//length of digest should be 16
		byte[] bytesOfMessage = s.getBytes("UTF-8");

		md.reset();
		byte[] thedigest = md.digest(bytesOfMessage);

		return asHex(thedigest);
	}



	public static String asHex(byte[] buf)
	{
		char[] chars = new char[2 * buf.length];
		for (int i = 0; i < buf.length; ++i)
		{
			chars[2 * i] = HEX_CHARS[(buf[i] & 0xF0) >>> 4];
			chars[2 * i + 1] = HEX_CHARS[buf[i] & 0x0F];
		}
		return new String(chars);
	}

}
