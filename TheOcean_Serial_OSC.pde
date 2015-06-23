/*
* oscP5 library by Andreas Schlegel
* oscP5 website at http://www.sojamo.de/oscP5
*/
import oscP5.*;
import netP5.*;

import processing.serial.*;
//import cc.arduino.*;
//
//Arduino arduino;
  
OscP5 oscP5;
NetAddress myRemoteLocation;
int val = 0;
Serial myPort;

void setup() {
  size(400,400);
  //frameRate(10);
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",2000);
//  arduino = new Arduino(this, Arduino.list()[7], 9600);
  println(Serial.list());
  String portName = Serial.list()[7];
  myPort = new Serial(this, portName, 9600);
}


void draw() {
  background(0);  
  //float flexiforceSensor = arduino.analogRead(0);
  if (myPort.available() > 0)
    val = myPort.read();
  println(val);
  sendValue(val);
}

void sendValue(float sensorValue) {
  OscMessage oscMess = new OscMessage("/breathdata");
  oscMess.add(sensorValue);
  oscP5.send(oscMess, myRemoteLocation); 
}
