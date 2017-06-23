<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="${pageContext.request.contextPath }/jsp/main.jsp">
				Ican Project Management
			</a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li>
				<a href="#">
					<span class="glyphicon glyphicon-envelope"></span>
					<span class="badge">${isReadCount }</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath }/jsp/mypage/profile.jsp">
					<span class="glyphicon glyphicon-user"></span>
					<c:if test="${not empty sessionScope.loginUser}">
						${sessionScope.loginUser.id}(${sessionScope.loginUser.name })
					</c:if>
				</a>
			</li>
		</ul>
	</div>
</nav>