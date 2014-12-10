package com.example.doctorpatient;

import java.util.List;

import com.example.doctorpatient.AlarmReceiver;
import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
	
	TextView doctorname,address,time;
	String emailadd;
	private AlarmManager alarmMgr;
	private PendingIntent alarmIntent;

	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		
		Intent intent=getIntent();
		emailadd=intent.getStringExtra("emailadd");
		
		
		//Toast.makeText(MainActivity.this, emailadd, Toast.LENGTH_LONG).show(); 
		
		doctorname=(TextView) findViewById(R.id.doctorname);
		address=(TextView) findViewById(R.id.apptaddress);
		time=(TextView) findViewById(R.id.appttime);
		
		Parse.initialize(this, "EatKgcPelVGrhenkne7qVV4k23zSewada6mJe3n8", "Ud1NwMxx36uKt8Bg0phWKS1jvCpK590WoBTy4eg8");
		ParseQuery<ParseObject> query1=ParseQuery.getQuery("DocPatient");
	 	query1.whereEqualTo("patientemail", emailadd);
	 	
	 	
	 	query1.findInBackground(new FindCallback<ParseObject>() {
	 	    public void done(List<ParseObject> senderusernames, ParseException e) {
        
	 	    	if(senderusernames.size()>0)
	 	    	{
	 	    		String doctorid=senderusernames.get(0).getString("doctorid");
	 	    		String date=senderusernames.get(0).getDate("timeofapp").toString();
	 	    		String objectid=senderusernames.get(0).getObjectId();
	 	    		
	 	    		//Add these values to the textviews
	 	    		time.setText("Appointment time : "+date);
	 	    		
	 	    		//Alarm Manager to run a service every 10 minutes
	 	    		alarmMgr = (AlarmManager)MainActivity.this.getSystemService(Context.ALARM_SERVICE);
	 	    		Intent intentnew = new Intent(MainActivity.this, AlarmReceiver.class);
	 	    		intentnew.putExtra("dateapp", date);
	 	    		intentnew.putExtra("objectid", objectid);
	 	            intentnew.putExtra("emailadd", emailadd);
	 	    		
	 	    		alarmIntent = PendingIntent.getBroadcast(MainActivity.this, 0, intentnew, 0);

	 	  		 // setRepeating() lets you specify a precise custom interval--in this case,
	 	  		 // 20 minutes.
	 	    		alarmMgr.setRepeating(AlarmManager.RTC_WAKEUP, System.currentTimeMillis(),
	 	  		         1000*300, alarmIntent);
	 	    		
	 	    		// Got doctor id, now get doctor info
	 	    		ParseQuery<ParseObject> query1=ParseQuery.getQuery("Doctors");
	 	   	 	    query1.whereEqualTo("objectId", doctorid);
	 	   	        
	 	   	 	    query1.findInBackground(new FindCallback<ParseObject>() {
	 	   	 	    public void done(List<ParseObject> senderusernames, ParseException e) {
	 	   	 	    	
	 	   	 	    	if(senderusernames.size()>0)
	 	   	 	    	{
	 	   	 	    String address1=senderusernames.get(0).getString("address");
	 	   	 	    String dname=senderusernames.get(0).getString("dname");
	 	   	 	   
	 	   	 	    
	 	   	 	    address.setText("Appointment Address: "+address1);
	 	   	 	    doctorname.setText("Doctor's Name: "+dname);
	 	   	 	    	}
	 	   	 	    	
	 	   	 	   else
	 	   	 	      {
	 	   	 	       Toast.makeText(MainActivity.this, "No Doctor with this id found", Toast.LENGTH_LONG).show();
	 	   	 	      }
	 	   	 	  }
	 	   	 	 });
	 	    	}   
	 	   	           	
	 	    	
        
	 	    	else
	 	    	{
	 	    		Toast.makeText(MainActivity.this, e.toString(), Toast.LENGTH_LONG).show();
	 	    	}
	 	    }
	 	});
		
		
	}
	
	
}
