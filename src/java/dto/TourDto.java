package dto;

public class TourDto {
  int id, readnum, cnt;
  String title, userid, content, writeday, img;
  String fname;
  String[] file;
  
  public String[] getFile() {
    return file;
  }

  public void setFile(String[] file) {
    this.file = file;
  }

  public String getFname() {
    return fname;
  }

  public void setFname(String fname) {
    this.fname = fname;
  }  
  
  public String getImg() {
    return img;
  }

  public void setImg(String img) {
    this.img = img;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getReadnum() {
    return readnum;
  }

  public void setReadnum(int readnum) {
    this.readnum = readnum;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getWriteday() {
    return writeday;
  }

  public void setWriteday(String writeday) {
    this.writeday = writeday;
  }
}
