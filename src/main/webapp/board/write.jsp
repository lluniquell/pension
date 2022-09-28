<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<style>
   #section {
     width:1100px;
     height:500px;
    margin:auto;
  }
</style>
<c:import url="../top.jsp"/>
  <div id="section" align="center">
   <form method="post" action="write_ok.jsp">
    <table style="width:500px;" >
      <caption> 게시판 글쓰기 </caption>
      <tr>
        <td> 제 목 </td>
        <td> <input type="text" name="title" style="width :313px"> </td>
      </tr>
      
      <!-- 유저아이디는 게스트나 userid 게스트만 필요 -->
      <c:if test="${(userid == null)}">
      <tr>
        <td> 비밀번호 </td>
        <td> <input type="password" name="pwd" style="width :313px"> </td>
      </tr> 
      </c:if>
      <tr>
        <td> 내 용 </td>
        <td> <textarea cols="40" rows="6" name="content"></textarea></td>
      </tr>
      <tr align="center">
        <td colspan="2"> <input type="submit" value="글쓰기"> </td>
      </tr>
    </table>
   </form>
  </div>
<c:import url="../bottom.jsp"/>









