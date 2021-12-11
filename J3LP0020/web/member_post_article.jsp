<%-- 
    Document   : member_post_article
    Created on : Dec 11, 2021, 10:31:43 AM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Your Article Page</title>
    </head>
    <body>
        <c:set var="error" value="${requestScope.ERROR}" />
        <h1>Post Your Article</h1>
        <c:if test="${empty error}">
            <form action="postArticle" method="POST">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>Title: </td>
                            <td><input type="text" name="txtTitle" value="${param.txtTitle}"/></td>
                        </tr>
                        <tr>
                            <td>Short Description</td>
                            <td><input type="text" name="txtShortDesc" value="${param.txtShortDesc}"/></td>
                        </tr>
                        <tr>
                            <td>Content</td>
                            <td> <textarea name="txtContent" rows="4" cols="50">${param.txtContent}</textarea> </td>
                        </tr>
                        <tr>
                            <td><input type="submit" name="btAction" value="Post"/></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </c:if>
        <c:if test="${not empty error}">
            <form action="postArticle" method="POST">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>Title: </td>
                            <td><input type="text" name="txtTitle" value="${param.txtTitle}"/></td>
                                <c:if test="${not empty error.title}">
                                <td><font color="red">
                                    ${error.title}
                                    </font>
                                </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td>Short Description</td>
                            <td><input type="text" name="txtShortDesc" value="${param.txtShortDesc}"/></td>
                                <c:if test="${not empty error.shortDesc}">
                                <td><font color="red">
                                    ${error.shortDesc}
                                    </font>
                                </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td>Content</td>
                            <td> <textarea name="txtContent" rows="4" cols="50">${param.txtContent}</textarea> </td>
                            <c:if test="${not empty error.content}">
                                <td><font color="red">
                                    ${error.content}
                                    </font>
                                </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td><input type="submit" name="btAction" value="Post"/></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </c:if>
    </body>
</html>
