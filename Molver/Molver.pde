import controlP5.*;
ControlP5 cp5;
PVector origin;
String dD;
int decideDisplay = 3;
float func1Data[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1};
String[] textfieldNames = {"function", "settings" };
String func1;

void setup () {
  size (1800, 1000);
  PFont font = createFont("arial",20);
  int x = 20;
  cp5 = new ControlP5(this);
  for (String name:textfieldNames) {
    cp5.addTextfield(name)
      .setPosition(x,920)
      .setSize(200,35)
      .setFont(font)
      .setFocus(true)
      .setColor(color(255,255,255))
      ;
    x += 240;
  }
  textFont(font);
  origin = new PVector(900, 450);
  background(0);
}
void controlEvent(ControlEvent theEvent) {
    if (theEvent.getName() == "function") {
      func1 = theEvent.getStringValue();
      wipeup();
      println(func1);
      lookUpFunc();
      if(func1Data[10] == 1){
        display1(func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 2){
        display2(func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 3){
        display3(func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 4){
        display4(func1Data[4], func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 5){
        display5(func1Data[5], func1Data[4], func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 6){
        display6(func1Data[6], func1Data[5], func1Data[4], func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 7){
        display7(func1Data[7], func1Data[6], func1Data[5], func1Data[4], func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 8){
        display8(func1Data[8], func1Data[7], func1Data[6], func1Data[5], func1Data[4], func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
      if(func1Data[10] == 9){
        display9(func1Data[9], func1Data[8], func1Data[7], func1Data[6], func1Data[5], func1Data[4], func1Data[3], func1Data[2], func1Data[1], func1Data[0]);
      }
     
    }
    if (theEvent.getName() == "settings") {
      dD = theEvent.getStringValue();
      decideDisplay = int(dD);
    }
}
void wipeup() {
  for (int i = 0; i < 10; ++i) {
    func1Data[i] = 0;
  }
  func1Data[10] = -1;
}
void lookUpFunc() {
  int index[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
  int appear[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
  int appInfo[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
  int ind = 0;
  int maxX = 0, minX = 11;
  for (int i = 9; i >= 2; --i) {
    String a = Integer.toString(i);
    index[i] = func1.indexOf("^"+a);
    if (index[i] != -1) {
      appear[ind] = index[i];
      appInfo[ind] = i;      
      ind++;
      if (maxX < i) {
        maxX = i;
      }
      if (minX > i) {
        minX = i;
      }
    }
  }
  println(minX);
  println(maxX);
  for (int i = 0; i < ind; ++i) {  
     if (i >= 1 && appear[i] != -1 && appear[i-1] != -1) {       
       func1Data[appInfo[i]] = float(func1.substring(appear[i-1]+2, appear[i]-1));       
     }
     else if (appInfo[i] == maxX) {      
       func1Data[appInfo[i]] = float(func1.substring(2, appear[i]-1));       
     }
     if (appInfo[i] == minX) {
       if (func1.indexOf("x",index[minX]) != -1){ 
         func1Data[1] = float(func1.substring(appear[i]+2, func1.indexOf("x", index[minX])));      
         func1Data[0] = float(func1.substring(func1.indexOf("x",index[minX])+1, func1.length()));
       }
       else {
         func1Data[0] = float(func1.substring(appear[i]+2, func1.length()));
       }
     }
  }
  if (minX == 11) {
    func1Data[0] = float(func1.substring(func1.indexOf("x")+1, func1.length()));
  }
  if (maxX == 0) {
    func1Data[1] = float(func1.substring(2, func1.indexOf("x")));
    maxX = 1;
  }
  if(Float.isNaN(func1Data[0])) {
    func1Data[0] = 0;
  }
  func1Data[10] = maxX;
  check();
  
}
void check() {
  for (int i = 0; i < 11; ++i) {
    println(func1Data[i]);
  }
}
void singraphDisplay () {
  stroke (0, 255, 0); 
  float a = 0;
  float inc = TWO_PI/450;
  float prev_x = 0, prev_y = 450, x, y;
  for(int i = 0 ; i <= 1800; i++) {
    x = i;
    y = 450 - sin(a) * 100;
    line(prev_x, prev_y, x, y);
    prev_x = x;
    prev_y = y;
    a += inc;
  } 
}
void cosgraphDisplay () {
  stroke (0, 0, 255); 
  float a = 0;
  float inc = TWO_PI/450;
  float prev_x = 0, prev_y = 450, x, y;
  for(int i = 0 ; i < 1800; i++) {
    x = i;
    y = 450 - cos(a) * 100;
    line(prev_x, prev_y, x, y);
    prev_x = x;
    prev_y = y;
    a += inc;
  } 
}
void display1 (float a, float b) {
  stroke(255);
  pushMatrix();
  translate (origin.x , origin.y);
  float y;
  for(float x=-width/2; x<width/2; x=x+0.0125){
    y = a * x + b; 
    if(y >=-450) {
      point(x, -y);
    }
    
  }
  popMatrix();
}
void display2 (float a, float b, float c) {
  stroke(255);
  pushMatrix();
  translate (origin.x, origin.y);
  float y;
  for (float x = -width/2; x < width/2; x=x+0.0125) {
    y = a*x*x + b*x + c;
    if(y >=-450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display3 (float a, float b, float c, float d) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x + b*x*x + c*x*x + d;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display4 (float a, float b, float c, float d, float e) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x*x + b*x*x*x + c*x*x*x + d*x + e;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display5 (float a, float b, float c, float d, float e, float f) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x*x*x + b*x*x*x*x + c*x*x*x*x + d*x*x + e*x + f;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display6 (float a, float b, float c, float d, float e, float f, float g) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x*x*x*x + b*x*x*x*x*x + c*x*x*x*x*x + d*x*x*x + e*x*x + f*x + g;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display7 (float a, float b, float c, float d, float e, float f, float g, float h) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x*x*x*x*x + b*x*x*x*x*x*x + c*x*x*x*x*x*x + d*x*x*x*x + e*x*x*x + f*x*x + g*x + h;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display8 (float a, float b, float c, float d, float e, float f, float g, float h, float i) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x*x*x*x*x*x + b*x*x*x*x*x*x*x + c*x*x*x*x*x*x*x + d*x*x*x*x*x + e*x*x*x*x + f*x*x*x + g*x*x + h*x + i;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void display9 (float a, float b, float c, float d, float e, float f, float g, float h, float i, float j) {
  stroke(255);
  pushMatrix();
  translate(origin.x, origin.y);
  float y;
  for (float x = -width/2; x<width/2; x+=0.0125) {
    y = a*x*x*x*x*x*x*x*x*x + b*x*x*x*x*x*x*x*x + c*x*x*x*x*x*x*x*x + d*x*x*x*x*x*x + e*x*x*x*x*x + f*x*x*x*x + g*x*x*x + h*x*x + i*x + j;
    if (y >= -450) {
      point(x, -y);
    }
  }
  popMatrix();
}
void displayCircle (float a, float b, float r) {
  a = 3;
  b = 2;
  r = 40;
  // r = R*R 
  stroke(255);
  pushMatrix();
  translate (origin.x, origin.y);
  for (float x = -width/2; x < width/2; x+=0.0125) {
    for (float y = -height/2; y < height/2; y+=0.0125) {
      if ((x-a)*(x-a) + (y-b)*(y-b) == r && (y-b)*(y-b) >= -450){
        point (x, -y);
      }
    }
  }
  popMatrix();
}
void draw () {
  stroke(255, 0, 0);
  line(0, 450, 1800, 450);
  line(900, 0, 900, 900);
  stroke (255); 
  line (0, 900, 1900, 900);
  fill(255,255,255);
  //displayCircle(3, 2 ,40);
  if (decideDisplay == 0) {
    background(0);
    stroke(255, 0, 0);
    line(0, 450, 1800, 450);
    line(900, 0, 900, 900);
    stroke (255); 
    line (0, 900, 1900, 900);
    decideDisplay = 3;
  }
  else if (decideDisplay == 1) {
    cosgraphDisplay();
  }
  else if (decideDisplay == 2) {
    singraphDisplay();
  }
}
