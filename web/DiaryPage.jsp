<%-- 
    Document   : DiaryPage
    Created on : Nov 22, 2024, 1:25:08 PM
    Author     : tomng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Diary Page</title>
    </head>
    <body>
        <h1>This is Diary Page!</h1>
        <form action="UploadController" method="POST" enctype="multipart/form-data">
            <input name="file" type="file" >
            <br>
            <br>
            <button type="submit">Submit</button>
        </form>
    </body>
</html>
