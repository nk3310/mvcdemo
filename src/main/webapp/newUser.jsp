<%@ page pageEncoding="UTF-8"%>
<head>
<title>
user
</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta   http-equiv="pragma"   content="no-cache">

</head>
<body>
<h3>DEMO</h3>
<p>
<div>
    <form action="testusers" method="post">
        <table width="500" border="1">
            <tr>
                <td align="right">name</td>
                <td>
                    <input name="user.name" type="text" value="${user.name}">
                    
                </td>
            </tr>
            <tr>
                <td align="right">email</td>
                <td>
                    <input name="user.email" type="text" value="${user.email}">
                
                </td>
            </tr>
            <tr>
                <td><input type="submit" value="submit"/></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
