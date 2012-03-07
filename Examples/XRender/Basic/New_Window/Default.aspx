<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        var win = new Window 
        {
            ID = "Window1",
            Title = "Example",
            Height = 185,
            Width = 350,
            BodyPadding = 5,
            Modal = true,
            CloseAction = CloseAction.Destroy,
            Html = "A new Window  was created at: " + DateTime.Now.ToLongTimeString()
        };

        win.Render(this.Form);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Dynamically create a new Window during a DirectEvent - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Dynamically create a new Window during a DirectEvent</h1>
        
        <ext:Button 
            ID="Button1" 
            runat="server" 
            Text="Add Window" 
            Icon="Add" 
            OnDirectClick="Button1_Click" 
            />
    </form>
</body>
</html>