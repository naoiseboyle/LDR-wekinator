//Simple sketch for sendinf arduino serial over OSC to wekinator

import processing.serial.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

Serial myPort;  // Create object from Serial class
String val;  // Data received from the serial port
float num;

void setup()
{
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9600);
  dest = new NetAddress("127.0.0.1",6448);

}

void draw()
{
  if ( myPort.available() > 0) // If data is available,
  {  // If data is available,
  val = myPort.readStringUntil('\n'); // read it and store it in val
  num = float(val);
  println(num); //print it out in the console
  sendOsc();
  } 
  delay(500);
}


void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(num);
  oscP5.send(msg, dest);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 
}