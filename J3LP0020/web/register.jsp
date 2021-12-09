<%-- 
    Document   : register
    Created on : Dec 9, 2021, 8:06:40 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <c:set var="validate" value="${requestScope.VALIDATE}"/>
        <c:set var="error" value="${requestScope.ERROR}"/>
        <h1>Enter your account!</h1>
        <br/>
        <a href="login.jsp">go to login</a>
        <br/>
        <c:if test="${not empty error}">
            <p><font color="red">
                ${error}
                </font></p>
            </c:if>
            <c:if test="${empty validate}">
            <form action="register" method="POST">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>Email </td>
                            <td><input type="text" name="txtEmail" value="${param.txtEmail}"/></td>
                        </tr>
                        <tr>
                            <td>Password </td>
                            <td><input type="password" name="txtPassword" value="${param.txtPassword}"/></td>
                        </tr>
                        <tr>
                            <td>Full Name </td>
                            <td><input type="text" name="txtFullname" value="${param.txtFullname}"/></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" name="btAction" value="Register"/></td>
                        </tr>

                    </tbody>
                </table>

            </form>
        </c:if>
        <c:if test="${not empty validate}">
            <form action="register" method="POST">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>Email </td>
                            <td><input type="text" name="txtEmail" value="${param.txtEmail}"/></td>
                                <c:if test="${not empty validate.emailError}">
                                <td><font color="red">
                                    ${validate.emailError}
                                    </font>
                                </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td>Password </td>
                            <td><input type="password" name="txtPassword" value="${param.txtPassword}"/></td>
                                <c:if test="${not empty validate.passwordError}">
                                <td><font color="red">
                                    ${validate.passwordError}
                                    </font>
                                </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td>Full Name </td>
                            <td><input type="text" name="txtFullname" value="${param.txtFullname}"/></td>
                                <c:if test="${not empty validate.fullNameError}">
                                <td><font color="red">
                                    ${validate.fullNameError}
                                    </font>
                                </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" name="btAction" value="Register"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </c:if>

    </body>
</html>
