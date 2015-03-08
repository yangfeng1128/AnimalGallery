<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<c:import url="header.jsp">
	<c:param name="title" value="Animal Gallery"></c:param>
</c:import>
<center>
	<sql:setDataSource var="ds" dataSource="jdbc/spring" />
	<sql:query dataSource="${ds}" sql="select * from images" var="results" />
	<table class="image">
		<c:set var="tablewidth" value="4" />
		<c:forEach var="image" items="${results.rows}" varStatus="row">
			<c:if test="${row.index % tablewidth ==0}">
				<tr>
			</c:if>
			<c:set scope="page" var="imgname"
				value="${image.stem}.${image.extension}"></c:set>
			<td><a href="<c:url value='/?action=image&image=${image.id}'/>">
					<img width="80px" src="<c:url value='/pics/${imgname}' />" />
			</a></td>
			<c:if test="${(row.index+1)% tablewidth==0}">
				</tr>
			</c:if>
		</c:forEach>
	</table>
</center>
<c:import url="footer.jsp"></c:import>