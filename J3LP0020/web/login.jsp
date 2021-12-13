<%-- 
    Document   : login
    Created on : Dec 9, 2021, 8:05:31 PM
    Author     : anhnd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <a href="guest_home.jsp">Back to home</a>
        <br/>
        <h1 style=" display: flex;justify-content: center;margin-bottom: 50px">Login To Simple Blog</h1><br><br>        
        <form action="login" method="POST">
            <table style=" display: flex;justify-content: center;margin-bottom: 50px" border="0">
                <tbody>
                    <tr>
                        <td>Email: </td>
                        <td><input type="text" name="txtEmail" value=""/></td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td><input type="password" name="txtPassword" value=""/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td> <input type="submit" name="btAction" value="Login"/> <input type="reset" value="Reset"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><a href="register.jsp">Go to register page</a></td>
                    </tr>
                </tbody>
            </table>
            </br>
            
        </form>
    </body>
</html>
