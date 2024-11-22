<%-- 
    Document   : LoginPage
    Created on : Nov 22, 2024, 12:46:08 PM
    Author     : tomng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="style/LoginStyle.css">
    </head>
    <% if (session.getAttribute("id") != null && session.getAttribute("rememberMe") != null) 
    {
        int accountRole = Integer.parseInt(session.getAttribute("accountRole").toString());
        switch(accountRole){
            case(1):
                response.sendRedirect("AdminPage.jsp");
                return;
            case(2):
                response.sendRedirect("TeacherPage.jsp");
                return;
            case(3):
                response.sendRedirect("StaffPage.jsp");
                return;
            case(4):
                response.sendRedirect("StudentPage.jsp");
                return;
        }
    } %>
    <body class="text-center">
        <form class="form-signin" action="LoginController" method="POST">
            <img class="mb-4" src="https://getbootstrap.com/docs/4.0/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
            <h1 class="h3 mb-3 font-weight-normal">Login Page</h1>
            <!--<label for="inputEmail" class="sr-only">Email address</label>-->
            <input type="email" id="inputEmail" name ="email" class="form-control" placeholder="Email address" required autofocus>
            <!--<label for="inputPassword" class="sr-only">Password</label>-->
            <input type="password" id="inputPassword" name ="password" class="form-control" placeholder="Password" required>
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" name="remember-me" value="remember-me"> Remember me
                </label>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
            <p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p>
        </form>
    </body> 
</html>
