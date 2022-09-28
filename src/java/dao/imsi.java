package dao;

import java.time.LocalDate;

public class imsi {

  public static void main(String[] args) {
    // TODO Auto-generated method stub
    LocalDate today=LocalDate.now();
    
    LocalDate dday=LocalDate.of(2022, 7, 15);
    
    System.out.println(today.isBefore(dday));
    
  }

}
