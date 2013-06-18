<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extjs/ext-all.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/extjs/ext-all.js"></script>
</head>
<body>
<script type="text/javascript">
    Ext.onReady(function () {
        Ext.MessageBox.alert('Status', 'Changes saved successfully.');
    })
</script>

</body>
</html>
