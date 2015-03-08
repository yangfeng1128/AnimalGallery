<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="header.jsp">
<c:param name="title" value="Animal Gallery - View Image"></c:param>
</c:import>
<center>
	<sql:transaction dataSource="jdbc/spring">
	<sql:query sql="select * from images where id=?" var="results">
	<sql:param>${param.image}</sql:param>
	</sql:query>
	
	<c:set scope="page" var="image" value="${results.rows[0]}"></c:set>
	<c:set scope="page" var="average_ranking" value="${image.average_ranking}"/>
	<c:if test="${param.action=='rate'}">
		<c:set scope="page" var="newRating" value="${(image.average_ranking*image.ranking+param.rating)/(image.ranking+1)}"/>
		<c:set scope="page" var="average_ranking" value="${newRating}" />
		<sql:update sql="update images set average_ranking=? where id=?">
			<sql:param>${newRating}</sql:param>
			<sql:param>${param.image}</sql:param>
		</sql:update>
		<sql:update sql="update images set ranking=? where id=?">
			<sql:param>${image.rating+1}</sql:param>
			<sql:param>${param.image}</sql:param>
		</sql:update>
	</c:if>
	</sql:transaction>
	
    <H2><c:out value="${image.stem}"/></H2>
    <span class="rating">Rated:<fmt:formatNumber value="${average_ranking}" maxFractionDigits="1"/></span> 
     <table class="image">
     <tr>
     <td><br style="margin-bottom:1px;"><span></span>
     <img src="<c:url value='/pics/bear.jpg' />"/>
     </td>
     <td>
     <form action='<c:url value="/" />' method="post">
     	<input type="hidden" name="action" value="rate" />
     	<input type="hidden" name="image" value="${image.id}" />
     	<table class="rating">
     	<tr>
     		<td><h3>How much do you like this animal?</h3></td>
     	</tr>
     	<tr>
     		<td><input type="radio" name="rating" value="5"/>5. Quite a lot</td>
     	</tr>	
     	<tr>
     		<td><input type="radio" name="rating" value="4"/>4. Like it</td>
     	</tr>
     	<tr>
     		<td><input type="radio" name="rating" value="3"/>3. Indifferent</td>
     	</tr>
     	<tr>
     		<td><input type="radio" name="rating" value="2"/>2. Dislike</td>
     	</tr>
     	<tr>
     		<td><input type="radio" name="rating" value="1"/>1. I hate it!</td>
     	</tr>
     	<tr>
     		<td><input type="submit" name="submit" value="submit" />
     	</tr>
     	</table>
     </form>
     </td>
     </tr>
     </table>
     
</center>
<c:import url="footer.jsp"></c:import>
