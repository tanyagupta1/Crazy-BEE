import processing.sound.*;
SoundFile file;
int i, j,k; 
int bonus;
boolean bgstop;
int mode;
boolean readit;
int t=0;

int Score ;
float DistancePlaneBird;
float DistancePlaneMissile;

int Score2 ;
float DistancePlaneBird2;
float DistancePlaneMissile2;


float Hauteur; //en Y
float Angle;
float Hauteur2;
float Angle2;
int DistanceUltra;
int DistanceUltra2;
int IncomingDistance;
int IncomingDistance2;
//float Pas; //pour deplacements X

float BirdX;
float BirdY;
float MissileX;
float MissileY;

//float GrassX ;  //for X position commened




String DataIn;
//incoming data on the serial port
String DataIn2;
String DataIn3;
PImage Bird;
PImage Plane;
PImage Plane2;
PImage Missile;
PImage start;


// serial port config
import processing.serial.*; 
Serial myPort1;    
Serial myPort2;
Serial myPort3;



//preparation
void setup() 
{

    myPort1 = new Serial(this, Serial.list()[1], 9600); 
    myPort1.bufferUntil(10); 
    myPort2=new Serial(this, Serial.list()[2],9600);

     
    //end the reception as it detects a carriage return
    myPort2.bufferUntil(10);
    myPort3=new Serial(this,Serial.list()[3],9600);
    myPort3.bufferUntil(10);

    frameRate(30); 

    size(800, 600);
    rectMode(CORNERS) ; //we give the corners coordinates 
    noCursor(); //why not ?hhhh
    textSize(16);

    Hauteur = 300; //initial plane value
    Hauteur2=400;


    
    Bird = loadImage("coin.jpg");  
    Plane = loadImage("bird.png");  //the new plane picture
    Missile=loadImage("missile.jpg");
    Plane2=loadImage("girl.jpg");
    start=loadImage("bg.jpeg");   
bgstop=true;
   
    


    Score = 0;
    Score2=0;
    bonus=0;
    readit=false;
    file=new SoundFile(this,"Blast.mp3");
}


//incoming data event on the serial port


void serialEvent(Serial myPort) { 
    if (myPort == myPort1) { 
  DataIn = myPort1.readString(); 
    // println(DataIn);

    IncomingDistance = int(trim(DataIn)); //conversion from string to integer

    println(IncomingDistance); //checks....

    if (IncomingDistance>1  && IncomingDistance<100 ) {
        DistanceUltra = IncomingDistance; //save the value only if its in the range 1 to 100     }
    }
}
else if(myPort==myPort2){
DataIn2 = myPort2.readString(); 
    // println(DataIn);

    IncomingDistance2 = int(trim(DataIn2)); //conversion from string to integer

    println(IncomingDistance2); //checks....

    if (IncomingDistance2>1  && IncomingDistance2<100 ) {
        DistanceUltra2 = IncomingDistance2; //save the value only if its in the range 1 to 100     }
    }}
    else if(myPort==myPort3){
    DataIn3=myPort3.readString();
   if(!readit){
   mode=int(trim(DataIn3));
   readit=true;}
   t=1;
    
    }
    
    
    }




//main drawing loop
void draw() 
{   if(bgstop){
    background(start);
    bgstop=false;}
  
  
  if(t!=0){
  if(mode==1){
  background(0, 0, 0);
    ceil();
    //if(Score<1){ceil();
      //fill(5,72,0);
      //text("Level 1",400,30);}
   
    
    //else{ceil2();
  //fill(5,72,0);
  //text("Level 2",400,30);

//}
    
    
  
    fill(5, 72, 0);



    //rect(0, 580, 800, 600); //some grass

    
    //calculates the X grass translation. Same formulae than the bird
   

    

    text(Angle, 10, 30); //debug things...
    text(Hauteur, 10, 60); 
    text(Angle2,700,30);
    text(Hauteur2,700,60);


    //new part : check the distance between the plane and bird and increase the score
    DistancePlaneBird = sqrt(pow((400-BirdX), 2) + pow((Hauteur-BirdY), 2)) ;
     DistancePlaneBird2 = sqrt(pow((400-BirdX), 2) + pow((Hauteur2-BirdY), 2)) ;

    if (DistancePlaneBird < 40) {
        //we hit the bird   
        Score = Score+ 1;
        

        //reset the bird position
        BirdX = 900;
        BirdY = random(600);
    }
    
    if (DistancePlaneBird2 < 40) {
        //we hit the bird   
        Score2 = Score2+ 1;
        file.play();

        //reset the bird position
        BirdX = 900;
        BirdY = random(600);
    }
    
    
    DistancePlaneMissile = sqrt(pow((400-MissileX), 2) + pow((Hauteur-MissileY), 2)) ;
    DistancePlaneMissile2 = sqrt(pow((400-MissileX), 2) + pow((Hauteur2-MissileY), 2)) ;

    if (DistancePlaneMissile < 40) {
        //we hit the bird   
        file.play();
        Score = Score- 2;
        
        fill(5,72,0);
        text("player 2 wins",400,400);
        delay(2000);
        exit();

        //reset the bird position
        MissileX =800;
        MissileY = random(600);
    }
    
     if (DistancePlaneMissile2 < 40) {
        //we hit the bird   
        Score2 = Score2- 2;
        file.play();
        fill(5,72,0);
        text("player1 wins",400,300);
        delay(2000);
        exit();

        //reset the bird position
        MissileX =800;
        MissileY = random(600);
    }

    //here we draw the score
    text("Score :", 200, 30); 
    text( Score, 260, 30); 
text("Score2 :", 500, 40); 
    text( Score2, 560, 40); 


    //Angle = mouseY-300; //uncomment this line and comment the next one if you want to play with the mouse
    Angle = (18- DistanceUltra)*4;  
    // you can increase the 4 value...
    Angle2 = (18- DistanceUltra2)*4; 



    Hauteur = Hauteur + sin(radians(Angle))*10; //calculates the vertical position of the plane
    Hauteur2 = Hauteur2 + sin(radians(Angle2))*10;

    //check the height range to keep the plane on the screen 
    if (Hauteur < 0) {
        Hauteur=0;
    }

    if (Hauteur > 600) {
        Hauteur=600;
    }
    
    if (Hauteur2 < 0) {
        Hauteur2=0;
    }

    if (Hauteur2 > 600) {
        Hauteur2=600;
    }

    TraceAvion(Hauteur, Angle);
    TraceAvion2(Hauteur2,Angle2);



    BirdX = BirdX - cos(radians(Angle))*10;

    if (BirdX < -30) {
        BirdX=800;
        BirdY = random(600);
    }

    
    

    image(Bird, BirdX, BirdY, 59,38); //displays the useless bird. 59 and 38 are the size in pixels of the picture


MissileX = MissileX - cos(radians(Angle))*10;

    if (MissileX < -30) {
        MissileX=900;
        MissileY = random(600);
    }

    
    

    image(Missile, MissileX, MissileY,59, 38); //displays the useless bird. 59 and 38 are the size in pixels of the picture
  }
  
  
  
  if(mode==0)
  {background(0, 0, 0);
    if(Score<1){
     ceil();
      fill(5,72,0);
      text("Level 1",400,30);}
   
    
    else{ceil2();
  fill(5,72,0);
  text("Level 2",400,30);

}
    
    
  
    fill(5, 72, 0);



    //rect(0, 580, 800, 600); //some grass

    
    //calculates the X grass translation. Same formulae than the bird
   

    

    text(Angle, 10, 30); //debug things...
    text(Hauteur, 10, 60); 


    //new part : check the distance between the plane and bird and increase the score
    DistancePlaneBird = sqrt(pow((400-BirdX), 2) + pow((Hauteur-BirdY), 2)) ;

    if (DistancePlaneBird < 40) {
        //we hit the bird   
        Score = Score+ 1;

        //reset the bird position
        BirdX = 900;
        BirdY = random(600);
    }
    
    
    DistancePlaneMissile = sqrt(pow((400-MissileX), 2) + pow((Hauteur-MissileY), 2)) ;

    if (DistancePlaneMissile < 40) {
        //we hit the bird   
        Score = Score- 2;
        file.play();

        //reset the bird position
        MissileX =800;
        MissileY = random(600);
    }

    //here we draw the score
    text("Score :", 200, 30); 
    text( Score, 260, 30); 



    //Angle = mouseY-300; //uncomment this line and comment the next one if you want to play with the mouse
    Angle = (18- DistanceUltra)*4;  // you can increase the 4 value...



    Hauteur = Hauteur + sin(radians(Angle))*10; //calculates the vertical position of the plane

    //check the height range to keep the plane on the screen 
    if (Hauteur < 0) {
        Hauteur=0;
    }

    if (Hauteur > 600) {
        Hauteur=600;
    }

    TraceAvion(Hauteur, Angle);



    BirdX = BirdX - cos(radians(Angle))*10;

    if (BirdX < -30) {
        BirdX=800;
        BirdY = random(600);
    }

    
    

    image(Bird, BirdX, BirdY, 59,38); //displays the useless bird. 59 and 38 are the size in pixels of the picture


MissileX = MissileX - cos(radians(Angle))*10;

    if (MissileX < -30) {
        MissileX=900;
        MissileY = random(600);
    }

    
    

    image(Missile, MissileX, MissileY,59, 38);
    //displays the useless bird. 59 and 38 are the size in pixels of the picture
    
}







  }
}








void ceil(){ noStroke();
    rectMode(CORNERS);

    for  (int i = 1; i < 600; i = i+10) {
        fill( 49   , 118   , 181     );
        rect(0, i, 800, i+10); }}
        
void ceil2(){noStroke();
    rectMode(CORNERS);

    for  (int k = 1; k < 600; k = k+10) {
        fill( 0    +k*0.165, 0  +k*0.118, 0  + k*0.075   );
        rect(0, k, 800, k+10); }}

void TraceAvion(float Y, float AngleInclinasion) {
    //draw the plane at given position and angle

    noStroke();
    pushMatrix();
    translate(400, Y);
    //rotate(radians(AngleInclinaison)); //in degres  ! 


    /*
    Drawing concept :  ;-)
     
     |\___o__
     ________>     
     
     */

    scale(0.5);  //0.2 pas mal

    //unless drawing the plane "by hands", just display the stored picture instead. Note that the parameters 2 and 3 are half the picture size, to make sure that the plane rotates in his center.
    image(Plane, -111, -55, 223, 110); // 223 110 : picture size



    popMatrix(); //end of the rotation matrix
}


void TraceAvion2(float Y, float AngleInclinasion) {
    //draw the plane at given position and angle

    noStroke();
    pushMatrix();
    translate(300, Y);
    //rotate(radians(AngleInclinaison)); //in degres  ! 


    /*
    Drawing concept :  ;-)
     
     |\___o__
     ________>     
     
     */

    scale(0.5);  //0.2 pas mal

    //unless drawing the plane "by hands", just display the stored picture instead. Note that the parameters 2 and 3 are half the picture size, to make sure that the plane rotates in his center.
    image(Plane2, -111, -55, 223, 110); // 223 110 : picture size



    popMatrix(); //end of the rotation matrix
}

//file end
