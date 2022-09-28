package dto;

public class ReserveDto {
  private int id, bang_id, inwon, cpack, bbqpack, total, state;
  private String inday, outday, userid, writeday, bang_name, user_name, userphone;

  public String getUser_name() {
    return user_name;
  }

  public void setUser_name(String user_name) {
    this.user_name = user_name;
  }

  public String getUserphone() {
    return userphone;
  }

  public void setUserphone(String userphone) {
    this.userphone = userphone;
  }

  public int getState() {
    return state;
  }

  public void setState(int state) {
    this.state = state;
  }

  public String getBang_name() {
    return bang_name;
  }

  public void setBang_name(String bang_name) {
    this.bang_name = bang_name;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getBang_id() {
    return bang_id;
  }

  public void setBang_id(int bang_id) {
    this.bang_id = bang_id;
  }

  public int getInwon() {
    return inwon;
  }

  public void setInwon(int inwon) {
    this.inwon = inwon;
  }

  public int getCpack() {
    return cpack;
  }

  public void setCpack(int cpack) {
    this.cpack = cpack;
  }

  public int getBbqpack() {
    return bbqpack;
  }

  public void setBbqpack(int bbqpack) {
    this.bbqpack = bbqpack;
  }

  public int getTotal() {
    return total;
  }

  public void setTotal(int total) {
    this.total = total;
  }

  public String getInday() {
    return inday;
  }

  public void setInday(String inday) {
    this.inday = inday;
  }

  public String getOutday() {
    return outday;
  }

  public void setOutday(String outday) {
    this.outday = outday;
  }

  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }

  public String getWriteday() {
    return writeday;
  }

  public void setWriteday(String writeday) {
    this.writeday = writeday;
  }


}
