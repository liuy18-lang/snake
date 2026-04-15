//setup of variables and files
//import processing.sound.*;
//SoundFile APT;
PImage art;
PImage food;
int playerX = 20;
int playerY = 20;
float speedX = 0;
float speedY = 0;
int foodie = 0;
ArrayList<Integer> playhisx;
ArrayList<Integer> playhisy;
int foodX, foodY;
int segmentCount = 1;
boolean gameOver = false;
boolean gameStarted = false;

void setup() {
  size(800, 800);
  frameRate(24);
  playhisx = new ArrayList<Integer>();
  playhisy = new ArrayList<Integer>();
  spawnFood();
  art = loadImage("newsnake.jpg");
  food = loadImage("apple.jpeg");
//  APT = new SoundFile(this, "APT.mp3");
  for (int i = 0; i < playhisx.size(); i++) {
    ellipse(20*playhisx.get(i)+10, 20*playhisy.get(i)+10, 20, 20);
  }
}

void draw() {
  if (!gameStarted) {
    drawStartScreen(); // Display start screen if game hasn't started
  } else {
    playsnake(); // Play the game
  }
}

void keyPressed() {
  //detect arrow key inputs
  if (keyCode == RIGHT && speedX == 0) {
    speedX = 1;
    speedY = 0;
  } else if (keyCode == LEFT && speedX == 0) {
    speedX = -1;
    speedY = 0;
  } else if (keyCode == DOWN && speedY == 0) {
    speedY = 1;
    speedX = 0;
  } else if (keyCode == UP && speedY == 0) {
    speedY = -1;
    speedX = 0;
  }
}
//spawn in the food
void spawnFood() {
  foodX = int(random(1,39));
  foodY = int(random(1,39));
}

void mousePressed() {
  //detect the start button being pressed
  if (!gameStarted && mouseX > 150 && mouseX < 250 && mouseY > 200 && mouseY < 250) {
    gameStarted = true;
//    APT.loop();
  }
  //detect restart button being pressed
  if (gameOver) {
//    APT.stop();
    if (mouseX > width / 2 - 50 && mouseX < width / 2 + 50 && mouseY > height / 2 + 150 && mouseY < height / 2 + 200) {
      restartGame();
//      APT.loop();
    }
  }
}
//reset thev game
void restartGame() {
  playerX = 20;
  playerY = 20;
  speedX = 0;
  speedY = 0;
  foodie = 0;
  segmentCount = 1;
  gameOver = false;
  playhisx.clear();
  playhisy.clear();
  spawnFood();
}
//draw the start screen
void drawStartScreen() {
  background(100);
  fill(255);
  image(art, 0, 0);
  textSize(50);
  text("Snake", width/2, 100);
  rect(150, 200, 100, 50);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Play", 200, 225);
}
//Buncha code. I piled it together for SOME reason but I forgot.
void playsnake() {

  if (gameOver) {
//    APT.stop();
    background(255, 0, 0);
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over", 400, 200);
    text("Score:", 400, 250);
    text(foodie, 460, 250);
    fill(0, 255, 0);
    rect(350, 550, 100, 50);
    fill(0);
    textSize(16);
    text("Restart", 400, 575);
    return;
  }

  background(255);
  fill(0, 255, 0);
  //Add new segment
  playhisx.add(playerX);
  playhisy.add(playerY);
  //Remove last segment
  while (playhisx.size() > segmentCount) {
    playhisx.remove(0);
    playhisy.remove(0);
  }
  //Draw the snake
  for (int i = 0; i < playhisx.size(); i++) {
    ellipse(20*playhisx.get(i)+10, 20*playhisy.get(i)+10, 15+5/(playhisx.size()*(i+1)), 15+5/(playhisy.size()*(i+1)));
//    square(20*playhisx.get(i), 20*playhisy.get(i), 20);
  }
//  square(20*playerX, 20*playerY, 20);
  //Draw up the apple
  fill(255, 0, 0);
  image(food, 20*foodX, 20*foodY);

  playerX += speedX;
  playerY += speedY;
  //Collision with walls
  if (playerX < 0) {
    gameOver = true;
  } else if (playerX >= width / 20) {
    gameOver = true;
  } else if (playerY < 0) {
    gameOver = true;
  } else if (playerY >= height / 20) {
    gameOver = true;
  }
  //Apple Collision
  if (playerX == foodX && playerY == foodY) {
    segmentCount++;
    spawnFood();
    foodie++;
  }
  //Snake collision
  for (int i = 0; i < playhisx.size() - 1; i++) {
    if (playhisx.get(i) == playerX && playhisy.get(i) == playerY) {
      gameOver = true;
    }
  }

}
