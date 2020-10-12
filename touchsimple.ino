
int TouchSensor = 2; //connected to Digital pin D3

void setup(){
  Serial.begin(9600); // Communication speed
  
  pinMode(TouchSensor, INPUT);
}

void loop(){
  if(digitalRead(TouchSensor)==HIGH)       //Read Touch sensor signal
   { 
      // if Touch sensor is HIGH, then turn on
    Serial.println("1");
   }
  else
   {
      // if Touch sensor is LOW, then turn off the led
    Serial.println("0");
   }
  delay(50);} // Slow down the output f
