boolean hasEnded = false;

int moves;

String secretWord, currentWord = "";

String[] incorrectWords, correctWords = {"Brasil", "Alemanha", "Chile", "Argentina", "Coreia", "Dinamarca"};

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  generateWord();
}

void draw() {
  background(0);
  
  if (hasEnded) {
    text("Infelizmente você perdeu! Palavra correta: " + secretWord, width / 2, height / 2);
    return;
  } 
  
  drawHangman();
  drawWord();
}

void keyPressed() {
 if (hasEnded) return;
 
 boolean hasLetter = false;
 for (int index = 0; index < secretWord.length(); index++) {

    if (secretWord.charAt(index) == key || secretWord.charAt(index) == Character.toUpperCase(key)) {
         currentWord = (currentWord.substring(0, index) + key + currentWord.substring(index + 1)).toUpperCase();
         hasLetter = true;
      }
   }
   
   if (!hasLetter) {
       moves++;
   }
}

void generateWord() {
  secretWord = correctWords[int(random(correctWords.length))];
  
  print(secretWord);
  
  for (int index = 0; index < secretWord.length(); index++) {
     currentWord += " "; 
  }
}

void drawWord() {
 textSize(30);
 
 fill(color(255, 255, 255));
 
 text(currentWord, width / 2, height - 30);
}

void drawHangman() {
 stroke(color(255, 255, 255));
 strokeWeight(2);
 
 line(100, height - 100, 500, height - 100);
 line(200, height - 100, 200, 150);
 
 line(200, 150, 325, 150);
 line(325, 150, 325, 225);
 
 fill(color(255, 255, 255));
 
 if (moves >= 1) {
    ellipse(325, 245, 60, 60);
 }
 
  if (moves >= 2) {
    line(325, 275, 325, 400);
  }
  
  if (moves >= 3) {
    line(325, 300, 275, 350);
  }
  
  if (moves >= 4) {
    line(325, 300, 375, 350);
  }
  
  if (moves >= 5) {
    line(325, 400, 275, 475);
  }
  
  if (moves >= 6) {
    line(325, 400, 375, 475);
    hasEnded = true;
  }
}
