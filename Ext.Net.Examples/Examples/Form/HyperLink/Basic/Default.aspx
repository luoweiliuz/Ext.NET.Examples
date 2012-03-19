<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>
    
<!DOCTYPE html>

<html>
<head runat="server">
    <title>HyperLink Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <ext:ResourceManager runat="server" />
   
    <h1>HyperLink Variations</h1>
    
    <h2>Simple HyperLink</h2>
    
    <ext:HyperLink 
        runat="server" 
        NavigateUrl="http://www.ext.net" 
        Text="http://www.ext.net" 
        Target="_blank" />
    
    <h2>HyperLink with Icon</h2>
    
    <ext:HyperLink 
        runat="server" 
        Icon="Application" 
        Target="_blank"
        NavigateUrl="http://www.ext.net" 
        Text="http://www.ext.net" 
        />
    
    <h2>HyperLink with Right Aligned Icon</h2>
    
    <ext:HyperLink 
        runat="server" 
        Icon="Application" 
        IconAlign="Right" 
        Target="_blank"
        NavigateUrl="http://www.ext.net" 
        Text="http://www.ext.net" 
        />
    
    <h2>Image HyperLink</h2>
    
    <ext:HyperLink 
        runat="server" 
        Target="_blank"
        NavigateUrl="http://www.ext.net" 
        ImageUrl="http://speed.ext.net/identity/extnet-poweredby-small.png" 
        />
</body>
</html>
