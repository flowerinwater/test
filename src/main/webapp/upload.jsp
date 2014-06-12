<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="/test/sendblog" method="post" enctype="multipart/form-data">
        <input type="file" name="img"/>
        <input type="file" name="video"/>
        <input type="text" value="1" name="attachmentType"/>
        <input type="submit" value="submit" />
        </form>
    </body>
</html>
