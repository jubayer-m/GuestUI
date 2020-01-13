Reservation resv;

class Reservation{
  
  Date date;
  int typeNum;
  RoomType rm;
  
  String name;
  
  int number;
  
  Reservation(Date d, int n){
  
    date = d;
    typeNum = n;
    rm = roomTypes[typeNum];   
    
  }
  
  void typeUpd(int n){
    
    this.typeNum = n;
    this.rm = roomTypes[typeNum];   

  }
  
}

void reserveScreen(){
  
  background(colBg);
  fill(255);
  text("Check-in Date:\n"+monthName[resv.date.m-1]+" "+resv.date.d+" "+resv.date.y,width/2,height*0.35);
  
  text("Room Type:", width/2,height*0.45);
  for(int i=0;i<roomTypes.length;i++){
    color [] colLev = new color[roomTypes.length];
    dispRooms.colorLevel(resv.date.d,colLev);
    fill(colBg);
    stroke(255);
    if(i == resv.typeNum) strokeWeight(cellGap/3);
    else strokeWeight(cellGap/10);
    rect(width/2-width*0.05+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*(0.45+0.05/2),width*0.1,height*0.075,cellGap);
    strokeWeight(0);
    stroke(colBg);
    fill(colLev[i]);
    rect(width/2-width*0.04+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*(0.45+0.075),width*0.08,cellGap*0.3,cellGap*0.1);
    fill(255);
    text("\n\n"+roomTypes[i].name,width/2+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*0.45);
  }
  //resv.typeUpd(1);
  
  //text(resv.rm.name, width/2,height*0.8);


}
