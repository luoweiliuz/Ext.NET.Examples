<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        StreamReader streamReader = File.OpenText(MapPath("~/README.txt"));
        this.pre1.InnerText = streamReader.ReadToEnd();
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>README.txt - Ext.NET Examples</title>
    <link href="/resources/css/examples.css"  rel="stylesheet" type="text/css" />
</head>
<body>
    <pre runat="server" id="pre1">
    </pre>
</body>
</html>