package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dto.BoardDto;

public class BoardDao {

  Connection conn;
  PreparedStatement pstmt;

  public BoardDao() throws Exception {
    // DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db = "jdbc:mysql://localhost:3306/pension";
    conn = DriverManager.getConnection(db, "root", "root");
  }


  public void write_ok(HttpServletRequest request, HttpSession session,
      HttpServletResponse response) throws Exception {
    request.setCharacterEncoding("utf-8");
    String title = request.getParameter("title");
    String pwd = request.getParameter("pwd");
    String content = request.getParameter("content");


    // 비밀번호 -> 회원인 경우는 비밀번호가 없어도 됨

    // board 테이블의 userid는 로그인한 경우 세션변스의 userid를
    // 로그인을 안했으면 'guest'
    String userid;
    if (session.getAttribute("userid") == null) {
      userid = "guest";
    } else {
      userid = session.getAttribute("userid").toString();
    }

    String sql = "insert into board(title,pwd,content,userid,writeday) ";
    sql = sql + "values(?,?,?,?,now())";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, pwd);
    pstmt.setString(3, content);
    pstmt.setString(4, userid);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("list.jsp");
  }

  public void list(HttpServletRequest request) throws Exception {

    String sql = "select * from board order by id desc"; // id 정렬

    pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    // 여러개의 dto를 담을수 있는 ArrayList를 생성
    ArrayList<BoardDto> list = new ArrayList<BoardDto>();

    // rs에 있는 레코드를 dto에 저장 ->
    while (rs.next()) {
      BoardDto bdto = new BoardDto();
      bdto.setId(rs.getInt("id"));
      bdto.setTitle(rs.getString("title"));
      bdto.setUserid(rs.getString("userid"));
      bdto.setReadnum(rs.getInt("readnum"));
      bdto.setWriteday(rs.getString("writeday"));

      list.add(bdto);
    }

    // 내장 객체 영역에 list 저장
    request.setAttribute("list", list);
  }

  public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {

    String id = request.getParameter("id");
    String sql = "update board set readnum=readnum+1 where id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    response.sendRedirect("../board/content.jsp?id=" + id);
  }

  public void content(HttpServletRequest request) throws Exception {
    String id = request.getParameter("id");

    String sql = "select * from board where id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery();
    rs.next();

    BoardDto bdto = new BoardDto();
    bdto.setId(rs.getInt("id"));
    bdto.setTitle(rs.getString("title"));
    bdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
    bdto.setUserid(rs.getString("userid"));
    bdto.setReadnum(rs.getInt("readnum"));
    bdto.setWriteday(rs.getString("writeday"));

    request.setAttribute("bdto", bdto);
  }

  public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
    // 회원이 삭제하면 id만
    // guest가 삭제하면 id, pwd

    String id = request.getParameter("id");

    if (request.getParameter("pwd") == null) {


      String sql = "delete from board where id=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      pstmt.executeUpdate();
      pstmt.close();
      conn.close();

      response.sendRedirect("../board/list.jsp");
    } else {
      String pwd = request.getParameter("pwd");

      String sql = "select pwd from board where id=?";

      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      //System.out.println(pstmt.toString());
      ResultSet rs = pstmt.executeQuery();
      rs.next();
      
      String dbpwd = rs.getString("pwd");

      if (pwd.equals(dbpwd)) {
        sql = "delete from board where id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
        pstmt.close();
        conn.close();

        response.sendRedirect("../board/list.jsp");
      } else {
        pstmt.close();
        conn.close();
        response.sendRedirect("../board/content.jsp");        
      }

    }    
  }

  public void update(HttpServletRequest request) throws Exception {
    String id=request.getParameter("id");
    
    String sql = "select * from board where id=?";
    
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery();
    rs.next();

    BoardDto bdto = new BoardDto();
    bdto.setId(rs.getInt("id"));
    bdto.setTitle(rs.getString("title"));
    bdto.setContent(rs.getString("content"));
    bdto.setUserid(rs.getString("userid"));
    request.setAttribute("bdto", bdto);    
  }
  
  public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    String id=request.getParameter("id");
    String pwd=request.getParameter("pwd");
    String title=request.getParameter("title");
    String content=request.getParameter("content");
      
    if(pwd==null) {
        String sql="update board set content=?, title=? where id=?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1, content);
        pstmt.setString(2,title);
        pstmt.setString(3, id);
        
        pstmt.executeUpdate();
        
        pstmt.close();
        conn.close();
        
        response.sendRedirect("content.jsp?id="+id);
    } else {
 
      String sql = "select pwd from board where id=?";

      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      //System.out.println(pstmt.toString());
      ResultSet rs = pstmt.executeQuery();
      rs.next();
      
      String dbpwd = rs.getString("pwd");
      if(pwd.equals(dbpwd)) {
        sql="update board set content=?, title=? where id=?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1, content);
        pstmt.setString(2,title);
        pstmt.setString(3, id);
      
        pstmt.executeUpdate();
        
        pstmt.close();
        conn.close();
        
        response.sendRedirect("content.jsp?id="+id);
      } else {
        response.sendRedirect("update.jsp?id="+id);
      }
    }   
  }
  
  public void getThree(HttpServletRequest request) throws Exception {
    String sql="select * from board order by id desc limit 3";
    
    pstmt=conn.prepareStatement(sql);
    ResultSet rs=pstmt.executeQuery();
    
    ArrayList<BoardDto> blist=new ArrayList<BoardDto>();
    
    //rs->dto->blist
    while(rs.next()) {
      BoardDto bdto=new BoardDto();
      bdto.setId(rs.getInt("id"));
      bdto.setUserid(rs.getString("userid"));
      if(rs.getString("title").length() > 11) {
      bdto.setTitle(rs.getString("title").substring(0,11)+"~");
      } else {
        bdto.setTitle(rs.getString("title"));
      }
      bdto.setWriteday(rs.getString("writeday"));
      
      blist.add(bdto);
    }
    request.setAttribute("blist", blist);
  }
  
}
