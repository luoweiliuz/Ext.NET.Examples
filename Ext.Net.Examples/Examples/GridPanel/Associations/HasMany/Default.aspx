<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HasMany Association - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />    
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <h1>HasMany Association</h1>
    
    <ext:GridPanel 
        ID="GridPanel1"
        runat="server" 
        Title="Array Grid" 
        Width="600" 
        Height="350">
        <Store>
            <ext:Store ID="Store1" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="company" />
                            <ext:ModelField Name="price" Type="Float" />
                            <ext:ModelField Name="change" Type="Float" />
                            <ext:ModelField Name="pctChange" Type="Float" />
                            <ext:ModelField Name="lastChange" Type="Date" DateFormat="M/d hh:mmtt" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel>
            <Columns>
                <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                <ext:Column runat="server" Text="Price" DataIndex="price">                  
                    <Renderer Format="UsMoney" />
                </ext:Column>
                <ext:Column runat="server" Text="Change" DataIndex="change">
                    <Renderer Fn="change" />
                </ext:Column>
                <ext:Column runat="server" Text="Change" DataIndex="pctChange">
                    <Renderer Fn="pctChange" />
                </ext:Column>
                <ext:DateColumn runat="server" Text="Last Updated" DataIndex="lastChange" />
            </Columns>            
        </ColumnModel>       
        <SelectionModel>
            <ext:RowSelectionModel runat="server" />
        </SelectionModel>
    </ext:GridPanel>
</body>
</html>