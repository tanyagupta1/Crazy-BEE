import processing.sound.*;
SoundFile file;
int i, j,k; 

int Score ;
float DistancePlaneBird;
float DistancePlaneMissile;


float Hauteur; //en Y
float Angle;
int DistanceUltra;
int IncomingDistance;
//float Pas; //pour deplacements X

float BirdX;
float BirdY;
float MissileX;
float MissileY;

//float GrassX ;  //for X position commened




String DataIn; //incoming data on the serial port
PImage Bird;
PImage Plane;
PImage Missile;


// serial port config
import processing.serial.*; 
Serial myPort;    



//preparation
void setup() 
{

    myPort = new Serial(this, Serial.list()[1], 9600); 

    myPort.bufferUntil(10);   //end the reception as it detects a carriage return

    frameRate(30); 

    size(800, 600);
    rectMode(CORNERS) ; //we give the corners coordinates 
    noCursor(); //why not ?
    textSize(16);

    Hauteur = 300; //initial plane value


    
    Bird = loadImage("coin.jpg");  
    Plane = loadImage("bird.png");  //the new plane picture
    Missile=loadImage("missile.jpg");
       

   
    


    Score = 0;
    file=new SoundFile(this,"Blast.mp3");
}


//incoming data event on the serial port


void serialEvent(Serial p) { 
    DataIn = p.readString(); 
    // println(DataIn);

    IncomingDistance = int(trim(DataIn)); //conversion from string to integer

    println(IncomingDistance); //checks....

    if (IncomingDistance>1  && IncomingDistance<100 ) {
        DistanceUltra = IncomingDistance; //save the value only if its in the range 1 to 100     }
    }
}



//main drawing loop
void draw() 
{
    background(0, 0, 0);
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

    
    

    image(Missile, MissileX, MissileY,59, 38); //displays the useless bird. 59 and 38 are the size in pixels of the picture
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

//file end
