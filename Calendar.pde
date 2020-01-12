class Date{

  int d,m,y,w;
  
  Date(int td, int tm, int ty){
  
    d = td;
    m = tm;
    y = ty;
  
  }
  
  void todayDate(){
  
  this.d = day();
  this.m = month();
  this.y = year();
  
  }
  
  void dow() {
    int tm = this.m;
    int ty = this.y;
    if (tm < 3) {
      tm += 12;
      ty--;
    }
    this.w = (this.d + int((tm+1)*2.6) +  ty + int(ty/4) + 6*int(ty/100) + int(ty/400) + 6) % 7;
  }
  
}

String[] dayName = { 
  "Sun", "Mon", "Tue", "Wed", 
  "Thu", "Fri", "Sat"
};

String [] monthName ={
 "January", "February", "March", "April", 
  "May", "June", "July","August",
  "September", "October", "November","December"
};

int [] monthLen = {29,31,28,31,30,31,30,31,31,30,31,30,31};

int [][] datePos = new int [7][6];

int cellWidth = 0;
int cellGap = 0;
int topMargin = 0;
int leftMargin = 0;
int mouseDate = 0;

Date today;
Date dateDisp;

void calendar() {
  
  background(0,0,25);
  
  textFont(myFont2);
  textAlign(CENTER,CENTER);
  fill(255,200,200);//Sunday
  mouseDate = 0;

    
  for(int i=0; i<7; i++){
    if(i>0) fill(255);
    //weekdayNames
    rect(leftMargin+i*(cellWidth+cellGap),topMargin-cellGap,cellWidth,2*cellGap,cellGap/2);
    fill(25);
    textSize(cellGap);
    text(dayName[i],leftMargin+i*(cellWidth+cellGap)+cellWidth/2,topMargin);
        
    for(int j=0; j<6; j++){
      
      //today
      if(dateDisp.y == today.y && dateDisp.m == today.m && today.w == i && floor((today.d-1+(7-today.w))/7) == j) fill(200,255,255);
      else fill(255);
      if(datePos[i][j]>0 && mouseX>leftMargin+i*(cellWidth+cellGap) && mouseX<leftMargin+i*(cellWidth+cellGap)+cellWidth && mouseY > topMargin+2*cellGap+j*(cellWidth+cellGap) && mouseY < topMargin+2*cellGap+j*(cellWidth+cellGap)+cellWidth){
        mouseDate = datePos[i][j]; 
        stroke(255,255,255);
        strokeWeight(cellGap/2);
      }
      //dayCell
      rect(leftMargin+i*(cellWidth+cellGap),topMargin+2*cellGap+j*(cellWidth+cellGap),cellWidth,cellWidth,cellGap);
      stroke(0,0,25);
      strokeWeight(0);
    
      fill(25);
      textSize(topMargin/6);
      if(datePos[i][j]>0) {
        text(datePos[i][j],leftMargin+i*(cellWidth+cellGap)+cellWidth/2,topMargin+j*(cellWidth+cellGap)+cellWidth/2);
        
      }
  
    }
  }
  
  //header
  fill(255);
  rect(leftMargin,topMargin/3,cellWidth*7+cellGap*6,topMargin*2/3*0.8);
  
  fill(25);
  
  //arrows
  triangle(leftMargin+cellWidth,topMargin/3+cellGap,leftMargin+cellWidth,topMargin/3+topMargin*2/3*0.8-cellGap,leftMargin+cellWidth/2,topMargin*1.8/3);
  triangle(width-(leftMargin+cellWidth),topMargin/3+cellGap,width-(leftMargin+cellWidth),topMargin/3+topMargin*2/3*0.8-cellGap,width-(leftMargin+cellWidth/2),topMargin*1.8/3);
  
  //display month,year
  textSize(topMargin/3);
  text(monthName[dateDisp.m-1],width/2,topMargin*1.8/3);
  textSize(topMargin/6);
  text(dateDisp.y,width/2,topMargin*1.2/3);

}



//position of each date on display

void datePosUpd(){

  dateDisp.dow();
  
  int dom = 0;
  if (dateDisp.y%4 == 0 && dateDisp.m == 2) dom = 29;
  else dom = monthLen[dateDisp.m];
  
  //int x = dateDisp.w;
  //int y = 0;
  int n = 0;
  for(int i=0;i<6;i++){
    for(int j=0;j<7;j++){
      if(i>0||j>=dateDisp.w)n++;
      if(n<=dom) datePos[j][i] = n;
      else datePos[j][i] = 0;
    } 
  }
  /**
  for (int i=1; i<=dom; i++){
    datePos[x][y]=i;
    x+=1;
    if(x==7) {
      x=0;
      y+=1;
    }  
  }**/

}
