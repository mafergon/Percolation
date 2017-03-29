float data[][] = new float[450000][2];
color colors[] = new color[450000];
float grid_size;
int rep_per_frame;
float box_size;
int data_len;
void setup(){
  size(800,800);
  call_datos();
  background(0);
  frameRate(500);
}

int contador = 0;
void draw(){
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


void call_datos(){
  String laux[] = loadStrings("params.txt");
  grid_size = float(laux[0]);
  rep_per_frame = int(laux[1]);
  box_size = width/grid_size;
  String lines[] = loadStrings("output.txt");
  data_len = lines.length;
  for (int i = 0; i < lines.length; i++){
     String aux[] = split(lines[i],','); 
     data[i][0] = map(float(aux[0]),1,grid_size,0,width);
     data[i][1] = map(float(aux[1]),1,grid_size,0,width);
     float temp = float(aux[2]);
     int temp2 = int(temp*10);
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