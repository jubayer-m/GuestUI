boolean thisMonth;

class Date{

  int d,m,y,w,dom;
  
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
  
  void domUpd(){
    
    dateDisp.dow();
    
    if (dateDisp.y%4 == 0 && dateDisp.m == 2) this.dom = 29;
    else this.dom = monthLen[dateDisp.m];

  
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

float cellWidth = 0;
float cellGap = 0;
float topMargin = 0;
float leftMargin = 0;
int mouseDate = 0;

Date today;
Date dateDisp;
Date reserveDate;

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
      if(thisMonth && today.d == datePos[i][j]) fill(colSl);
      else fill(255);
      if(!(thisMonth && datePos[i][j]<=today.d) && datePos[i][j]>0 && mouseX>leftMargin+i*(cellWidth+cellGap) && mouseX<leftMargin+i*(cellWidth+cellGap)+cellWidth && mouseY > topMargin+2*cellGap+j*(cellWidth+cellGap) && mouseY < topMargin+2*cellGap+j*(cellWidth+cellGap)+cellWidth){
        mouseDate = datePos[i][j]; 
        //stroke(255);
        //stroke(colSl);
        strokeWeight(cellGap/2);
      }
      //else stroke(255);
      stroke(255);
      //dayCell
      rect(leftMargin+i*(cellWidth+cellGap),topMargin+2*cellGap+j*(cellWidth+cellGap),cellWidth,cellWidth,cellGap);
      stroke(colBg);
      strokeWeight(0);
    
      fill(25);
      textSize(topMargin/6);
      if(datePos[i][j]>0) {
        
        //date
        text(datePos[i][j],leftMargin+i*(cellWidth+cellGap)+cellWidth/2,topMargin+j*(cellWidth+cellGap)+cellWidth/2);
        
        //availability level color code
        
        if(thisMonth && datePos[i][j]<=today.d) continue;
        color [] colLev = new color[roomTypes.length];
        dispRooms.colorLevel(datePos[i][j],colLev);
        for(int k=0;k<roomTypes.length;k++){
          fill(colLev[k]);
          stroke(colLev[k]);
          float factor =1;
          rect(leftMargin+i*(cellWidth+cellGap)+cellWidth*k/roomTypes.length,topMargin+2*cellGap+j*(cellWidth+cellGap)+cellWidth-2*cellGap,cellWidth/roomTypes.length,cellGap*2,cellGap);
          if(k==0) factor=0.5;
          rect(leftMargin+i*(cellWidth+cellGap)+cellWidth*k/roomTypes.length,topMargin+2*cellGap+j*(cellWidth+cellGap)+cellWidth-2.5*cellGap,cellWidth*0.75/roomTypes.length,cellGap*2.5*factor);
          if(k==roomTypes.length-1) factor =0.5;
          else factor = 1;
          rect(leftMargin+i*(cellWidth+cellGap)+cellWidth*(k+0.5)/roomTypes.length,topMargin+2*cellGap+j*(cellWidth+cellGap)+cellWidth-2.5*cellGap,cellWidth*0.5/roomTypes.length,cellGap*2.5*factor);
          stroke(colBg);
        }
        //text(avalRoom[0]+","+avalRoom[1],leftMargin+i*(cellWidth+cellGap)+cellWidth/2,topMargin+j*(cellWidth+cellGap)+cellWidth*0.8);

      }
  
    }
  }
  
  //header
  fill(255);
  rect(leftMargin,topMargin/3,cellWidth*7+cellGap*6,topMargin*2/3*0.8);
  
  fill(25);
  
  //display month,year
  textSize(topMargin/3);
  text(monthName[dateDisp.m-1],width/2,topMargin*1.8/3);
  textSize(topMargin/6);
  text(dateDisp.y,width/2,topMargin*1.2/3);

  //arrows
  triangle(width-(leftMargin+cellWidth),topMargin/3+cellGap,width-(leftMargin+cellWidth),topMargin/3+topMargin*2/3*0.8-cellGap,width-(leftMargin+cellWidth/2),topMargin*1.8/3);
  if(thisMonth) fill(250);
  triangle(leftMargin+cellWidth,topMargin/3+cellGap,leftMargin+cellWidth,topMargin/3+topMargin*2/3*0.8-cellGap,leftMargin+cellWidth/2,topMargin*1.8/3);

}



//position of each date on display

void datePosUpd(){

  //int x = dateDisp.w;
  //int y = 0;
  int n = 0;
  for(int i=0;i<6;i++){
    for(int j=0;j<7;j++){
      if(i>0||j>=dateDisp.w)n++;
      if(n<=dateDisp.dom) datePos[j][i] = n;
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
