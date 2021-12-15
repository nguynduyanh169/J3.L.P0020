<%-- 
    Document   : member_home
    Created on : Dec 9, 2021, 8:35:52 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>News Feed Page</title>
        <style>
            .container {
                display: flex;
                justify-content: center;
                flex-direction: column;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <c:set var="articles" value="${sessionScope.ARTICLES}" />
        <c:set var="totalPage" value="${sessionScope.TOTALPAGE}" />
        <form action="logout" method="POST">
            <input type="submit" name="btAction" value="Log out"/>
        </form>
        <br/>
        <div class="container">
            <h1>Hello <c:out value="${sessionScope.ACCOUNT.fullName}"/>!</h1>
            <br/>
            <a href="member_post_article.jsp">Create your post</a>
            <br/>
            <form action="searchArticle" method="GET">
                Content:
                <input type="text" name="txtSearch" value="${param.txtSearch}"/>
                <input type="hidden" name="page" value="1"/>
                <input type="hidden" name="forwardTo" value="member"/>
                <input type="submit" name="btAction" value="Search"/>
            </form>
            
            <br/>
            <c:if test="${not empty articles}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Short description</th>
                            <th>Author</th>
                            <th>Date</th>
                            <th></th>
                        </tr>
                    </thead>
                    <c:forEach var="dto" items="${articles}" varStatus="counter">
                        <tbody>
                            <tr>
                                <td>${dto.title}</td>
                                <td>${dto.shortDescription}</td>
                                <td>${dto.author}</td>
                                <td><fmt:formatDate value="${dto.postingDateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
                                    <c:url var="viewArticleLink" value="getArticle">
                                        <c:param name="articleId" value="${dto.articleId}" />
                                        <c:param name="forwardTo" value="member"/>
                                        <c:param name="btAction" value="View Article" />
                                    </c:url>
                                    <a href="${viewArticleLink}">View Details</a>
                                </td>
                            </tr>
                        </tbody>
                    </c:forEach>
                </table>
                <div>
                    <c:forEach begin="1" end="${totalPage}" var="i">
                        <c:url var="currentPageLink" value="searchArticle">
                            <c:param name="btAction" value="Search" />
                            <c:param name="page" value="${i}"/>
                            <c:param name="txtSearch" value="${param.txtSearch}"/>
                            <c:param name="forwardTo" value="member"/>
                        </c:url>
                        <a id="${i}" style="margin-bottom: 50px" href="${currentPageLink}">${i}</a>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty articles}">
                <h1>No record is matched !!!</h1>
            </c:if>
        </div>
    </body>
</html>
