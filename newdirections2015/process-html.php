<?php
header( "refresh:7;url=http://www2.maths.ox.ac.uk/new.direction2015/Registration/" );
@extract($_POST);
$admin = 'townsend@maths.ox.ac.uk'; // Change to your admin email 'from' address
$subject = 'Conference Preregistration'; //Your email subject
$name = stripslashes($name); //can be stripslashes('name');
$email = stripslashes($email);
// Your HTML message with table, links and images
$message = '<p>Thank you for preregistrating for the conference: New directions in numerical computation, 25-28 August 2015: In celebration of Trefethens 60th birthday. <p> We will be back in touch shortly. 
<p> Alex Townsend'; 
// To send HTML mail, the Content-type header must be set
$headers = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
// Additional headers as http://php.net/manual/en/function.mail.php
$headers .= 'From: <townsend@maths.ox.a.cuk>' . "\r\n";
//ACTIVE mail below to $admin (you) and $email (the other person)
mail( $admin, "$subject", "$name $email", "From: $admin" );
$send_contact=mail( "$name <$email>", "New directions: preregistration", $message, $headers );
if($send_contact){
echo "Thanks, " . $name. ". We will be in touch shortly. Redirecting back to registration page.";
}
else {
echo "Sorry, unable to send. There seems to be a problem with the email address. Please try again.";
}
?>
