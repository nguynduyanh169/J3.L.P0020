<%-- 
    Document   : admin_view_post
    Created on : Dec 11, 2021, 8:10:38 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Article Page</title>
    </head>
    <body>
        <c:set var="article" value="${sessionScope.SELECTEDARTICLE}" />
        <c:set var="comments" value="${sessionScope.COMMENTS}" />
        <c:url var="backToHomeLink" value="backToHome">
            <c:param name="btAction" value="Admin Back To Home" />
        </c:url>
        <a href="${backToHomeLink}">Back To Home</a>
        <br/>
        <h1><c:out value="${article.title}"/>!</h1>
        <form action="updateArticleStatus" method="POST">
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
                    <tr>
                        <td>Author Name: </td>
                        <td>${article.authorName}</td>
                    </tr>
                    <tr>
                        <td>Status </td>
                        <td><c:if test="${article.status eq 0}">
                                New
                            </c:if>
                            <c:if test="${article.status eq 1}">
                                Approved
                            </c:if>
                            <c:if test="${article.status eq -1}">
                                Disapproved
                            </c:if>
                        </td>
                    </tr>
                    <c:if test="${article.status eq 0}">
                        <tr>
                            <td><input name="rbStatus" type="radio" value="approve"/> Approve</td>
                            <td><input name="rbStatus" type="radio" value="disapprove"/> Disapprove</td>
                        </tr>
                    </c:if>
                    <c:if test="${article.status eq 1}">
                        <tr>
                            <td><input name="rbStatus" type="radio" value="approve" checked="true"/> Approve</td>
                            <td><input name="rbStatus" type="radio" value="disapprove"/> Disapprove</td>
                        </tr>
                    </c:if>
                    <c:if test="${article.status eq -1}">
                        <tr>
                            <td><input name="rbStatus" type="radio" value="approve"/> Approve</td>
                            <td><input name="rbStatus" type="radio" value="disapprove" checked="true"/> Disapprove</td>
                        </tr>
                    </c:if>
                    <tr>
                        <td></td>
                        <td><input type="hidden" name="articleId" value="${article.articleId}"/>
                            <input type="submit" name="btAction" value="Update Status"/>
                        </td>
                    </tr>

                </tbody>
            </table>
        </form>
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

    </body>
</html>
