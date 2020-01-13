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
    
    //rect();
    fill(255);
    text("\n\n"+roomTypes[i].name,width/2+100*(i-float(roomTypes.length-1)/2),height*0.45);
  }
  resv.typeUpd(1);
  
  text(resv.rm.name, width/2,height*0.8);


}
