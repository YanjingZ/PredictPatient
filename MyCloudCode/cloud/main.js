// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
//response.success("Hello world!");
var Mailgun = require('mailgun');
Mailgun.initialize('sandbox5628ca1816ee4ed789c00b27974ba171.mailgun.org', 'key-810c54eac8b4fc9ccb8664b26c9462d8');
//response.success("OK1");
Mailgun.sendEmail({
  to: "yz785@cornell.edu",
  from: "Mailgun@CloudCode.com",
  subject: "Hello from Cloud Code!",
  text: "Using Parse and Mailgun is great!"
}, {
  success: function(httpResponse) {
    console.log(httpResponse);
    response.success("Email sent!");
  },
  error: function(httpResponse) {
    console.error(httpResponse);
    response.error("Uh oh, something went wrong");
  }
});
//response.success("OK2");

});

Parse.Cloud.afterSave("Patients", function(request,response) {
//response.success("Hello world!");
if (!request.object.get("emailadd")) {
  response.error();
} else {
  var email = request.object.get("emailadd");
}

var Mailgun = require('mailgun');
Mailgun.initialize('sandbox5628ca1816ee4ed789c00b27974ba171.mailgun.org', 'key-810c54eac8b4fc9ccb8664b26c9462d8');
//response.success("OK1");
Mailgun.sendEmail({
  to: email,
  from: "Dr.GeofferyPeterson@CloudCode.com",
  subject: "Appointment Confirmation from Dr. Geoffery Peterson",
  text: "Hello,\n\nThank you for registration!\n\nPlease click the link below to finish registration and download/launch Appointment.\n\nhttp://198.57.247.154/~surya403/DoctorPatient.apk\n\n\n"
}, {
  success: function(httpResponse) {
    console.log(httpResponse);
  },
  error: function(httpResponse) {
    console.error(httpResponse);
  }
});
//response.success("OK2");
});

