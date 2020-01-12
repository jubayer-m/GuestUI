Rooms dispRooms;

class Rooms{

  Table monthRooms;
  
  Rooms(int m, int y){
    
    monthRooms = new Table();
    loadData(m,y);    
  
  }
  
  void reloadData(int m, int y){
    
    this.monthRooms.clearRows();
    loadData(m,y);
  
  }
  
  void loadData(int m, int y) {

    File f = dataFile("C:\\Users\\jubay\\Desktop\\HRS\\GuestUI\\data\\availability\\"+m+"_"+y+".csv");
    boolean exist = f.isFile();
  
    if(exist){
      monthRooms = loadTable("C:\\Users\\jubay\\Desktop\\HRS\\GuestUI\\data\\availability\\"+m+"_"+y+".csv");
    
    
      for (int i = 0; i<monthRooms.getRowCount(); i++) {
        // Iterate over all the rows in a table.
        TableRow row = monthRooms.getRow(i);
        
        // Access the fields via their column name (or index).
        int d = row.getInt("date");
        int snum = row.getInt("standard");
        int lnum = row.getInt("luxury");
        // Make a Bubble object out of the data from each row.
        println(d+""+snum+""+lnum);
      }
    }
    else {
    
    monthRooms = new Table();
    
    monthRooms.addColumn("date");
    monthRooms.addColumn("standard");
    monthRooms.addColumn("luxury");
    
    for(int i=1; i<=monthLen[m]; i++)    {
    TableRow row = monthRooms.addRow();
    
    row.setInt("date", i);
    row.setInt("standard", 12);
    row.setInt("luxury", 4);
    }
    
    saveTable(monthRooms, "C:\\Users\\jubay\\Desktop\\HRS\\GuestUI\\data\\availability\\"+m+"_"+y+".csv");
  
    }
  }  
}
