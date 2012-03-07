<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples"%>
<%@ Import Namespace="Ext.Net.Examples.Northwind" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void RowSelect(object sender, DirectEventArgs e)
    {
       
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with Form Details - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
            
        <h1>Data Binding Example</h1>
        <p>This example shows how to implement data binding for a master-detail view.</p>       

        <ext:XTemplate ID="BookTpl" runat="server">
            <Html>
                Title: <a href="{DetailPageURL}" target="_blank">{Title}</a><br/>
                Author: {Author}<br/>
                Manufacturer: {Manufacturer}<br/>
                Product Group: {ProductGroup}<br/>
            </Html>
        </ext:XTemplate>
        
        <ext:Panel runat="server"
            Frame="true"
            Title="Book List"
            Width="540"
            Height="400"
            Layout="BorderLayout">
            <Items>
                <ext:GridPanel runat="server"
                   Region="North"
                   Split="true"
                   Height="210">
                   <Store>
                       <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server" Name="Book">
                                    <Fields>
                                        <ext:ModelField Name="Author" />
                                        <ext:ModelField Name="Title" />
                                        <ext:ModelField Name="Manufacturer" />
                                        <ext:ModelField Name="ProductGroup" />
                                        <ext:ModelField Name="DetailPageURL" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Proxy>
                                <ext:AjaxProxy Url="sheldon.xml">
                                    <Reader>
                                        <ext:XmlReader Record="Item">
                                        </ext:XmlReader>
                                    </Reader>
                                </ext:AjaxProxy>
                            </Proxy>
                       </ext:Store>
                   </Store>                   
                   <ColumnModel>
                       <Columns>
                            <ext:Column runat="server" Text="Author" Width="120" DataIndex="Author" Sortable="true" />
                            <ext:Column runat="server" Text="Title" Flex="1" DataIndex="Title" Sortable="true" />
                            <ext:Column runat="server" Text="Manufacturer" Width="115" DataIndex="Manufacturer" Sortable="true" />
                            <ext:Column runat="server" Text="Product Group" Width="100" DataIndex="ProductGroup" Sortable="true" />
                       </Columns>
                   </ColumnModel>
                   <Listeners>
                       <SelectionChange Handler="selected.length && #{BookTpl}.overwrite(#{DetailPanel}.body, selected[0].data);" />
                   </Listeners>
                </ext:GridPanel>

                <ext:Panel ID="DetailPanel" runat="server"
                    Region="Center"
                    BodyPadding="7"
                    BodyStyle="background: #ffffff;"
                    Html="Please select a book to see additional details.">                
                </ext:Panel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
