import processing.sound.*;

PFont font;
PFont smallFont;
String fname = "ThereWasAnOldLady.txt";
String[] words;
boolean paused = false, playAll = false, playFly = false, playSpider = false, playBird = false, playCat = false,
playDog = false, playGoat = false, playCow = false, playHorse = false;
int backgroundColor = 0;
color strokeColor = color(255, 255, 255);
int buttonsWidth=20, buttonsHeight=20;
int flyX, spiderX, birdX, catX, dogX, goatX, cowX, horseX, playAllX; 
int flyY, spiderY, birdY, catY, dogY, goatY, cowY, horseY, playAllY; 
int buttonSideSize = 80; //modify this number to change the width/height of the buttons
int spaceBetweenButtonsX = 0, spaceBetweenButtonsY = 0;
// Create a lines array 
String[] lines;
String[] flyLines = new String[2], spiderLines = new String[4], birdLines = new String[6],
        catLines= new String [7], dogLines = new String [8], goatLines= new String[9], 
        cowLines= new String[10], horseLines = new String [2];
int f=0, s=0, b=0, c=0, d=0, g =0, w=0, h=0; //this will serve as index for the above arrays
//timings to display each sentence in seconds. These timings reflect the time in the song when the sentence should appear
//The story has been partitioned in 8 paragraphs separated by an empty line. The starting time of each line 
//per paragraph is as follows: (if your computer takes longer to start...you may need to add those many seconds)
int []  paragraphFly = {3, 6}, paragraphSpider = {10, 12, 15, 17}, paragraphBird = {22, 24, 27, 29, 32, 34},
        paragraphCat = {38, 42, 44, 46, 48, 51, 52}, paragraphDog = {57, 59, 62, 64, 68, 70, 73}, 
        paragraphGoat = {78, 81, 83, 85, 87, 89, 91, 93, 95}, 
        paragraphCow = {101, 104, 106, 108, 110, 112, 114, 116, 119, 122}, paragraphHorse={127, 130};
//
int[] allSentenceTimings = {3, 6, 10, 12, 15, 17, 22, 24, 27, 29, 32, 34, 38, 42, 44, 46, 48,
                           51, 52, 57, 59, 62, 64, 68, 70, 73, 78, 81, 83, 85, 87, 
                           89, 91, 93, 95, 101, 104, 106, 108, 110, 112, 114, 116, 119,
                           122, 127, 130};
SoundFile file;
int startTime, nextLineTime, localStartTime, elapsedTime, currentIndex = 0;

void setup() {
  size(600, 400);
  startTime = millis();
  //the following block is just setting up the coordinates for each button's position so the screen can be resized if needed
  rectMode(CENTER);
  spaceBetweenButtonsX = (width - buttonSideSize * 4)/5; //divies the 5 is the space available between all 4 buttons and the 4 is the 4 buttons width
  spaceBetweenButtonsY = (height - buttonSideSize * 2)/3;
  //the following variables are for referring to the upper left hand corner of each button to draw rectangles for buttons
  flyX = spaceBetweenButtonsX;
  spiderX = spaceBetweenButtonsX * 2 + buttonSideSize;
  birdX = spaceBetweenButtonsX * 3 + buttonSideSize * 2;
  catX = spaceBetweenButtonsX * 4 + buttonSideSize * 3;
  dogX = spaceBetweenButtonsX;
  goatX = spaceBetweenButtonsX * 2 + buttonSideSize;
  cowX = spaceBetweenButtonsX * 3 + buttonSideSize * 2;
  horseX = spaceBetweenButtonsX * 4 + buttonSideSize * 3;
  flyY = spaceBetweenButtonsY;
  spiderY = spaceBetweenButtonsY;
  birdY = spaceBetweenButtonsY;
  catY = spaceBetweenButtonsY;
  dogY = spaceBetweenButtonsY * 2 + buttonSideSize;
  goatY = spaceBetweenButtonsY * 2 + buttonSideSize;
  cowY = spaceBetweenButtonsY * 2 + buttonSideSize;
  horseY = spaceBetweenButtonsY * 2 + buttonSideSize;
  playAllX = spaceBetweenButtonsX * 4;
  playAllY = 10; 
  
  // Create some fonts
  font = createFont("Baskerville", 30);
  smallFont = createFont("Baskerville", 18);

  // Add lines to array from file
  lines = loadStrings(fname);
  //separate lines into each animal's paragraph
  //print("Lines: ");
  //println(lines);
  arrayCopy(lines, 0, flyLines, 0, 2); //source, index,  destination, index,  length
  //print("Fly: ");
  //println(flyLines);
  arrayCopy(lines, 3, spiderLines, 0, 4);
  //print("Spider: ");
  //println(spiderLines);
  arrayCopy(lines, 8, birdLines, 0, 6);
  //print("Bird: ");
  //println(birdLines);
  arrayCopy(lines, 15, catLines, 0, 7);
  //print("Cat: ");
  //println(catLines);
  arrayCopy(lines, 23, dogLines, 0, 8);
  //print("Dog: ");
  //println(dogLines);
  arrayCopy(lines, 32, goatLines, 0, 9);
  //print("Goat: ");
  //println(goatLines);
  arrayCopy(lines, 42, cowLines, 0, 10);
  //print("Cow: ");
  //println(cowLines);
  arrayCopy(lines, 53, horseLines, 0, 2);
  //print("Horse: ");
  //println(horseLines);
   
  // Load the soundfile from the /data folder and play it back
  file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
  //file.play();
  //file.rate(0.5);
  //file.amp(0.5);
}//end setup

void draw() {
  background(backgroundColor);
  //draw temporary basic rectacgles that will become buttons
  fill(strokeColor);
  stroke(150);
  noFill();
  rectMode(CORNER);
  rect(playAllX, playAllY, 140, 20, 7); //7 is for rounded corners
  rect(flyX, flyY, buttonSideSize, buttonSideSize, 7);
  rect(spiderX, spiderY, buttonSideSize, buttonSideSize, 7);
  rect(birdX, birdY, buttonSideSize, buttonSideSize, 7);
  rect(catX, catY, buttonSideSize, buttonSideSize, 7);
  rect(dogX, dogY, buttonSideSize, buttonSideSize, 7);
  rect(goatX, goatY, buttonSideSize, buttonSideSize, 7);
  rect(cowX, cowY, buttonSideSize, buttonSideSize, 7);
  rect(horseX, horseY, buttonSideSize, buttonSideSize, 7);

  // Settings for text
  textFont(font);
  fill(250, 250, 210, 100);
  textAlign(CENTER);
  textFont(smallFont);
  text("Seconds passed: " + (millis()/1000.00), 100, height-5); //for coordinating elements timing
  
  if (playAll) {
    fill(255);
    //This line is just for testing region accuracy
    //text("mouse is in playAllButton ", width/2, 20);
    //display index of sentences when time=time the sentece starts ....startTime = start of paragraph 
    startTime = allSentenceTimings[0];
    text(lines[currentIndex], width/2, height-40);
    if ((((millis()-startTime)/1000) == allSentenceTimings[currentIndex]) && currentIndex < lines.length) {
       currentIndex = (currentIndex + 1) % lines.length;       
    }//end if millis
  } else if (playFly) {
    fill(255);
    //This line is just for testing region accuracy
    text("mouse is in flyButton ", width/2, 20);
    //print(flyLines[currentIndex], " ",currentIndex, " " , paragraphFly[currentIndex], "\n");
    //using millis() here is assuming the user clicks this button as soon as the program starts running...otherwise, it will miss the timings which coordinate with how long has the program been running
    if (millis()/1000 == paragraphFly[currentIndex]) {
      currentIndex = (currentIndex + 1) % paragraphFly.length;      //restrain between currentIndex and number of lines in the paragraph 
    }
    text(flyLines[currentIndex], width/2, height-40);
  } else if (playSpider) {
    fill(255);
    //This line is just for testing region accuracy
    text("mouse is in spiderButton ", width/2, 20);
    //print(spiderLines[currentIndex], " ",currentIndex, " " , paragraphSpider[currentIndex], "\n");
    //using millis() here is assuming the user clicks this button as soon as the program starts running...otherwise, it will miss the timings which coordinate with how long has the program been running
    if (millis()/1000 == paragraphSpider[currentIndex]) {
      currentIndex = (currentIndex + 1) % paragraphSpider.length;      //restrain between currentIndex and number of lines in the paragraph 
    }
    text(spiderLines[currentIndex], width/2, height-40);
  }
}//end draw()
 
int getElapsedTime(int time){
  return ((millis()/1000)-time);
}

void mouseClicked() {
  paused = false; playAll = false; playFly = false; playSpider = false; playBird = false; playCat = false;
  playDog = false; playGoat = false; playCow = false; playHorse = false;
  if (mouseX > playAllX && mouseX < playAllX + 140 && mouseY > playAllY && mouseY < playAllY + 20 ) {
    playAll = true;  
    file.play(0.5, 0, 0.1);
  } else if (mouseX > flyX && mouseX < flyX + buttonSideSize && mouseY > flyY && mouseY < flyY + buttonSideSize) {
    playFly = true;
    file.play(0.5, paragraphFly[0], 0.1);
  } else if (mouseX > spiderX && mouseX < spiderX + buttonSideSize && mouseY > spiderY && mouseY < spiderY + buttonSideSize ) {
    playSpider = true;
  } else if (mouseX > birdX && mouseX < birdX + buttonSideSize && mouseY > birdY && mouseY < birdY + buttonSideSize) {
    playBird = true;
  } else if (mouseX > catX && mouseX < catX + buttonSideSize && mouseY > catY && mouseY < catY + buttonSideSize) {
    playCat = true;
  } else if (mouseX > dogX && mouseX < dogX + buttonSideSize && mouseY > dogY && mouseY < dogY + buttonSideSize) {
    playDog = true;
  } else if (mouseX > goatX && mouseX < goatX + buttonSideSize && mouseY > goatY && mouseY < goatY + buttonSideSize) {
    playGoat = true;
  } else if (mouseX > cowX && mouseX < cowX + buttonSideSize && mouseY > cowY && mouseY < cowY + buttonSideSize) {
    playCow = true;
  } else if (mouseX > horseX && mouseX < horseX + buttonSideSize && mouseY > horseY && mouseY < horseY + buttonSideSize) {
    playHorse = true;
  }
}

void keyReleased() {
  // Space bar pauses and resumes reading
  if (key == ' ') {
    if (paused) {
      loop();
      paused = false;
    } else {
      noLoop();
      paused = true;
    }//end else
  }//end if
}//end keyReleased
