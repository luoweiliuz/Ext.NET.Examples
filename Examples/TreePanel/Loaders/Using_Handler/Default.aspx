<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel with Async TreeLoader using HttpHandler - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>TreePanel with Async TreeLoader using HttpHandler</h1> 
        
        <ext:TreePanel 
            ID="TreePanel1" 
            runat="server" 
            Title="Tree" 
            Height="500"
            Width="200"
            Border="false">
            <Store>
                <ext:TreeStore runat="server">
                    <Proxy>
                        <ext:AjaxProxy Url="TreeLoader.ashx" />
                    </Proxy>
                </ext:TreeStore>
            </Store>
            <Root>
                <ext:Node NodeID="0" Text="Root" />
            </Root>
        </ext:TreePanel>
    </form>
</body>
</html>