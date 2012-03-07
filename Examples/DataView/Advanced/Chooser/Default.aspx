<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register src="ChooserDialog.ascx" tagname="ChooserDialog" tagprefix="uc1" %>
    

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>Advanced DataView - Ext.NET Example</title>

    <link href="chooser.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />    

    <script type="text/javascript">
        function beforeCreate(){
            var dialog = Ext.getCmp("ImgChooserDlg");
            if(dialog){
                dialog.show();
                return false;
            }

            return true;
        }
    </script>

    <script runat="server">
        protected void CreateChooser(object sender, DirectEventArgs e)
        {
            UserControlRenderer.Render(new UserControlRendrerConfig { UserControlPath = "ChooserDialog.ascx", SingleControl = true });
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Advanced DataView Example</h1>
    	<p>This example shows loading a DataView in a Window.  Each item has a linked details view, and the DataView
        supports custom sorting and filtering.</p>
        
        <ext:Button 
            ID="Button1" 
            runat="server" 
            Icon="Add"
            Text="Insert Image">
            <DirectEvents>
                <Click OnEvent="CreateChooser" Before="return beforeCreate();" />
            </DirectEvents>   
        </ext:Button>
                
        <div id="images" style="margin:20px;width:600px;"></div>
    </form>
</body>
</html>
