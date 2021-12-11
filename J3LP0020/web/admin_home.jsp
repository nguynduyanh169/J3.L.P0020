<%-- 
    Document   : admin_home
    Created on : Dec 9, 2021, 8:36:01 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <div class="container">
            <h1>Hello <c:out value="${sessionScope.ACCOUNT.fullName}"/>!</h1>
            <br/>
            <form action="searchArticle" method="GET">
                <input type="text" name="txtSearch" value="${param.txtSearch}"/>
                <input type="hidden" name="page" value="1"/>
                <input type="hidden" name="forwardTo" value="admin"/>
                <input type="submit" name="btAction" value="Search"/>
            </form>
                <table border="1">
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>

            <br/>
            <c:if test="${not empty articles}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Short description</th>
                            <th>Author</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <c:forEach var="dto" items="${articles}" varStatus="counter">
                        <tbody>
                            <tr>
                                <td>${dto.title}</td>
                                <td>${dto.shortDescription}</td>
                                <td>${dto.author}</td>
                                <td>${dto.postingDate}</td>
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
