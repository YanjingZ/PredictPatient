package com.example.doctorpatient;

import java.util.List;

import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Login extends Activity implements OnClickListener {
	
	EditText email;
	String emailaddress;
	Button enterbutton;

	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
        setContentView(R.layout.login);
       
        /*ActionBar actionBar = getActionBar();
        actionBar.hide();*/
        
        email=(EditText) findViewById(R.id.emailadd);
        
        //Initialize enter button
        enterbutton=(Button) findViewById(R.id.enterbutton);
        
        //Add onClick listener to it
        enterbutton.setOnClickListener(this);
       
		
	}
	
	public void onClick(View v)
	{
		if(v==enterbutton)
		{
			emailaddress=email.getText().toString();
					
			Parse.initialize(this, "EatKgcPelVGrhenkne7qVV4k23zSewada6mJe3n8", "Ud1NwMxx36uKt8Bg0phWKS1jvCpK590WoBTy4eg8");
			ParseQuery<ParseObject> query1=ParseQuery.getQuery("Patients");
		 	query1.whereEqualTo("emailadd", emailaddress);
		 	query1.findInBackground(new FindCallback<ParseObject>() {
		 	    public void done(List<ParseObject> senderusernames, ParseException e) {
	        
		 	    	
		 	    	if(senderusernames.size()>0)
		 	    	{
		 	    		String emailid=senderusernames.get(0).getString("emailadd");
		 	    		Intent mainactivity=new Intent(Login.this, MainActivity.class);
		 	    		
		 	    		   
		 	    		   mainactivity.putExtra("emailadd", emailid);
		 	    		   startActivity(mainactivity);
		 	    		
		 	    	}
	        
		 	    	else
		 	    	{
		 	    		Toast.makeText(Login.this, "Wrong email address", Toast.LENGTH_LONG).show();
		 	    	}
		 	    }
		 	});
		}
	}
	
	
}
