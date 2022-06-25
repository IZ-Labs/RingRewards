/*---------------------------------------------------------------
Created by Iain Zwiebel - March 27th 2022
Based on work by ACROBOTIC (MakerBro) - 11/12/2015

This is the software to control the ring rewards board. 
This uses the ESP8266 module on the node MCU (or similar) to 
create a web server. This is then accessed via the IOS app which
tracks your activity and gives 'spins' based on that.
----------------------------------------------------------------*/

// All required libraries
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <CheapStepper.h> //ensure that this is the modified version with the .off() method

// Define NodeMCU pinout in Arduino Language
#define D0 16
#define D1 5 // I2C Bus SCL (clock)
#define D2 4 // I2C Bus SDA (data)
#define D3 0

// Define network credentials and instantiate the web sever (port 80)
const char* ssid = "XXXXXXX"; // Enter your network SSID here
const char* password = "YYYYYYY"; // Enter your network password here
ESP8266WebServer server(80);

// Initalize Stepper object
CheapStepper stepper(D0,D1,D2,D3);
boolean clockwise = true;
boolean counterclockwise = false;

// Function to control web interface. Sends 'OK' message (200), and prints plain text for user to see.
void handleRoot() {
  server.send(200, "text/plain", String("Welcome to ringrewards control\n\nTo use this service from the web, navigate to") +
              String(" /setSpins?count=X changing X to your desired number of spins as an integer.") + 
              String("\n\nNote that this service is best used with the associated IOS app: Ring Rewards"));
  yield();
}

// This function will be called each time the /setspins path is accessed
void handleSpins() {
  ESP.wdtDisable();
  int numSpins = (server.arg("count")).toInt(); // Read our one parameter (number of spins) from the server
  // We then control the stepper motor based on the passed input
  if (numSpins) {
    stepper.moveDegrees(clockwise, 90);
    stepper.moveDegrees(counterclockwise, 90);
    Serial.println("motor spun");
    server.send(200, "text/plain", "Motor spun!");
    numSpins = 0;
    stepper.off();
    return;
  } else {
    stepper.off();
    yield();
  }
}

// This function will be called if any other URL is called (thus an error should be reported)
void handleNotFound() {
  String message = "File Not Found\n\n";
  // which includes what URI was requested
  message += "URI: ";
  message += server.uri();
  // what method was used
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  // and what parameters were passed
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i = 0; i < server.args(); i++) {
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  // the response, as expected, is a "Not Found" (404) error
  server.send(404, "text/plain", message);
}

// Initialize various parameters
void setup() {
  stepper.setRpm(10); // set a speed for the motor. This is a good balance of speed and torque.
  /* Note: CheapStepper library assumes you are powering your 28BYJ-48 stepper
   * using an external 5V power supply (>100mA) for RPM calculations
   * -- don't try to power the stepper directly from the Arduino
   * 
   * accepted RPM range: 6RPM (may overheat) - 24RPM (may skip)
   * ideal range: 10RPM (safe, high torque) - 22RPM (fast, low torque)
   */
  Serial.begin(115200); // Start serial communication for debugging purposes
  WiFi.begin(ssid, password); // Initialize the WiFi client and try to connect to our Wi-Fi network
  Serial.println("");
  while (WiFi.status() != WL_CONNECTED) {   // Wait for a successful connection
    delay(500);
    Serial.print(".");
  }
  // For debugging purposes print the network ID and the assigned IP address
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  // Link the URLs with the functions that will be handling the requests
  server.on("/", HTTP_GET, handleRoot);
  server.on("/setSpins", HTTP_GET, handleSpins);
  server.onNotFound(handleNotFound);

  // Start running the webserver
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient(); // Send any incoming requests to the ESP8266 host.
  delay(1000);
}
