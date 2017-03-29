import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Ploter extends PApplet {

float data[][] = new float[450000][2];
int colors[] = new int[450000];
float grid_size;
int rep_per_frame;
float box_size;
int data_len;
public void setup(){
  
  call_datos();
  background(0);
  frameRate(500);
}

int contador = 0;
public void draw(){
  if (keyPressed == true){
    call_datos();
    contador = 0;
    background(0);
  }
  for (int i = 0; i < rep_per_frame; i++){
    fill (colors[contador]);
    stroke(colors[contador]);
    rect(data[contador][0],data[contador][1],box_size,box_size);
    contador ++;
  }
  if (contador == data_len){
     noLoop(); 
  }
  
}


public void call_datos(){
  String laux[] = loadStrings("params.txt");
  grid_size = PApplet.parseFloat(laux[0]);
  rep_per_frame = PApplet.parseInt(laux[1]);
  box_size = width/grid_size;
  String lines[] = loadStrings("output.txt");
  data_len = lines.length;
  for (int i = 0; i < lines.length; i++){
     String aux[] = split(lines[i],','); 
     data[i][0] = map(PApplet.parseFloat(aux[0]),1,grid_size,0,width);
     data[i][1] = map(PApplet.parseFloat(aux[1]),1,grid_size,0,width);
     float temp = PApplet.parseFloat(aux[2]);
     int temp2 = PApplet.parseInt(temp*10);
     if (temp2 == 0){
       colors[i] = color(0,0,255);
     }
     else if (temp2 == 1){
       colors[i] = color(0);
     }
     else if (temp2 == 3){
       colors[i] = color(255,0,0);
     }
     else if (temp2 == 6){
       colors[i] = color(128);
     }
  }
  
}
  public void settings() {  size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Ploter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
