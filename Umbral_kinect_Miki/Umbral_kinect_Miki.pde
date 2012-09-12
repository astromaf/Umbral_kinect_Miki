
//Control de Robots mediante KINECT
//Based on Danield Shiffman Library

import org.openkinect.*;
import org.openkinect.processing.*;
import processing.serial.*;

KinectTracker tracker;
Kinect kinect;
Serial myPort;

float deg = 15; //gTilt kinect
float pausa=0;

//////////////////////////////////////////
void setup() {
  size(640,520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  myPort=new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\r');
  
   kinect.tilt(deg);
}//fin setup

//////////////////////////////////////////

void draw() {
  background(255);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

  // Let's draw the raw location
/*  PVector v1 = tracker.getPos();
  fill(50,100,250,200);
  noStroke();
  ellipse(v1.x,v1.y,20,20);*/

 // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(#CE9C1D);
  noStroke();
  ellipse(v2.x,v2.y,20,20);
  
  mando(v2.x,v2.y);
  //mando2(v2.x,v2.y);
  
  //Circulos de control
  noFill();
  smooth();
  stroke(#363EB9);
  strokeWeight(4);
  ellipse(320,60,100,100); //Arriba
   ellipse(320,420,100,100); //Abajo
    ellipse(100,260,100,100);//derecha
     ellipse(540,260,100,100);//Izquierda
  

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("Derecha/Izquierda Umbral: " + t + "    " +  "framerate: " + (int)frameRate + "    " ,10,500);
   text("Arriba/Abajo  Tilt:  "+deg+"                                                                                                     ROBCIB              Miki :) ",10, 515);
   
   
   
   
}//Draw

void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == RIGHT) {
      t+=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == LEFT) {
      t-=5;
      tracker.setThreshold(t);
    }
    else if (keyCode == UP) {
      deg++;
    } 
    else if (keyCode == DOWN) {
      deg--;
    }
    
    deg = constrain(deg,0,30);
   
    kinect.tilt(deg);
   
  }
}

void stop() {
  tracker.quit();
  super.stop();
}



void mando(float vx, float vy) {
  
      
    if((vx > 50) && (vx<150) && (vy>210) && (vy<310)){
    //izquierda
     fill(#FF0000,160);
    ellipse(100,260,100,100);//derecha
    myPort.write('p');
    
    }  
     if((vx > 490) && (vx<590) && (vy>210) && (vy<310)){
    //Derecha
     fill(#0E12E0,160);
    ellipse(540,260,100,100);//Izquierda
    myPort.write('o');
    }
    
    
    if((vx>270) && (vx<370)&& (vy > 60) && (vy<160)){
    //Arriba
     fill(#24790B,160);
    ellipse(320,60,100,100); //Arriba
    myPort.write('q');
    }
    
     if((vx>270) && (vx<370) && (vy > 370) && (vy<470)){
    //Abajo
    fill(#D87614,160);
    ellipse(320,420,100,100); //Abajo
    myPort.write('a');
    }
    
    if((vx>160) && (vx<370)&& (vy > 160) && (vy<360)){
    //parar
    // fill(#24790B,160);
    //ellipse(320,60,100,100); //Arriba
    myPort.write(' ');
    }
    
   

 noFill();
 myPort.clear();

}



////////////////PintoBOT/////////////

void mando2(float vx, float vy) {
  
   if ((millis()>pausa)) {
      pausa=millis()+200;
      
          if((vx > 50) && (vx<150) && (vy>210) && (vy<310)){
         
           fill(#FF0000,160);
          ellipse(100,260,100,100);//derecha
          myPort.write('D');
          
          }  
           if((vx > 490) && (vx<590) && (vy>210) && (vy<310)){
         
           fill(#0E12E0,160);
          ellipse(540,260,100,100);//Izquierda
          myPort.write('C');
          }
          
          
          if((vx>270) && (vx<370)&& (vy > 60) && (vy<160)){
          //Arriba
           fill(#24790B,160);
          ellipse(320,60,100,100); //Arriba
          myPort.write('A');
          }
          
           if((vx>270) && (vx<370) && (vy > 370) && (vy<470)){
          //Abajo
          fill(#D87614,160);
          ellipse(320,420,100,100); //Abajo
          myPort.write('B');
          }
          
        /*  if((vx>160) && (vx<370)&& (vy > 160) && (vy<360)){
          //parar
          // fill(#24790B,160);
          //ellipse(320,60,100,100); //Arriba
          myPort.write(' ');
          }*/   
   
   }
   
 noFill();
 myPort.clear();

}

