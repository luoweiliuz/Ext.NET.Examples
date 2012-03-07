<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Image on Collapsed BorderLayout Region - Ext.NET Examples</title>
    
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        .west-panel .x-layout-collapsed-west {
            background : url(collapsed-west.png) no-repeat center;
        }
        
        .south-panel .x-layout-collapsed-south {
            background : url(collapsed-south.png) no-repeat center;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Image on Collapsed BorderLayout Region</h1>
    
    <ext:Window 
        runat="server" 
        Title="Collapsed Region Image" 
        Icon="Application"
        Width="600" 
        Height="350"
        Border="false"
        Closable="false"
        X="100"
        Y="100"
        Plain="true"
        Layout="BorderLayout">
        <Items>
            <ext:Panel 
                runat="server"
                Region="West"
                Collapsible="true" 
                MinWidth="175" 
                Split="true"                             
                Width="175" 
                CtCls="west-panel"
                Title="Navigation" 
                Collapsed="true"
                BodyPadding="5"
                Html="Collapse Panel to see image."
                />
            <ext:Panel runat="server" Region="Center" Title="Center region" />
            <ext:Panel 
                runat="server"
                Region="South"
                Collapsible="true" 
                MinHeight="100" 
                Split="true"                            
                Height="100" 
                CtCls="south-panel"
                Title="Footer"
                Collapsed="true"
                />
        </Items>
    </ext:Window>
</body>
</html>