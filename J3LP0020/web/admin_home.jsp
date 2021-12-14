<%-- 
    Document   : admin_home
    Created on : Dec 9, 2021, 8:36:01 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Articles Page</title>
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
        <c:set var="selectedStatus" value="${sessionScope.SELECTEDSTATUS}" />
        <form action="logout" method="POST">
            <input type="submit" name="btAction" value="Log out"/>
        </form>
        <br/>
        <div class="container">
            <h1>Hello <c:out value="${sessionScope.ACCOUNT.fullName}"/>!</h1>
            <br/>
            <form action="searchArticle" method="GET">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>Article Name: </td>
                            <td><input type="text" name="txtSearchTitle" value="${param.txtSearchTitle}"/></td>
                        </tr>
                        <tr>
                            <td>Content: </td>
                            <td><input type="text" name="txtSearch" value="${param.txtSearch}"/></td>
                        </tr>
                        <tr>
                            <td>Status: </td>
                            <td>
                                <select name="articleStatus">
                                    <c:if test="${selectedStatus eq 0}">
                                        <option value="0" selected="true">
                                            New
                                        </option>
                                    </c:if>
                                    <c:if test="${selectedStatus eq 0 == false}">
                                        <option value="0">
                                            New
                                        </option>
                                    </c:if>
                                    <c:if test="${selectedStatus eq 1}">
                                        <option value="1" selected="true">
                                            Approved
                                        </option>
                                    </c:if>
                                    <c:if test="${selectedStatus eq 1 == false}">
                                        <option value="1">
                                            Approved
                                        </option>
                                    </c:if>
                                    <c:if test="${selectedStatus eq -1}">
                                        <option value="-1" selected="true">
                                            Disapproved
                                        </option>
                                    </c:if>
                                    <c:if test="${selectedStatus eq -1 == false}">
                                        <option value="-1">
                                            Disapproved
                                        </option>
                                    </c:if>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden" name="page" value="1"/>
                                <input type="hidden" name="forwardTo" value="admin"/>
                                <input type="submit" name="btAction" value="Search"/>
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <br/>
            <c:if test="${not empty articles}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Short description</th>
                            <th>Author</th>
                            <th>Author Name</th>
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
                                <td>${dto.authorName}</td>
                                <td><fmt:formatDate value="${dto.postingDateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
                                    <c:url var="viewArticleLink" value="getArticle">
                                        <c:param name="articleId" value="${dto.articleId}" />
                                        <c:param name="forwardTo" value="admin"/>
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
                            <c:param name="txtSearchTitle" value="${param.txtSearchTitle}"/>
                            <c:param name="articleStatus" value="${param.articleStatus}"/>
                            <c:param name="forwardTo" value="admin"/>
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
