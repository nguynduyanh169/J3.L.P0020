<%-- 
    Document   : guest_view_article
    Created on : Dec 10, 2021, 9:19:37 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Article Page</title>
    </head>
    <body>
        <c:set var="article" value="${sessionScope.SELECTEDARTICLE}" />
        <c:set var="comments" value="${sessionScope.COMMENTS}" />
        <h1><c:out value="${article.title}"/>!</h1>
        <table border="0">
            <tbody>
                <tr>
                    <td>Short Description: </td>
                    <td>${article.shortDescription}</td>
                </tr>
                <tr>
                    <td>Content: </td>
                    <td>${article.articleContent}</td>
                </tr>
                <tr>
                    <td>Post Date: </td>
                    <td><fmt:formatDate value="${article.postingDateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                </tr>
                <tr>
                    <td>Author: </td>
                    <td>${article.author}</td>
                </tr>
            </tbody>
        </table>
        <br/>
        <c:if test="${not empty comments}">
            <table border="0">
                <thead>
                    <tr>
                        <th>Comments: </th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${comments}" varStatus="counter">
                        <tr>
                            <td>${dto.commentBy}: </td>
                            <td>${dto.commentContent}</td>
                            <td>${dto.commentDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty comments}">
            <p>No comments here!</p>
        </c:if>

    </body>
</html>
