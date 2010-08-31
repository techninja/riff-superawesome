/*
 * The RIFF (Randomly Influenced Finger Flute) for Arduino - SuperAwesome Version
 * by TechNinja and SuperAwesomeSylvia - First release: September 2010
 *
 * Part of Sylvia's Super Awesome Maker Show! - Episode 3
 *  http://tn42.com/maker-show
 *  http://tn42.com/riff
 *
 * Fork this on GitHub:
 *  http://github.com/techninja/riff-superawesome
 *
 * --------------------------------------------------------------
 * =    Licensed under the CC-GNU GPL version 2.0 or later      =
 * =      http://creativecommons.org/licenses/GPL/2.0/          =
 * --------------------------------------------------------------
 *
 * Plays tones at a given interval, from a given list of notes based
 * on the value of an analog input, intentionally not connected to anything
 * so that random fluctuations in it's value can be influenced by physically
 * touching the various pins on the underside of the Arduino.
 *
 * Things needed to build it:
 * - Arduino (duh!)
 * - Speaker
 * - A dashing sense of musical adventure
 *
 * Build steps:
 * - Hook one of the speaker wires to ground, and the other to pin 10
 * - Upload this sketch
 * - Touch the Analog pin 0, and with your other fingers, touch ground, or 5v
 * - Enjoy your own little symphony of random sound!
 * 
 *
 * References:
 *  http://arduino.cc/en/Tutorial/AnalogInput
 *  http://arduino.cc/en/Tutorial/Tone3
 *  http://code.google.com/p/tinkerit/wiki/Auduino
 */

/*************************************************
 * Note Constant Table (by by Brett Hagman via http://arduino.cc/en/Tutorial/Tone3 )
 *************************************************/

#define NOTE_B0  31
#define NOTE_C1  33
#define NOTE_CS1 35
#define NOTE_D1  37
#define NOTE_DS1 39
#define NOTE_E1  41
#define NOTE_F1  44
#define NOTE_FS1 46
#define NOTE_G1  49
#define NOTE_GS1 52
#define NOTE_A1  55
#define NOTE_AS1 58
#define NOTE_B1  62
#define NOTE_C2  65
#define NOTE_CS2 69
#define NOTE_D2  73
#define NOTE_DS2 78
#define NOTE_E2  82
#define NOTE_F2  87
#define NOTE_FS2 93
#define NOTE_G2  98
#define NOTE_GS2 104
#define NOTE_A2  110
#define NOTE_AS2 117
#define NOTE_B2  123
#define NOTE_C3  131
#define NOTE_CS3 139
#define NOTE_D3  147
#define NOTE_DS3 156
#define NOTE_E3  165
#define NOTE_F3  175
#define NOTE_FS3 185
#define NOTE_G3  196
#define NOTE_GS3 208
#define NOTE_A3  220
#define NOTE_AS3 233
#define NOTE_B3  247
#define NOTE_C4  262
#define NOTE_CS4 277
#define NOTE_D4  294
#define NOTE_DS4 311
#define NOTE_E4  330
#define NOTE_F4  349
#define NOTE_FS4 370
#define NOTE_G4  392
#define NOTE_GS4 415
#define NOTE_A4  440
#define NOTE_AS4 466
#define NOTE_B4  494
#define NOTE_C5  523
#define NOTE_CS5 554
#define NOTE_D5  587
#define NOTE_DS5 622
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_FS5 740
#define NOTE_G5  784
#define NOTE_GS5 831
#define NOTE_A5  880
#define NOTE_AS5 932
#define NOTE_B5  988
#define NOTE_C6  1047
#define NOTE_CS6 1109
#define NOTE_D6  1175
#define NOTE_DS6 1245
#define NOTE_E6  1319
#define NOTE_F6  1397
#define NOTE_FS6 1480
#define NOTE_G6  1568
#define NOTE_GS6 1661
#define NOTE_A6  1760
#define NOTE_AS6 1865
#define NOTE_B6  1976
#define NOTE_C7  2093
#define NOTE_CS7 2217
#define NOTE_D7  2349
#define NOTE_DS7 2489
#define NOTE_E7  2637
#define NOTE_F7  2794
#define NOTE_FS7 2960
#define NOTE_G7  3136
#define NOTE_GS7 3322
#define NOTE_A7  3520
#define NOTE_AS7 3729
#define NOTE_B7  3951
#define NOTE_C8  4186
#define NOTE_CS8 4435
#define NOTE_D8  4699
#define NOTE_DS8 4978

// Handy reminder for the number of steps from analogRead (0 to 1023)
#define analog_read_number_of_steps 1024



/******* -----=====!! EASY STUFF TO MESS WITH !!=====------ ******/

  // Array of notes to be played, in order, taken from the defined notes above.
  int notes[] = {NOTE_C3,
                 NOTE_D3,
                 NOTE_E3,
                 NOTE_F3,
                 NOTE_G3,
                 NOTE_A3,
                 NOTE_B3,
                 NOTE_C4,
                 NOTE_D4,
                 NOTE_E4,
                 NOTE_F4,
                 NOTE_G4,
                 NOTE_A4,
                 NOTE_B4,
                 NOTE_C5,
                 NOTE_D5};
  // ^^ Two octaves of the C Major scale, starting at middle C ^^
  
  // How many notes do we have in the array to play?
  // (Make sure this is the same number of notes that you have above)
  int number_of_notes = 16; // Two octaves (16)
  
  // Which digital I/O pin is the speaker hooked up to?
  int speaker_pin = 10;
  
  // How long should each note play before reading for a new one (in milliseconds)? 
  int note_duration = 200; // 200ms = 5 notes per second (if constantly changing)

  // Which analog pin should we read for the value?
  int analog_read_pin = 0;
  
/******* -----=====^^ EASY STUFF TO MESS WITH ^^=====------ ******/


// Divide the number of analog read steps (1024) by the number of notes in the list (16).
// We do this calculation here to save processing time within the main loop.
int analog_steps_per_note = (analog_read_number_of_steps / number_of_notes);

// Initialize the number to hold our note index.. isn't used till we get to the main loop
int note_index = 0;


void setup() {
  // Code to run at startup.. none yet.
}

void loop() {
  // Read the wobbly value from the analog_read_pin
  // then divide it by the number of steps per note to get a number from 0 to 15
  note_index = analogRead(analog_read_pin) / analog_steps_per_note;
  
  // Play the note from the given note_index
  tone(speaker_pin, notes[note_index]);
  
  // Delay for the note duration
  delay(note_duration);
}
