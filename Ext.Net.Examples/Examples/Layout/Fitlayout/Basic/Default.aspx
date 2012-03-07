<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Fit Layout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
    
        <ext:Viewport runat="server" Layout="Fit">
            <Items>
                <ext:Panel 
                    runat="server" 
                    BodyPadding="15" 
                    Title="Inner panel"
                    Html="This panel is fit 100% Height and 100% Width within its container."
                    />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
