<%-- 
    Document   : confirm_email
    Created on : Dec 10, 2021, 7:16:47 AM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Account Page</title>
    </head>
    <body>
        <c:set var="email" value="${requestScope.CONFIRMEMAIL}"/>
        <c:set var="error" value="${requestScope.ERROR}"/>
        <c:set var="code" value="${requestScope.CODE}"/>
        <h1>Enter code to confirm account ${email}</h1>
        <form action="register" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Code</td>
                        <td><input type="text" name="txtConfirmCode" value="${param.txtConfirmCode}"/> <input type="hidden" value="${email}" name="email"/><input type="hidden" name="code" value="${code}"</td>
                            <c:if test="${not empty error}">
                            <td><font color="red">
                                ${error}
                                </font>
                            </td>
                        </c:if>
                    </tr>
                    <tr>
                        <td><input type="submit" name="btAction" value="Confirm"/></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

        </form>
    </body>
</html>
