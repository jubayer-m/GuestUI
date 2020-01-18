Reservation resv;

class Reservation{
  
  Date date;
  int typeNum;
  RoomType rm;
  float priceFactor;
  
  String name;
  
  int [] number;
  
  Reservation(Date d, int n){
  
    date = d;
    typeNum = n;
    rm = roomTypes[typeNum];
    
    this.calcPrice();
    
  }
  
  void calcPrice(){
    
    int mf = this.date.m%6;
    
    if (mf==1) this.priceFactor = 2;
    else if (mf==2 || mf==3) this.priceFactor = 0.8;
    else this.priceFactor = 1;
  
  }
  
  void typeUpd(int n){
    
    this.typeNum = n;
    this.rm = roomTypes[typeNum];   

  }
  
  void reserve(){
    
    int price = int(roomTypes[this.typeNum].basePrice*this.priceFactor);
    
    int n=0;
    boolean exist=true;
    
    File f;
    
    while (exist){
      n++;
      f = dataFile("C:\\Users\\jubay\\Desktop\\HRS\\data\\reservations\\all\\all reservations_"+n+".csv");    
      exist = f.isFile();
    }
    
    n--;
    
    this.number = new int[3];
  
    Table table;
    
    table = loadTable("C:\\Users\\jubay\\Desktop\\HRS\\data\\reservations\\all\\all reservations_"+n+".csv","header");
    
    this.number[0] = int(random(100,999));
    this.number[1] = n*1000+table.getRowCount()+1;
    this.number[2] = int(random(100,999));
    
    if(table.getRowCount()>=1000) {
      n++;
      table.clearRows();
    }
    
    TableRow row = table.addRow();
    
    row.setInt("year",this.date.y);
    row.setInt("month",this.date.m);
    row.setInt("date",this.date.d);
    
    row.setInt("lead number", this.number[0]);
    row.setInt("serial number",this.number[1]);
    row.setInt("trail number",this.number[2]);
    
    row.setInt("type",this.typeNum);
    row.setInt("price",price);

        
    saveTable(table,"C:\\Users\\jubay\\Desktop\\HRS\\data\\reservations\\all\\all reservations_"+n+".csv");
  
    
    f = dataFile("C:\\Users\\jubay\\Desktop\\HRS\\data\\availability\\reservations\\daily\\"+this.date.y+"\\"+monthName[this.date.m-1]+"\\"+this.date.d+".csv");
    exist = f.isFile();
  
    if(exist){
      
      table = loadTable("C:\\Users\\jubay\\Desktop\\HRS\\data\\reservations\\daily\\"+this.date.y+"\\"+monthName[this.date.m-1]+"\\"+this.date.d+".csv","header");
    
    }
    else{
    
      table = new Table();
      
      table.addColumn("lead number");
      table.addColumn("serial number");
      table.addColumn("trail number");
      table.addColumn("type");
      table.addColumn("name");
      table.addColumn("price");
      //table.addColumn("status");
   
    }
    
    row = table.addRow();
    
    row.setInt("lead number", this.number[0]);
    row.setInt("serial number",this.number[1]);
    row.setInt("trail number",this.number[2]);
    
    row.setInt("type",this.typeNum);
    row.setInt("price",price);
   
    saveTable(table,"C:\\Users\\jubay\\Desktop\\HRS\\data\\reservations\\daily\\"+this.date.y+"\\"+monthName[this.date.m-1]+"\\"+this.date.d+".csv");

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
    rect(width/2-width*0.05+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*(0.45+0.05/2),width*0.1,height*0.1,cellGap);
    strokeWeight(0);
    stroke(colBg);
    fill(colLev[i]);
    rect(width/2-width*0.04+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*(0.45+0.075),width*0.08,cellGap*0.3,cellGap*0.1);
    fill(255);
    text("\n\n"+roomTypes[i].name,width/2+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*0.45);
    text("\n\n¥"+int(roomTypes[i].basePrice*resv.priceFactor),width/2+(width*0.1+cellGap)*(i-float(roomTypes.length-1)/2),height*0.5);

  }
  
  rect(width/2-width*0.05+(width*0.1+cellGap)*(-float(roomTypes.length-1)/2),height*(0.65+0.01),width*0.1,height*0.065,cellGap);
  rect(width/2-width*0.05+(width*0.1+cellGap)*(1-float(roomTypes.length-1)/2),height*(0.65+0.01),width*0.1,height*0.065,cellGap);
  
  fill(25);
  text("back",width/2+(width*0.1+cellGap)*(-float(roomTypes.length-1)/2),height*(0.65+0.075/2));
  text("confirm",width/2+(width*0.1+cellGap)*(1-float(roomTypes.length-1)/2),height*(0.65+0.075/2));

  //resv.typeUpd(1);
  
  //text(resv.rm.name, width/2,height*0.8);


}

void detailsScreen(){
  
  background(colBg);
  
  
  fill(255);
  text(resv.number[0]*100000+resv.number[1]+""+resv.number[2], width/2, height/2);



}
