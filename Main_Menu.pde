void menu(){  
  background(0,0,25);
  fill(255);
  textFont(myFont);
  textAlign(CENTER,CENTER);
  textSize(height/4);
  text("Hotel 54",width/2,height*0.35);
  //textSize(height/8);
  //text("Hotel",width/2,height*0.2);
  
  //textFont(myFont);
  //textSize(height/3);
  //text("54",width/2,height*0.3);  
  

  //textFont(myFont);
  
  mousePos = 0;
  //textFont(myFont2);
  if(pow((mouseX-width/2),2)<22500 && mouseY>height*0.6 && mouseY<height*0.675){   
    textSize(height/8);
    mousePos = 1;
  }
  
  else textSize(height/12);
  text("New Reservation",width/2,height*0.625);
  
  if(pow((mouseX-width/2),2)<30000 && mouseY>height*0.725 && mouseY<height*0.8){   
    textSize(height/8);
    mousePos = 2;
  }
  else textSize(height/12);
  text("Cancel Reservation",width/2,height*0.75);
}
