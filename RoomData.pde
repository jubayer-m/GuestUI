Rooms dispRooms;
RoomType[] roomTypes;



class RoomType{

  String name;
  int maxNum;
  int basePrice;
  
  RoomType(String nm, int n, int p){
    
    name = nm;
    maxNum = n;
    basePrice = p;
  
  }

}


class Rooms{

  Table monthRooms;
  
  Rooms(int m, int y, int dom){
    
    monthRooms = new Table();
    loadData(m,y,dom);    
  
  }
  
  void reloadData(int m, int y, int dom){
    
    this.monthRooms.clearRows();
    loadData(m,y,dom);
  
  }
  
  void roomCount(int d, int [] num){
    
    TableRow row = this.monthRooms.getRow(d-1);
    for(int i=0;i<roomTypes.length;i++){
      num[i] = row.getInt(roomTypes[i].name);    
    }
    
  }
  
  void colorLevel(int d, color [] col){
  
    TableRow row = this.monthRooms.getRow(d-1);
    
    for(int i=0;i<roomTypes.length;i++){
    
      int num = row.getInt(roomTypes[i].name);
      if(num>roomTypes[i].maxNum/4) col[i] = colGr;
      else if(num==0) col[i] = colRd;
      else col[i] = colYl;
    
    }  
  
  }
  
  void loadData(int m, int y, int dom) {

    File f = dataFile("C:\\Users\\jubay\\Desktop\\HRS\\data\\availability\\"+monthName[m-1]+"_"+y+".csv");
    boolean exist = f.isFile();
  
    if(exist){
      
      monthRooms = loadTable("C:\\Users\\jubay\\Desktop\\HRS\\data\\availability\\"+monthName[m-1]+"_"+y+".csv","header");
    
    }
    else {
      
      monthRooms = new Table();
      
      monthRooms.addColumn("date");
      for(int i=0;i<roomTypes.length;i++){
        monthRooms.addColumn(roomTypes[i].name);
      }
      //monthRooms.addColumn("standard");
      //monthRooms.addColumn("luxury");
      
      for(int i=1; i<=dom; i++)    {
        TableRow row = monthRooms.addRow();
        
        row.setInt("date", i);
        
        for(int j=0;j<roomTypes.length;j++){
          row.setInt(roomTypes[j].name, roomTypes[j].maxNum);
        }
        //row.setInt("standard", 12);
        //row.setInt("luxury", 4);
      }
    
      saveTable(monthRooms, "C:\\Users\\jubay\\Desktop\\HRS\\data\\availability\\"+monthName[m-1]+"_"+y+".csv");
  
    }
  }
  
  void decrementRoom(){
  
    TableRow row = this.monthRooms.getRow(resv.date.d-1);
    
    int n = row.getInt(roomTypes[resv.typeNum].name);
    
    n--;
    
    this.monthRooms.setInt(resv.date.d-1,roomTypes[resv.typeNum].name,n);
    
    saveTable(monthRooms, "C:\\Users\\jubay\\Desktop\\HRS\\data\\availability\\"+monthName[resv.date.m-1]+"_"+resv.date.y+".csv");

    
  }
  
}
