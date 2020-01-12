  
PFont myFont;
PFont myFont2;

void setup(){
  size(960, 540);
  //String[] fontList = PFont.list();
  //printArray(fontList);
  myFont = createFont("Chiller",32);
  //myFont = createFont("Colonna MT",32);
  //myFont = createFont("Bauhaus 93",24);
  //myFont = createFont("Jokerman",24);
  //myFont = createFont("Freestyle Script",24);
  //myFont = createFont("Vivaldi",24);
  //myFont = createFont("Vladimir Script",24);
  myFont2 = createFont("Lucida Sans Regular",24);
  
  size(960, 540);
  today = new Date(0,0,0);
  today.todayDate();
  today.dow();
  
  dateDisp = new Date(0,0,0);
  dateDisp.todayDate();
  dateDisp.d = 1;
  
  dateDisp.domUpd();
  datePosUpd();
  dispRooms = new Rooms(dateDisp.m,dateDisp.y);


  cellWidth = width/15;
  cellGap = cellWidth/10;
  topMargin = int(cellWidth*1.5);
  leftMargin = (width-(cellWidth*7+cellGap*6))/2;

}

int mousePos = 0;

int [] transition = {1,0};
int time = 50;
int dispState = 0;

void draw() {
  
    
  switch(dispState) {
  case 0: 
    menu();  // Does not execute
    break;
  case 1: 
    calendar();  // Prints "One"
    break;
  }
  
  if(transition[0]==1){
    
    fade(time);
    time+=1;
    
    if(time>50) dispState = transition[1];
    
    if(time>100) {
    transition[0] = 0;
    time=0;
  }
    
  }
  
}

void mouseClicked() {

  switch(dispState){
  case 0:
    if(mousePos == 1) {
    
      transition[0] = 1;
      transition[1] = 1;
  
    }
    break;
  
  case 1:
      //change month for left arrow
    if(mouseX>leftMargin+cellWidth/2 && mouseX<leftMargin+cellWidth && mouseY>(topMargin/3+cellGap) && mouseY<topMargin/3+topMargin*2/3*0.8-cellGap) {
      
      dateDisp.m -=1;
      
      if (dateDisp.m == 0){ 
        dateDisp.m = 12;
        dateDisp.y -=1;
      }
      
      dateDisp.domUpd();
      dispRooms.reloadData(dateDisp.m,dateDisp.y);  
      datePosUpd();
      
    }
    
    //change month for right arrow  
    if(mouseX<width-(leftMargin+cellWidth/2) && mouseX>width-(leftMargin+cellWidth) && mouseY>(topMargin/3+cellGap) && mouseY<topMargin/3+topMargin*2/3*0.8-cellGap) {
      
      dateDisp.m +=1;
      
      if (dateDisp.m == 13){ 
        dateDisp.m = 1;
        dateDisp.y +=1;
      }
      
      dateDisp.domUpd();
      dispRooms.reloadData(dateDisp.m,dateDisp.y);
      datePosUpd();
      
    }
    
    if(mouseDate>0) println(mouseDate);
    
    break;

  }
  

}

void fade(int t){
  fill(0,0,25,sin(t*2*PI/200)*255);
  rect(0,0,width,height);
}
