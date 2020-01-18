  
PFont myFont;
PFont myFont2;

color colBg = color(0,0,25); //dark-blue
color colGr = color(130,255,100); //green
color colYl = color(255,240,100); //yellow
color colRd = color(255,100,100); //red
color colSl = color(200,255,255); //cyan

String txt = "";


void setup(){
  size(960, 540);
  //String[] fontList = PFont.list();
  //printArray(fontList);
  //myFont = createFont("Chiller",32);
  myFont = createFont("Colonna MT",32);
  //myFont = createFont("Bauhaus 93",24);
  //myFont = createFont("Jokerman",24);
  //myFont = createFont("Freestyle Script",24);
  //myFont = createFont("Vivaldi",24);
  //myFont = createFont("Vladimir Script",24);
  //myFont = createFont("Lucida Sans Regular",24);
  myFont2 = createFont("Lucida Sans Regular",24);

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
  case 2:
    reserveScreen();
    break;
  case 3:
    detailsScreen();
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
  if(transition[0]==0){
    switch(dispState){
    case 0:
      if(mousePos == 1) {
        
        today = new Date(0,0,0);
        today.todayDate();
        today.dow();
        
        dateDisp = new Date(today.d,today.m,today.y);
        //dateDisp.todayDate();
        dateDisp.d = 1;
        
        thisMonth = true;
        
        roomTypes = new RoomType[2];
        //roomTypes = new RoomType[3];
      
        roomTypes[0] = new RoomType("standard",12,5000);
        roomTypes[1] = new RoomType("luxury",4,10000);
        //roomTypes[2] = new RoomType("exclusive",4, 20000);
               
        dateDisp.domUpd();
        datePosUpd();
        dispRooms = new Rooms(dateDisp.m,dateDisp.y,dateDisp.dom);
          
        cellWidth = width/15;
        cellGap = cellWidth/10;
        topMargin = int(cellWidth*1.5);
        leftMargin = (width-(cellWidth*7+cellGap*6))/2;
      
        transition[0] = 1;
        transition[1] = 1; 
      }
      break;
    
    case 1:
        //change month for left arrow
      if(!thisMonth && mouseX>leftMargin+cellWidth/2 && mouseX<leftMargin+cellWidth && mouseY>(topMargin/3+cellGap) && mouseY<topMargin/3+topMargin*2/3*0.8-cellGap) {
        
        dateDisp.m -=1;
        
        if (dateDisp.m == 0){ 
          dateDisp.m = 12;
          dateDisp.y -=1;
        }
        
        if(dateDisp.y == today.y && today.m == dateDisp.m) thisMonth = true;
        else thisMonth = false;
  
        dateDisp.domUpd();
        dispRooms.reloadData(dateDisp.m,dateDisp.y,dateDisp.dom);  
        datePosUpd();
        
      }
      
      //change month for right arrow  
      if(mouseX<width-(leftMargin+cellWidth/2) && mouseX>width-(leftMargin+cellWidth) && mouseY>(topMargin/3+cellGap) && mouseY<topMargin/3+topMargin*2/3*0.8-cellGap) {
        
        dateDisp.m +=1;
        
        if (dateDisp.m == 13){ 
          dateDisp.m = 1;
          dateDisp.y +=1;
        }
        
        if(dateDisp.y == today.y && today.m == dateDisp.m) thisMonth = true;
        else thisMonth = false;
        
        dateDisp.domUpd();
        dispRooms.reloadData(dateDisp.m,dateDisp.y,dateDisp.dom);
        datePosUpd();
        
      }
      
      if(mouseDate>0) {
        
        int [] n = new int[roomTypes.length];
        
        dispRooms.roomCount(mouseDate, n);
        
        boolean notAllZero = false;
        
        for(int i=0; i<roomTypes.length; i++){
        
          if (n[i]>0) {
            notAllZero = true;
            break;
          }
        
        }
        
        if(notAllZero){
          
          reserveDate = new Date(0,0,0);
          
          reserveDate.d = mouseDate;
          reserveDate.m = dateDisp.m;
          reserveDate.y = dateDisp.y;
          
          int tp=0;
          
          while(n[tp]==0) tp++;
          
          resv = new Reservation(reserveDate, tp);
          
          transition[0] = 1;
          transition[1] = 2;
          
        }
        
        /*else{
        
          fill(colRd);
          text("no rooms available on the selected date",width*0.8,height*0.9);
        
        }*/
        
      }
      
      break;
    
    case 2:
      
      if(mouseY> height*(0.65+0.01+0.1) && mouseY< height*(0.65+0.01+0.1)+height*0.065){
        if(mouseX> width/2-width*0.05+(width*0.1+cellGap)*(-float(roomTypes.length-1)/2) && mouseX< width/2-width*0.05+(width*0.1+cellGap)*(-float(roomTypes.length-1)/2)+width*0.1){ 
          transition[0] = 1;
          transition[1] = 1;          
        }
        if(mouseX> width/2-width*0.05+(width*0.1+cellGap)*(1-float(roomTypes.length-1)/2) && mouseX< width/2-width*0.05+(width*0.1+cellGap)*(1-float(roomTypes.length-1)/2)+width*0.1){ 
            
          resv.reserve();
          dispRooms.decrementRoom();
          
          transition[0] = 1;
          transition[1] = 3;          
        }
      }
      
      if(mouseY>height*(0.45+0.05/2) && mouseY<height*(0.45+0.05/2)+height*0.1){
        
        int [] n = new int[roomTypes.length];
        
        dispRooms.roomCount(resv.date.d, n);
        
        for(int i=0;i<roomTypes.length;i++){
          if(n[i]>0 && mouseX>width/2-width*0.05+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2) && mouseX<width/2-width*0.05+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2)+width*0.1){
          
            resv.typeUpd(i);
          
          }
        }

      }

    
      break;
  
    }
  }  

}

void keyTyped(){
  
  if(dispState==2){
  
    if (key == BACKSPACE){
      
      if(txt.length()>0) txt = txt.substring(0,txt.length()-1);
  
  
    }
    
    else txt = txt + key;
  
  }

}

void fade(int t){
  fill(0,0,25,sin(t*2*PI/200)*255);
  rect(0,0,width,height);
}
