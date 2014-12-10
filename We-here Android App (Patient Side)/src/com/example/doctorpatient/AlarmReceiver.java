package com.example.doctorpatient;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.location.LocationManager;
import android.support.v4.app.NotificationCompat;


public class AlarmReceiver extends BroadcastReceiver
{
	
	String objectidnew,dateappnew,userid,type,emailadd;
	double latitudenew,longitudenew;
	int mNotificationId = 001;
	static int i=0;
	
         @Override
            public void onReceive(Context context, Intent intent)
            {
                    // TODO Auto-generated method stub
        	 
        	 dateappnew=intent.getStringExtra("dateapp");
        	 objectidnew=intent.getStringExtra("objectid");
        	 emailadd=intent.getStringExtra("emailadd");
        	 
        	 SimpleDateFormat sdf  = new SimpleDateFormat("EEE MMM dd kk:mm:ss z yyyy");
        	 Date date;
			try {
				 date = sdf.parse(dateappnew);
				
				 long appttime = date.getTime(); 
				 long currenttime=System.currentTimeMillis();
				 
				 System.out.println("Appointment Time "+appttime);
	        	 System.out.println("Current Time" +currenttime);
				 System.out.println((appttime-currenttime)/(60 * 60 * 1000));
	        	 if( ((appttime-currenttime)/(60 * 60 * 1000))<=2)
	        	 {
	        		 Parse.initialize(context, "EatKgcPelVGrhenkne7qVV4k23zSewada6mJe3n8", "Ud1NwMxx36uKt8Bg0phWKS1jvCpK590WoBTy4eg8"); 
	            	 
	            	 LocationManager lm = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
	                 Location location = lm.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);

	      		    
	      		     if(location != null)
	      		    { 
	      		    latitudenew = location.getLatitude();
	      		    longitudenew = location.getLongitude();
	      		    }
	      		     
	      		     if(i==0)
	      		   { Intent resultIntent = new Intent(context, MainActivity.class);
	      		   resultIntent.putExtra("emailadd", emailadd);
	      		
	      		 PendingIntent resultPendingIntent =
	      		     PendingIntent.getActivity(
	      		     context,
	      		     0,
	      		     resultIntent,
	      		     PendingIntent.FLAG_UPDATE_CURRENT
	      		 );
	      		     
	      		     
	      		   NotificationCompat.Builder mBuilder =
						    new NotificationCompat.Builder(context)
						    .setSmallIcon(R.drawable.ic_launcher)
						    .setContentTitle("Appointment Reminder!")
						    .setContentText("Your Appointment is in less than 3 hours.");
					
	      		 mBuilder.setContentIntent(resultPendingIntent);
					NotificationManager mNotifyMgr = 
					        (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
					// Builds the notification and issues it.
					mNotifyMgr.notify(mNotificationId, mBuilder.build());
					i++;
	      		   }
	            	 
	      		   System.out.println("objectidnew"+objectidnew);
	            	
	            		ParseQuery<ParseObject> query = ParseQuery.getQuery("DocPatient");
	            	    	 
	                 	    // Retrieve the object by id
	                 	      query.getInBackground(objectidnew, new GetCallback<ParseObject>() {
	                 	      public void done(ParseObject docpat, ParseException e) {
	                 	        if (e == null) 
	                 	        {
	                 	        	System.out.println("lat"+latitudenew);
	                 	        	System.out.println("long"+longitudenew);
	                 	          docpat.put("latitude",String.valueOf(latitudenew));
	                 	          docpat.put("longitude",String.valueOf(longitudenew));
	                 	         
	                 	          docpat.saveInBackground();
	                 	        }
	                 	        
	                 	        else
	                 	        {
	                 	        	System.out.println("Error inside need help is "+e.toString());
	                 	        }
	                 	      }
	                 	    });
	        		 
	        		 
	        	 }
			} catch (java.text.ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
        	
        	
        
        	
        	 
        	 
        	
        	 
 
           }    
}