<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Sidebar -->
<div class="w3-sidebar w3-light-grey w3-bar-block">
	<a href="${pageContext.request.contextPath }/main.do" 
	data-toggle="tooltip" data-placement="left" title="Home">
		<span class="glyphicon glyphicon-home"></span>
	</a>
	<a href="${pageContext.request.contextPath }/member/list.do?page=1&perPageNum=10" 
	data-toggle="tooltip" data-placement="left" title="Member">
		<span class="glyphicon glyphicon-user"></span>
	</a>
	<a href="${pageContext.request.contextPath }/project/list.do?page=1&perPageNum=10&loc=project" 
	data-toggle="tooltip" data-placement="left" title="Project">
		<span class="glyphicon glyphicon-folder-open"></span>
	</a>
	<a href="${pageContext.request.contextPath }/projectwork/list.do?page=1&perPageNum=10&loc=projectwork" 
	data-toggle="tooltip" data-placement="left" title="Project Working">
		<span class="glyphicon glyphicon-random"></span>
	</a>
	<a href="${pageContext.request.contextPath }/bbs/list.do?page=1&perPageNum=10" 
	data-toggle="tooltip" data-placement="left" title="Notice">
		<span class="glyphicon glyphicon-list"></span>
	</a>
</div>