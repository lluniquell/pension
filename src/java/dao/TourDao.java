package dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import dto.TourDto;

public class TourDao {
  Connection conn;
  PreparedStatement pstmt;

  public TourDao() throws Exception {
    // DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db = "jdbc:mysql://localhost:3306/pension";
    conn = DriverManager.getConnection(db, "root", "root");
  }

  public void write_ok(HttpServletRequest request, HttpServletResponse response,
      HttpSession session) throws Exception {
    String path = request.getSession().getServletContext().getRealPath("/tour/img");
    int size = 1024 * 1024 * 10;
    MultipartRequest multi =
        new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

    Enumeration<?> file = multi.getFileNames();
    String fname = "";
    while (file.hasMoreElements()) {
      // System.out.println(file.nextElement().toString());
      fname = fname + multi.getFilesystemName(file.nextElement().toString()) + ",";
    }

    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    String userid = session.getAttribute("userid").toString();

    String sql = "insert into tour(title,content,userid,fname,writeday) ";
    sql = sql + "values(?,?,?,?,now())";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, userid);
    pstmt.setString(4, fname);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("list.jsp");

  }

  public void list(HttpServletRequest request) throws Exception {
    String sql = "select *, length(fname)-length(replace(fname,',','')) as cnt, ";
    sql = sql + "substr(fname,1,instr(fname,',')-1) as img from tour order by id desc";

    pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    ArrayList<TourDto> list = new ArrayList<TourDto>();

    while (rs.next()) {
      TourDto tdto = new TourDto();
      tdto.setId(rs.getInt("id"));
      tdto.setTitle(rs.getString("title"));
      tdto.setUserid(rs.getString("userid"));
      tdto.setWriteday(rs.getString("writeday"));
      tdto.setReadnum(rs.getInt("readnum"));
      tdto.setCnt(rs.getInt("cnt"));
      tdto.setImg(rs.getString("img"));

      list.add(tdto);
    }
    request.setAttribute("list", list);


  }

  public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String id = request.getParameter("id");

    String sql = "update tour set readnum=readnum+1 where id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    pstmt.executeUpdate();
    response.sendRedirect("content.jsp?id=" + id);
  }

  public void content(HttpServletRequest request) throws Exception {
    String id = request.getParameter("id");

    String sql = "select * from tour where id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery();
    rs.next();

    TourDto tdto = new TourDto();
    tdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
    tdto.setReadnum(rs.getInt("readnum"));
    tdto.setTitle(rs.getString("title"));
    tdto.setUserid(rs.getString("userid"));
    tdto.setWriteday(rs.getString("writeday"));
    tdto.setId(rs.getInt("id"));
    tdto.setFile(rs.getString("fname").split(","));
    request.setAttribute("tdto", tdto);
  }

  public void getThree(HttpServletRequest request) throws Exception {
    String sql = "select * from tour order by id desc limit 3";

    pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    ArrayList<TourDto> tlist = new ArrayList<TourDto>();

    // rs->dto->blist
    while (rs.next()) {
      TourDto tdto = new TourDto();
      tdto.setId(rs.getInt("id"));
      tdto.setUserid(rs.getString("userid"));
      if (rs.getString("title").length() > 11) {
        tdto.setTitle(rs.getString("title").substring(0, 11) + "~");
      } else {
        tdto.setTitle(rs.getString("title"));
      }
      tdto.setWriteday(rs.getString("writeday"));

      tlist.add(tdto);
    }
    request.setAttribute("tlist", tlist);
  }

  public void update(HttpServletRequest request) throws Exception {
    String id = request.getParameter("id");

    String sql = "select * form tour where id=?";
    pstmt=conn.prepareStatement(sql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery();
    rs.next();

    TourDto tdto = new TourDto();
    tdto.setId(rs.getInt("id"));
    tdto.setTitle(rs.getString("title"));
    tdto.setContent(rs.getString("content"));
    tdto.setFile(rs.getString("fname").split(","));

    request.setAttribute("tdto", tdto);
  }

  public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String path = request.getSession().getServletContext().getRealPath("/tour/img");
    int size = 1024 * 1024 * 10;
    MultipartRequest multi =
        new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

    String[] del = multi.getParameter("del").split(",");

    for (int i = 0; i < del.length; i++) {
      File file = new File(path + "/" + del[i]);
      if (file.exists()) {
        file.delete();
      }
    }
    String str = multi.getParameter("str");
    // 새로 업로드 되는 파일의 이름을 저장
    Enumeration<?> file = multi.getFileNames();

    String fname = "";
    while (file.hasMoreElements()) {
      fname = fname + multi.getFilesystemName(file.nextElement().toString()) + ",";
    }


    // 합치기
    fname = fname.replace("null,", "");
    fname = fname + str;
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    String id = multi.getParameter("id");

    // 쿼리 생성
    String sql = "update tour set title=?, content=?, fname=? where id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, fname);
    pstmt.setString(4, id);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("content.jsp?id=" + id);
  }

  public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    int id = Integer.parseInt(request.getParameter("id"));

    String sql = "select fname from tour where id="+id;
    pstmt = conn.prepareStatement(sql);
    //pstmt.setInt(1, id);
    System.out.println(pstmt.toString());
    ResultSet rs = pstmt.executeQuery(sql);
    rs.next();
    String[] del = rs.getString("fname").split(",");
    
     String path = request.getSession().getServletContext().getRealPath("/tour/img");
      for (int i = 0; i < del.length; i++) 
      {
        File file = new File(path + "/" + del[i]); 
        if(file.exists()) 
        {
          file.delete(); 
        } 
      }
     
      sql = "delete from tour where id=?"; 
      pstmt = conn.prepareStatement(sql); pstmt.setInt(1,id); 
      System.out.println(pstmt.toString()); pstmt.executeUpdate();
      
      pstmt.close(); conn.close();
      
     response.sendRedirect("list.jsp");
     

  }

}


