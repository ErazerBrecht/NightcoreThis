/*
------- 12-BIT 44100 kHz REAL-TIME AUDIO DELAY EFFECT -------
Designed for the ARDUINO DUE - by Robert FK Triggs, 30th July 2014
Edited by Brecht Carlier; 5th January 2015 (Added second delay)
*/

#include <ADC_DAC_Timer.h>
ADC_DAC_Timer ADC_DAC_Timer;

short SigIn = 0;          // variable for the incoming ADC signal
short buff [44100];       // buffer to read and write values, creating a delay (in samples) between delay and read
int writeloc = 40000;     // buffer write location start value
int readloc = 39999;      // buffer read location start value
int delayloc = 39989;     // default buffer delay position write location
byte delayVol = 2;        // divider for the delay volume
short delaysamps = 250;   // value from delay potentiometer A8, which controls the delayloc


void setup(){
ADC_DAC_Timer.set_sample_rate(44100);  // set sample rate to 44100 kHz, twice the maximum audible frequency of 20kHz;
ADC_DAC_Timer.adc0_setup ();           // initialize A0 pin to sample at 44100 kHZ
ADC->ADC_CHER = 0x7C;                  // enable channel A1 for delay control
ADC_DAC_Timer.dac0_setup ();           // initialize DAC0 pin to write data at 44100 kHZ
}

void ADC_Handler (void){
  if (ADC->ADC_ISR & ADC_ISR_EOC7){    // initialize when ADC end-of-conversion is flagged (NOTE: pin A0 is AD7, so the EOC flag is on EOC7)
    SigIn = *(ADC->ADC_CDR+7);         // get conversion result from the ADC CRD. (NOTE: pin A0 is AD7, so conversion data is held in CRD7)
    SigIn = SigIn - 2048;              // subtract half of 12-BIT resolution to give +/- values needed for correct addition/subtration

    //This writeloc section should be commented out, if the connected circuit combines a non-digital "dry" signal with the digital delay
    if (writeloc > 44099) writeloc = 0;        // reset writeloc location to the start of the buffer if it reaches the end
    buff [writeloc] = SigIn + buff[writeloc];  // assign SigIn to the write location in the buffer, plus any value that might already be in array                    
    
    delayloc = readloc+(44*(delaysamps));                   // 44*1000 = 44000 +- max delay of 1s
    if (delayloc > 44099) delayloc = delayloc-44100;        // reset just like writeloc, but subtracts the full buffer length, as the delayloc references readloc
    buff [delayloc] = (SigIn/delayVol) + buff[delayloc];    // assigns an attenuated delay into the buffer 
    delayloc = readloc+2*(44*(delaysamps));                 // Second echo (2 times the delay)! 
    if (delayloc > 44099) delayloc = delayloc-44100;        // reset just like writeloc, but subtracts the full buffer length, as the delayloc references readloc
    buff [delayloc] = (SigIn/4*delayVol) + buff[delayloc];  // assigns an attenuated delay into the buffer 
    
    if (readloc > 44099) readloc = 0;
    DACC->DACC_CDR = buff[readloc]+2048;  // puts the signal back to purely positive values and pushes the buffer value to DAC
    buff[readloc] = 0;                    //clear the value in the buffer after sending to DAC    

    writeloc++;  // move read and write locations up one sample in the buffer
    readloc++;
    delayloc=0;  // clear the delaylocation
  }
}

void loop() {
      
}
