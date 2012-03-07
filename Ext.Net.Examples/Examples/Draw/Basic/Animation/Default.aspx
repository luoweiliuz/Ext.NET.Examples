<%@ Page Language="C#" %>
<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Animation with a Draw Component - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script runat="server">
        protected void AnimateRect(object sender, DirectEventArgs e)
        {
            Draw1.GetGroup("rectangles").Animate(new AnimConfig
            {
                Duration = 1000,
                To = 
                { 
                    new Ext.Net.Parameter("translate", "{x:150}", ParameterMode.Raw)
                }
            });
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <h1>Animation with a Draw Component</h1>

        <ext:Button runat="server" Text="Animate circles (client side)">
            <Listeners>
                <Click Handler="#{Draw1}.surface.getGroup('circles').animate({duration:1000, to:{translate:{x:150}}});" />
            </Listeners>
        </ext:Button>

        <ext:Button runat="server" Text="Animate rectangles (server side)" OnDirectClick="AnimateRect" />

        <br />
        
        <ext:DrawComponent ID="Draw1" runat="server"
            Width="800"
            Height="600">
            <Items>
                <ext:Sprite Type="Circle" Radius="10" Fill="#f00" X="10" Y="10" Group="circles" />
                <ext:Sprite Type="Circle" Radius="10" Fill="#0f0" X="50" Y="50" Group="circles" />
                <ext:Sprite Type="Circle" Radius="10" Fill="#00f" X="100" Y="100" Group="circles" />
                <ext:Sprite Type="Rect" Width="20" Height="20" Fill="#f00" X="10" Y="10" Group="rectangles" />
                <ext:Sprite Type="Rect" Width="20" Height="20" Fill="#0f0" X="50" Y="50" Group="rectangles" />
                <ext:Sprite Type="Rect" Width="20" Height="20" Fill="#00f" X="100" Y="100" Group="rectangles" />
            </Items>
        </ext:DrawComponent>        
    </form>    
</body>
</html>
