Reservation resv;

class Reservation{
  
  Date date;
  RoomType rm;
  
  String name;
  
  int number;
  
  Reservation(Date d, RoomType rt){
  
    date = d;
    rm = rt;
    
  }
}

void reserveScreen(){
  
  background(colBg);
  fill(255);
  text("Check-in Date: "+monthName[reserveDate.m]+" "+reserveDate.d+" "+reserveDate.y,width/2,height/2);

}
