<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Sidebar -->
<div class="w3-sidebar w3-light-grey w3-bar-block">
	<a href="${pageContext.request.contextPath }/index.do" 
	data-toggle="tooltip" data-placement="left" title="Home">
		<span class="glyphicon glyphicon-home"></span>
	</a>
	<a href="${pageContext.request.contextPath }/employee/list.do?page=1&perPageNum=10" 
	data-toggle="tooltip" data-placement="left" title="Member">
		<span class="glyphicon glyphicon-user"></span>
	</a>
	<a href="${pageContext.request.contextPath }/project/list.do?page=1&perPageNum=10&loc=project" 
	data-toggle="tooltip" data-placement="left" title="Project">
		<span class="glyphicon glyphicon-folder-open"></span>
	</a>
	<a href="${pageContext.request.contextPath }/projectjoin/list.do?page=1&perPageNum=10&loc=projectjoin" 
	data-toggle="tooltip" data-placement="left" title="Project Working">
		<span class="glyphicon glyphicon-random"></span>
	</a>
</div>