/*
  Simple Audio Player

  Demonstrates the use of the Audio library for the Arduino Due

  Hardware required :
  SD card reader with CS on pin 4
  A sound file named "test.wav" in the root directory of the SD card
  An audio amplifier to connect to the DAC0 and ground
  A speaker to connect to the audio amplifier

  Original by Massimo Banzi September 20, 2012
  Modified by Scott Fitzgerald October 19, 2012
  Changed for NightCoreThis by Brecht Carlier January 6, 2016

  This example code is in the public domain
  http://www.arduino.cc/en/Tutorial/SimpleAudioPlayer

*/

//Include libraries
//SD => Reading SD card
//SPI => Communicate with SD card
//Audio => Playing WAV files on DAC
#include <SD.h>
#include <SPI.h>
#include <Audio.h>

void setup() {
  //Start UART @ 115200 baud rate
  Serial.begin(115200);

  //Setup SD-card
  Serial.print("Initializing SD card...");
  //"Start" SD Card => SPI intitializing, ...
  //Pin 4 is the CS pin
  if (!SD.begin(4)) {
    Serial.println(" failed!");
    return;
  }
  Serial.println(" done.");
  // hi-speed SPI transfers
  SPI.setClockDivider(4);

  //Mono: 44100Khz 
  //Stereo: 88200 sample rate
  //100 mSec of prebuffering.
  //1.3 => Play it faster => 30%
  Audio.begin(1.3 * 44100, 100);
}

void loop() {

  //Open wave file from sdcard
  File myFile = SD.open("test.wav");
  if (!myFile) {
    //If the file didn't open, print an error and stop
    Serial.println("Error opening test.wav");
    while (true);
  }

  const int S = 1024; //Number of samples to read in block
  short buffer[S];    //Init buffer

  Serial.println("Playing");
  //Until the file is not finished
  while (myFile.available()) {
    //Read from the file into buffer
    myFile.read(buffer, sizeof(buffer));
    //Prepare samples, save them in the buffer
    //S = Numver of samples
    //1024 = Volume   
    Audio.prepare(buffer, S, 1024);
    //Feed samples to audio, read S amount of samples from the buffer and write it on the DAC buffer => Sound!!!
    Audio.write(buffer, S);
  }
  
  myFile.close();

  Serial.println("End of file. Thank you for listening!");
  while (true);   //Infinite loop, program stopped!
}
