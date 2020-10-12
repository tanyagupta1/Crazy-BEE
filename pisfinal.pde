import processing.sound.*;
SoundFile file;
SoundFile file2;
int i, j,k; 
int bonus;
boolean bgstop;
int mode;
boolean readit;
int t=0;
int displaytime=5000;
int starttime=0;
int Score ;
float DistancePlaneBird;
float DistancePlaneMissile;

int Score2 ;
float DistancePlaneBird2;
float DistancePlaneMissile2;


float Hauteur; 
float Angle;
float Hauteur2;
float Angle2;
int DistanceUltra;
int DistanceUltra2;
int IncomingDistance;
int IncomingDistance2;


float BirdX;
float BirdY;
float MissileX;
float MissileY;






String DataIn;

String DataIn2;
String DataIn3;
PImage Bird;
PImage Plane;
PImage Plane2;
PImage Missile;
PImage start;
//int p=0;


import processing.serial.*; 
Serial myPort1;    
Serial myPort2;
Serial myPort3;




void setup() 
{

    myPort1 = new Serial(this, Serial.list()[0], 9600); 
    myPort1.bufferUntil(10); 
    myPort2=new Serial(this, Serial.list()[1],9600);

     
    
    myPort2.bufferUntil(10);
    myPort3=new Serial(this,Serial.list()[2],9600);
    myPort3.bufferUntil(10);

    frameRate(30); 

    size(800, 600);
    rectMode(CORNERS) ; 
    noCursor(); 
    textSize(16);

    Hauteur = 300; 
    Hauteur2=400;


    
    Bird = loadImage("coin3.png");//image credits-pngriver.com
    Plane = loadImage("bee.png"); //image credits-netclipart.com
    Missile=loadImage("missile5.png");//image credits-azpng.com
    Plane2=loadImage("bee3.png");//image credits-pngmart.com
    start=loadImage("bg.jpeg");   
bgstop=true;
   
    


    Score = 0;
    Score2=0;
    bonus=0;
    readit=false;
    file=new SoundFile(this,"Blast.mp3");//credits-soundbible.com
    file2=new SoundFile(this,"click.mp3");//credits-soundbible.com
}





void serialEvent(Serial myPort) { 
    if (myPort == myPort1) { 
  DataIn = myPort1.readString(); 
    // println(DataIn);

    IncomingDistance = int(trim(DataIn)); 

    println(IncomingDistance); 

    if (IncomingDistance>1  && IncomingDistance<100 ) {
        DistanceUltra = IncomingDistance;      
    }
}
else if(myPort==myPort2){
DataIn2 = myPort2.readString(); 
    

    IncomingDistance2 = int(trim(DataIn2)); 

    println(IncomingDistance2); 

    if (IncomingDistance2>1  && IncomingDistance2<100 ) {
        DistanceUltra2 = IncomingDistance2; 
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
{  background(255,255,255); 
  while(bgstop){//p=1;
  
    background(start);
   if(millis()>displaytime){
    bgstop=false;}
    //if(p==1)
  //delay(5000);
}
  
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



   

    

    text(Angle, 10, 30); 
    text(Hauteur, 10, 60); 
    text(Angle2,700,30);
    text(Hauteur2,700,60);


  
    DistancePlaneBird = sqrt(pow((400-BirdX), 2) + pow((Hauteur-BirdY), 2)) ;
     DistancePlaneBird2 = sqrt(pow((400-BirdX), 2) + pow((Hauteur2-BirdY), 2)) ;

    if (DistancePlaneBird < 40) {
          
        Score = Score+ 1;
        file2.play();
        
        

        
        BirdX = 900;
        BirdY = random(600);
    }
    
    if (DistancePlaneBird2 < 40) {
         
        Score2 = Score2+ 1;
        file2.play();

        
        BirdX = 900;
        BirdY = random(600);
    }
    
    
    DistancePlaneMissile = sqrt(pow((400-MissileX), 2) + pow((Hauteur-MissileY), 2)) ;
    DistancePlaneMissile2 = sqrt(pow((400-MissileX), 2) + pow((Hauteur2-MissileY), 2)) ;

    if (DistancePlaneMissile < 40) {
        //we hit the bird   
        file.play();
        Score = Score- 1;
        
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
        Score2 = Score2- 1;
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


  
    Angle = (18- DistanceUltra)*4;  
    
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

    
    

    image(Bird, BirdX, BirdY, 59,38); //59 and 38 are the size in pixels of the picture


MissileX = MissileX - cos(radians(Angle))*10;

    if (MissileX < -30) {
        MissileX=900;
        MissileY = random(600);
    }

    
    

    image(Missile, MissileX, MissileY,59, 38); //59 and 38 are the size in pixels of the picture
  }
  
  
  
  if(mode==0)
  {background(0, 0, 0);
    if(Score<2){
     ceil();
      fill(5,72,0);
      text("Level 1",400,30);}
   
    
    else{ceil2();
  fill(5,72,0);
  text("Level 2",400,30);

}
    
    
  
    fill(5, 72, 0);



    
   

    

    text(Angle, 10, 30); 
    text(Hauteur, 10, 60); 


    
    DistancePlaneBird = sqrt(pow((400-BirdX), 2) + pow((Hauteur-BirdY), 2)) ;

    if (DistancePlaneBird < 40) {
        //we hit the bird   
        Score = Score+ 1;
        file2.play();

        //reset the bird position
        BirdX = 900;
        BirdY = random(600);
    }
    
    
    DistancePlaneMissile = sqrt(pow((400-MissileX), 2) + pow((Hauteur-MissileY), 2)) ;

    if (DistancePlaneMissile < 40) {
        //we hit the bird   
        Score = Score- 1;
        file.play();

        //reset the bird position
        MissileX =800;
        MissileY = random(600);
    }

    //here we draw the score
    text("Score :", 200, 30); 
    text( Score, 260, 30); 



    
    Angle = (18- DistanceUltra)*4; 



    Hauteur = Hauteur + sin(radians(Angle))*10; 

    
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
    

    scale(0.5);  

    
    image(Plane, -111, -55, 223, 110); 



    popMatrix(); 
}


void TraceAvion2(float Y, float AngleInclinasion) {
    

    noStroke();
    pushMatrix();
    translate(300, Y);
    


    scale(0.5);  

    
    image(Plane2, -111, -55, 223, 110); 



    popMatrix(); 
}

//
