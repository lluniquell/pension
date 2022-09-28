package dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import dto.TourDto;

public class TourDao_old {

  Connection conn;
  PreparedStatement pstmt;

  public TourDao_old() throws Exception {
    // DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db = "jdbc:mysql://localhost:3306/pension";
    conn = DriverManager.getConnection(db, "root", "root");
  }

  public void write_ok(HttpServletRequest request, HttpSession session,
      HttpServletResponse response) throws Exception {

    // 파일 업로드 객체 생성
    String path = request.getSession().getServletContext().getRealPath("/tour/img");
    int size = 1024 * 1024 * 10;
    MultipartRequest multi =
        new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

    String title = multi.getParameter("title");
    String userid = session.getAttribute("userid").toString();
    String content = multi.getParameter("content");
    String fname = multi.getFilesystemName("fname");

    String sql = "insert into tour(title,userid,content,fname,writeday) ";
    sql = sql + "values(?,?,?,?,now())";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, userid);
    pstmt.setString(3, content);
    pstmt.setString(4, fname);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("list.jsp");
  }

  public void list(HttpServletRequest request) throws Exception {
    String sql = "select * from tour order by id desc";

    pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    ArrayList<TourDto> list = new ArrayList<TourDto>();

    while (rs.next()) {
      TourDto tdto = new TourDto();
      tdto.setId(rs.getInt("id"));
      tdto.setTitle(rs.getString("title"));
      tdto.setUserid(rs.getString("userid"));
      tdto.setReadnum(rs.getInt("readnum"));
      tdto.setWriteday(rs.getString("writeday"));
      tdto.setFname(rs.getString("fname"));

      list.add(tdto);
    }
    request.setAttribute("list", list);
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
    tdto.setFname(rs.getString("fname"));
    tdto.setReadnum(rs.getInt("readnum"));
    tdto.setTitle(rs.getString("title"));
    tdto.setUserid(rs.getString("userid"));
    tdto.setWriteday(rs.getString("writeday"));
    tdto.setId(rs.getInt("id"));

    request.setAttribute("tdto", tdto);
  }

  public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String id = request.getParameter("id");

    String sql = "update tour set readnum=readnum+1 where id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    response.sendRedirect("../tour/content.jsp?id=" + id);
  }

  public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
    String id = request.getParameter("id");

    String sql = "delete from tour where id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    response.sendRedirect("../tour/list.jsp");
  }

  public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {

    String path = request.getSession().getServletContext().getRealPath("/tour/img");
    int size = 1024 * 1024 * 10;
    MultipartRequest multi =
        new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

    String id = multi.getParameter("id");
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    String fname = multi.getFilesystemName("fname");
    String fname2 = multi.getParameter("fname2");

    if (fname == null) {
      String sql = "update tour set title=?,content=? where id=?";

      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, title);
      pstmt.setString(2, content);
      pstmt.setString(3, id);
    } else {

      String sql = "update tour set title=?,content=?,fname=? where id=?";

      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, title);
      pstmt.setString(2, content);
      pstmt.setString(3, fname);
      pstmt.setString(4, id);

      File file = new File(path + "/" + fname2);
      if (file.exists()) {
        file.delete();
      }
    }
    

    pstmt.executeUpdate();
    pstmt.close();
    conn.close();
    //System.out.println(fname2);
    //System.out.println(id);
    response.sendRedirect("../tour/content.jsp?id=" + id);


  }

}
