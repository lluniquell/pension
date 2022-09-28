package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dto.ReserveDto;
import dto.RoomDto;

public class ReserveDao {
  Connection conn;
  PreparedStatement pstmt;

  public ReserveDao() throws Exception {
    // DB ����
    Class.forName("com.mysql.jdbc.Driver");
    String db = "jdbc:mysql://localhost:3306/pension";
    conn = DriverManager.getConnection(db, "root", "root");
  }

  public void getCalendar(HttpServletRequest request, HttpSession session,
      HttpServletResponse response) throws Exception {
   
    
    if (session.getAttribute("userid") == null) {
      response.sendRedirect("../member/login.jsp");
    }

    // 1���� ����, ���ϼ�, ���ָ� ���ؼ� request ������ ����
    int y, m;
    if (request.getParameter("y") == null) {
      LocalDate today = LocalDate.now();// ���� ��¥ ������ �����´�
      y = today.getYear();// �⵵
      m = today.getMonthValue(); // ��

    } else {
      y = Integer.parseInt(request.getParameter("y"));
      m = Integer.parseInt(request.getParameter("m"));
    }


    // �ش���� 1�Ͽ� ���� ��¥ ��ü�� ����
    LocalDate dday = LocalDate.of(y, m, 1); // 1���� dday

    // 1���� ����
    int yoil = dday.getDayOfWeek().getValue(); // ������ �������� 1~7�� �Ͽ��� 7
    if (yoil == 7) {
      yoil = 0;
    }

    // �ش���� ���ϼ�
    int chong = dday.lengthOfMonth(); // ���ϼ�

    // �����ΰ�?
    int ju = (int) Math.ceil((yoil + chong) / 7.0);

    request.setAttribute("yoil", yoil);
    request.setAttribute("chong", chong);
    request.setAttribute("ju", ju);
    request.setAttribute("y", y);
    request.setAttribute("m", m);
  }

  public void getRoom(HttpServletRequest request) throws Exception {

    String sql = "select * from room order by price asc";

    pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    ArrayList<RoomDto> rlist = new ArrayList<RoomDto>();

    while (rs.next()) {
      RoomDto rdto = new RoomDto();
      rdto.setBang(rs.getString("bang"));
      rdto.setContent(rs.getString("content"));
      rdto.setId(rs.getInt("id"));
      rdto.setMax(rs.getInt("max"));
      rdto.setMin(rs.getInt("min"));
      rdto.setPrice(rs.getInt("price"));
      rdto.setState(rs.getInt("state"));

      rlist.add(rdto);
    }
    request.setAttribute("rlist", rlist);
  }

  public void reserve_next(HttpServletRequest request) throws Exception {

    int y = Integer.parseInt(request.getParameter("y"));
    int m = Integer.parseInt(request.getParameter("m"));
    int d = Integer.parseInt(request.getParameter("d"));
    String id = request.getParameter("id");
    // �Խ���
    String ymd = y + "-" + m + "-" + d;
    // ���� ����

    String sql = "select * from room where id=" + id;
    pstmt = conn.prepareStatement(sql);
    // pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery();
    rs.next();

    RoomDto rdto = new RoomDto();
    rdto.setId(rs.getInt("id"));
    rdto.setBang(rs.getString("bang"));
    rdto.setContent(rs.getString("content"));
    rdto.setMin(rs.getInt("min"));
    rdto.setMax(rs.getInt("max"));
    rdto.setPrice(rs.getInt("price"));
    rdto.setState(rs.getInt("state"));

    request.setAttribute("ymd", ymd);
    request.setAttribute("rdto", rdto);
  }

  public void reserve_ok(HttpServletRequest request, HttpSession session,
      HttpServletResponse response) throws Exception {
    String inday = request.getParameter("inday");
    int suk = Integer.parseInt(request.getParameter("suk"));
    String bang_id = request.getParameter("bang_id");
    String total = request.getParameter("total");
    String inwon = request.getParameter("inwon");
    String cpack = request.getParameter("cpack");
    String bbqpack = request.getParameter("bpack");
    String userid = session.getAttribute("userid").toString();

    // inday�� �̿� outday�� ���Ѵ�
    // LocalDate LocalDate.now() // ����ð�
    String[] imsi = inday.split("-");
    int y = Integer.parseInt(imsi[0]);
    int m = Integer.parseInt(imsi[1]);
    int d = Integer.parseInt(imsi[2]);
    LocalDate dday = LocalDate.of(y, m, d); // �Է� �Ǵ� ��, ��, ��
    LocalDate outday = dday.plusDays(suk);

    // ���� ����
    String sql =
        "insert into reserve(inday,outday,userid,bang_id,inwon,cpack,bbqpack,total,writeday) ";
    sql = sql + "values(?,?,?,?,?,?,?,?,now())";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, inday);
    pstmt.setString(2, outday.toString());
    pstmt.setString(3, userid);
    pstmt.setString(4, bang_id);
    pstmt.setString(5, inwon);
    pstmt.setString(6, cpack);
    pstmt.setString(7, bbqpack);
    pstmt.setString(8, total);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("reserve_view.jsp");
  }

  public void reserve_view(HttpSession session, HttpServletRequest request) throws Exception {

    String userid = session.getAttribute("userid").toString();
    // String sql="select * from reserve where userid=? order by id desc limit 1";

    String sql =
        "select r2.*, r1.bang from room as r1, reserve as r2 where r2.userid=? and r1.id=r2.bang_id order by id desc";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userid);

    ResultSet rs = pstmt.executeQuery();
    LocalDate ttoday = LocalDate.now();

    ArrayList<ReserveDto> rlist = new ArrayList<ReserveDto>();
    while (rs.next()) {
      ReserveDto rdto = new ReserveDto();
      rdto.setId(rs.getInt("id"));
      rdto.setInday(rs.getString("inday"));
      rdto.setOutday(rs.getString("outday"));
      rdto.setBang_name(rs.getString("bang"));
      // bang�� ���� �����ϴ� ���
      // 1. dto�� ����
      // 2. �Ѱ��ϱ�.. �׳� ������Ʈ
      // 2 request.setAttribute("bang", rs.getString("bang");
      rdto.setBang_id(rs.getInt("bang_id"));
      rdto.setInwon(rs.getInt("inwon"));
      rdto.setCpack(rs.getInt("cpack"));
      rdto.setBbqpack(rs.getInt("bbqpack"));
      rdto.setTotal(rs.getInt("total"));
      rdto.setWriteday(rs.getString("writeday"));


      String[] imsi = rs.getString("outday").split("-");
      int y = Integer.parseInt(imsi[0]);
      int m = Integer.parseInt(imsi[1]);
      int d = Integer.parseInt(imsi[2]);
      LocalDate ooutday = LocalDate.of(y, m, d); // �Է� �Ǵ� ��, ��, ��

      if (ttoday.isAfter(ooutday)) {
        sql = "update reserve set state=3 where id=?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, rs.getInt("id"));

        pstmt.executeUpdate();
      }
      rdto.setState(rs.getInt("state"));


      rlist.add(rdto);
    }
    request.setAttribute("rlist", rlist);
    request.setAttribute("ttoday", ttoday);
  }

  public void getEmpty(String dday, String bang_id, HttpServletRequest request) throws Exception {
    // ����ϰ� bang_id�� �̿��ؼ� ���డ�� ���θ� üũ
    String sql = "select count(*) as cnt from reserve ";
    sql = sql + "where inday <= ? and ? < outday and bang_id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, dday);
    pstmt.setString(2, dday);
    pstmt.setString(3, bang_id);

    ResultSet rs = pstmt.executeQuery();
    rs.next();

    request.setAttribute("cnt", rs.getString("cnt"));
  }

  public void getcheck(String y, String m, String d, HttpServletRequest request) {
    int yy = Integer.parseInt(y);
    int mm = Integer.parseInt(m);
    int dd = Integer.parseInt(d);

    LocalDate today = LocalDate.now();
    LocalDate dday = LocalDate.of(yy, mm, dd);

    if (today.isBefore(dday)) {
      request.setAttribute("tt", "1");
    } else if (today.equals(dday)) {
      request.setAttribute("tt", "1");
    } else {
      request.setAttribute("tt", "0");
    }

  }

  public void getSuk(HttpServletRequest request) throws Exception {
    String ymd = request.getAttribute("ymd").toString();
    RoomDto rdto = (RoomDto) request.getAttribute("rdto");
    // System.out.println(ymd);
    // System.out.println(rdto.getId());

    // ymd�� localdate�� ����
    String[] imsi = ymd.split("-");
    int y = Integer.parseInt(imsi[0]);
    int m = Integer.parseInt(imsi[1]);
    int d = Integer.parseInt(imsi[2]);
    LocalDate dday = LocalDate.of(y, m, d);
    int chk = 0;
    for (int i = 1; i <= 5; i++) {
      chk++;
      LocalDate xday = dday.plusDays(i);

      String sql = "select * from reserve where inday<=? and ?<outday and bang_id=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, xday.toString());
      pstmt.setString(2, xday.toString());
      pstmt.setInt(3, rdto.getId());

      ResultSet rs = pstmt.executeQuery();

      if (rs.next()) {
        break;
      }

    }
    request.setAttribute("chk", chk);

  }

  public void state_change(HttpServletRequest request, HttpServletResponse response)
      throws Exception {
    String id = request.getParameter("id");
    String state = request.getParameter("state");

    String sql = "update reserve set state=? where id=?";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, state);
    pstmt.setString(2, id);

    pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    response.sendRedirect("reserve_view_all.jsp");
  }

}
