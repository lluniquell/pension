package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import dto.MemberDto;
import dto.ReserveDto;
import dto.RoomDto;

public class AdminDao {
  Connection conn;
  PreparedStatement pstmt;

  public AdminDao() throws Exception {
    // DB ¿¬°á
    Class.forName("com.mysql.jdbc.Driver");
    String db = "jdbc:mysql://localhost:3306/pension";
    conn = DriverManager.getConnection(db, "root", "root");
  }
  
  public void room_view(HttpServletRequest request) throws Exception {
    String sql="select * from room order by price asc";
    
    pstmt=conn.prepareStatement(sql);
           
    ResultSet rs=pstmt.executeQuery();
    
    ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
    
    while(rs.next()) {
      RoomDto rdto=new RoomDto();
      rdto.setId(rs.getInt("id"));
      rdto.setMin(rs.getInt("min"));
      rdto.setMax(rs.getInt("max"));
      rdto.setPrice(rs.getInt("price"));
      rdto.setState(rs.getInt("state"));
      rdto.setBang(rs.getString("bang"));
      
      rlist.add(rdto);
    }
    
    request.setAttribute("rlist",rlist);    
  }

  public String content_view(HttpServletRequest request, JspWriter out) throws Exception {
    String id=request.getParameter("id");
    
    String sql="select content from room where id=?";
    
    pstmt=conn.prepareStatement(sql);
    pstmt.setString(1, id);
    
    ResultSet rs=pstmt.executeQuery();
    rs.next();
    
    return rs.getString("content");
  }
  
  public void reserve_view(HttpServletRequest request) throws Exception {
    String sql="select reserve.*, room.bang, member.name, member.phone from reserve, room, member ";
    sql=sql+"where member.userid=reserve.userid and room.bang=reserve.bang_id order by id desc";
    
    /*
     * String sql="select reserve.*, room.bang from reserve, room ";
     * sql=sql+"where room.bang=reserve.bang_id order by id desc";
     */
    
  

    pstmt=conn.prepareStatement(sql);
    
    ResultSet rs=pstmt.executeQuery();
    
    ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
    
    while(rs.next()) {
      ReserveDto rdto=new ReserveDto();
      LocalDate today=LocalDate.now();
      String[] imsi=rs.getString("outday").split("-");
      int y=Integer.parseInt(imsi[0]);
      int m=Integer.parseInt(imsi[1]);
      int d=Integer.parseInt(imsi[2]);      
      
      rdto.setId(rs.getInt("id"));
      rdto.setInday(rs.getString("inday"));
      rdto.setOutday(rs.getString("outday"));
      rdto.setUserid(rs.getString("userid"));
      rdto.setBang_id(rs.getInt("bang_id"));
      rdto.setInwon(rs.getInt("inwon"));
      rdto.setCpack(rs.getInt("cpack"));
      rdto.setBbqpack(rs.getInt("bbqpack"));
      rdto.setTotal(rs.getInt("total"));
      rdto.setState(rs.getInt("state"));
      rdto.setBang_name(rs.getString("bang"));
      rdto.setUser_name(rs.getString("name"));
      rdto.setUserphone(rs.getString("phone"));
      rlist.add(rdto);
    }
    request.setAttribute("rlist", rlist);    
  }
  
  public void reserve_cancel(HttpServletRequest request) throws Exception {
    String id=request.getParameter("id");
    
    String sql="update reserve set state=2 where id=?";
    pstmt=conn.prepareStatement(sql);
    pstmt.setString(1, id);

    pstmt.executeUpdate();
    
    pstmt.close();
    conn.close();
        
  }
  
  public void member_check(HttpServletRequest request) throws Exception {
  
  
    
    String sql="select * from member order by userid asc";
    
    pstmt=conn.prepareStatement(sql);
    
    ResultSet rs=pstmt.executeQuery();
    
    ArrayList<MemberDto> mlist=new ArrayList<MemberDto>();
    while(rs.next()) {
      MemberDto mdto=new MemberDto();
      mdto.setUserid(rs.getString("userid"));
      mdto.setName(rs.getString("name"));
      mdto.setEmail(rs.getString("email"));
      mdto.setPhone(rs.getString("phone"));
      mdto.setWriteday(rs.getString("writeday"));
      mdto.setState(rs.getInt("state"));
      
      mlist.add(mdto);
    }
    request.setAttribute("mlist",mlist);
        
  }
  
  
}
