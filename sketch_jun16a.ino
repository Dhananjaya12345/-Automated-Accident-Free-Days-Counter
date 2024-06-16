#include <SPI.h>
#include <SD.h>
#include <Wire.h>
#include <RTClib.h>
#include <LedControl.h>
// RTC Module
RTC_DS3231 rtc;
// SD Card Module
const int chipSelect = 53;
File dataFile;
// Seven-Segment Displays
LedControl lc = LedControl(11, 12, 10, 1); // DIN, CLK, CS, number of devices
const int digitPins[4] = {22, 23, 24, 25}; // Pins for 4 digits
const int buttonReset = 30;
const int buttonUp = 31;
const int buttonDown = 32;
// P10 LED Display Panels
const int dataIn = 34;
const int clk = 35;
const int load = 36;
const int maxDisplays = 4;
const char* message = "Last Accident: 2022-02-14"; // Change this to the desired 
message
// Variables
int totalAccidentFreeDays = 0;
int plantHeadcount = 0;
int sectionHeadcount = 0;
void setup() {
 // Initialize Serial Monitor
 Serial.begin(9600);
 // Initialize RTC
 if (!rtc.begin()) {
 Serial.println("Couldn't find RTC");
 while (1);
 }
 
 if (!rtc.isrunning()) {
 Serial.println("RTC is NOT running!");
 }
 // Initialize SD Card
 if (!SD.begin(chipSelect)) {
 Serial.println("SD Card initialization failed.");
 return;
 }
 for (int i = 0; i < 4; i++) { // Initialize Seven-Segment Displays
 pinMode(digitPins[i], OUTPUT);
 lc.shutdown(i, false);
 lc.setIntensity(i, 8); // Set brightness (0 is min, 15 is max)
 lc.clearDisplay(i);
 }
 // Initialize Buttons
 pinMode(buttonReset, INPUT_PULLUP);
 pinMode(buttonUp, INPUT_PULLUP);
 pinMode(buttonDown, INPUT_PULLUP);
 // Initialize P10 LED Display Panels
 pinMode(load, OUTPUT);
 digitalWrite(load, LOW);
 
 // Display initial values
 updateDisplays();
}
void loop() {
 // Check for manual updates
 if (digitalRead(buttonReset) == LOW) {
 totalAccidentFreeDays = 0;
 sectionHeadcount = 0;
 updateDisplays();
 }
 if (digitalRead(buttonUp) == LOW) {
 plantHeadcount++;
 updateDisplays();
 }
 if (digitalRead(buttonDown) == LOW) {
 plantHeadcount--;
 updateDisplays();
 }
 
 // Check for automatic updates at 7am
 DateTime now = rtc.now();
 if (now.hour() == 7 && now.minute() == 0 && now.second() == 0) {
 totalAccidentFreeDays++;
 updateDisplays();
 }
 // Scroll the message on P10 LED Display Panels
 scrollMessage();
 delay(100);
}
void updateDisplays() {
 // Update Seven-Segment Displays
 lc.clearDisplay(0);
 lc.setDigit(0, 0, plantHeadcount / 1000, false);
 lc.setDigit(0, 1, (plantHeadcount / 100) % 10, false);
 lc.setDigit(0, 2, (plantHeadcount / 10) % 10, false);
 lc.setDigit(0, 3, plantHeadcount % 10, false);
 lc.clearDisplay(1);
 lc.setDigit(1, 0, sectionHeadcount / 1000, false);
 lc.setDigit(1, 1, (sectionHeadcount / 100) % 10, false);
 lc.setDigit(1, 2, (sectionHeadcount / 10) % 10, false);
 lc.setDigit(1, 3, sectionHeadcount % 10, false);
 // Update P10 LED Display Panels
 digitalWrite(load, LOW);
 for (int i = 0; i < maxDisplays; i++) {
 for (int j = 0; j < 4; j++) {
 shiftOut(dataIn, clk, MSBFIRST, 0);
 }
 }
 digitalWrite(load, HIGH);
}
void scrollMessage() {
 int length = strlen(message);
 for (int i = 0; i < length + 1; i++) {
 for (int j = 0; j < maxDisplays; j++) {
 digitalWrite(load, LOW);
 for (int k = 0; k < 4; k++) {
 shiftOut(dataIn, clk, MSBFIRST, i + j * 8 < length ? pgm_read_byte(&message[i + j 
* 8]) : 0);
 }
 digitalWrite(load, HIGH)
delay(100);
 }
 }
