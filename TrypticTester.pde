// Use in combination with MultipleClients

import codeanticode.syphon.*;

int nServers = 2;
PGraphics[] canvas;
SyphonServer[] servers;
color[] colors;

void settings() {
  size(320, 480, P3D);
  PJOGL.profile = 1;
}

void setup() {
  canvas = new PGraphics[nServers];
  for (int i = 0; i < nServers; i++) {
    canvas[i] = createGraphics(320, 240, P3D);
  }
  colors = new color[2];
  colors[0] = color(255, 0, 0);
  colors[1] = color(0, 255, 0);

  String[] names = new String[2];
  names[0] = "Front";
  names[1] = "Back";

  // Create syhpon servers to send frames out.
  servers = new SyphonServer[nServers];
  for (int i = 0; i < nServers; i++) { 
    servers[i] = new SyphonServer(this, names[i]);
  }
}

void draw() {
  for (int i = 0; i < nServers; i++) {
    canvas[i].beginDraw();
    canvas[i].background(colors[i]);
    canvas[i].lights();
    canvas[i].translate(canvas[i].width/2, canvas[i].height/2);
    canvas[i].rotateX(frameCount * 0.01);
    canvas[i].rotateY(frameCount * 0.01);  
    canvas[i].box(100);
    canvas[i].endDraw();
    image(canvas[i], 0, 240 * i);
    servers[i].sendImage(canvas[i]);    
  }    
}