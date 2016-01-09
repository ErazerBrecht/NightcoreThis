/*
------- 12-BIT 44100 kHz REAL-TIME AUDIO SAMPLING -------
Collects audio data from Pin A0, writes the data into a small buffer, and reads data out of that buffer to DAC0
Designed for the ARDUINO DUE - by Robert FK Triggs, 30th July 2014
*/

#include <ADC_DAC_Timer.h>
ADC_DAC_Timer ADC_DAC_Timer;

//#include <FIR.h>
#define coef1amount 5

volatile bool play; 

short SigIn = 0;            // store for incoming ADC value (ADC is 12 bits, so a short is large enough)
short buff [10000];           // small 200 value circular buffer to hold audio samples
short writeloc = 5001;        // variable for the write location in the buffer
short readloc = 1;          // variable for the read location in the buffer, placed 20 samples (820us) behind the writeloc (this is variable).

//float coef1[coef1amount] = { 0.021, 0.096, 0.146, 0.096, 0.021 };
//FIR fir1(1, coef1, coef1amount);

void setup() {  
ADC_DAC_Timer.set_sample_rate(44100);  // set sample rate to 44100 kHz, twice the maximum audible frequency of 20kHz;
ADC_DAC_Timer.adc0_setup ();           // initialize A0 pin to sample at 44100 kHZ
ADC_DAC_Timer.dac0_setup ();           // initialize DAC0 pin to write data at 44100 kHZ
}

void ADC_Handler (void){
  if (ADC->ADC_ISR & ADC_ISR_EOC7){    // initialize when ADC end-of-conversion is flagged (NOTE: pin A0 is AD7, so the EOC flag is on EOC7)
    SigIn = *(ADC->ADC_CDR+7) ;  // get conversion result from the ADC CRD. (NOTE: pin A0 is AD7, so conversion data is held in CRD7)
    
    if (writeloc >= 9999) writeloc = 0; //reset writeloc location to the start of the buffer if it reaches the end
    buff[writeloc] = SigIn;            // assign SigIn to the write location in the buffer
    writeloc++;                        // move writeloc on 1 place in the buffer
        
    /*INSERT EXTRA CODE HERE TO BE COMPLETED AFTER EACH SAMPLE, BUT BEFORE SENDING TO DAC
    Complex code could take too long, so put heavy duty code in void loop() where possible, as there is ~41uS to perform tasks between sampling*/  
    play = true;    
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  // this will be interrupted when each new sample is called
  if(play == true)
  {
    if (readloc >= 9999) 
      readloc = 0; //reset readloc location to the start of the buffer if it reaches the end
    
    //short output1 = fir1.process(buff[readloc]);  //filter that doesn't work
    DACC->DACC_CDR = buff[readloc];                 // pushes buffer value to DAC for next write cycle
    buff[readloc] = 0;                              //clear the value in the buffer after sending to DAC
    readloc++;                                      //move readloc on 1 place

    play = false;
  }
}
