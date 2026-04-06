<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Current session lo unna data ni clear chesthunnam
    session.removeAttribute("user_id");
    session.removeAttribute("username");
    
    // 2. Session ni purthiga end (kill) chesthunnam
    session.invalidate(); 
    
    // 3. Logout ayyaka ventane login page ki pampisthunnam
    response.sendRedirect("login.jsp"); 
%>
