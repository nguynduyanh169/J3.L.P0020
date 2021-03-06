<%-- 
    Document   : member_view_article
    Created on : Dec 11, 2021, 8:57:12 AM
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
        <c:set var="errorMsg" value="${requestScope.ERROR}" />
        <c:url var="backToHomeLink" value="backToHome">
            <c:param name="btAction" value="Member Back To Home" />
        </c:url>
        <a href="${backToHomeLink}">Back To Home</a>
        <br/>
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
                            <td>(<fmt:formatDate value="${dto.commentDateTime}" pattern="yyyy-MM-dd HH:mm" />)</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty comments}">
            <p>No comments here!</p>
        </c:if>
        <br/>
        <table border="0">
            <tbody>
            <form action="saveComment" method="POST">
                <tr>
                    <td><input type="text" name="txtComment" value="${param.txtComment}"</td>
                    <td><input type="submit" name="btAction" value="Comment"/></td>
                </tr>
                <tr>
                    <c:if test="${not empty errorMsg}">
                        <td><font color="red">
                            ${errorMsg}
                            </font>
                        </td>
                    </c:if>
                </tr>

            </form>

        </tbody>
    </table>

</body>
</html>
