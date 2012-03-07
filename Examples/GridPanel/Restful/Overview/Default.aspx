<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
    
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        ResourceManager.GetInstance(this.Page).RegisterIcon(Icon.Information);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>RESTful Store - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var onWrite = function(store, operation) {
            var record = operation.getRecords()[0],
                name = Ext.String.capitalize(operation.action),
                verb;
                    
                    
            if (name == 'Destroy') {
                record = operation.records[0];
                verb = 'Destroyed';
            } else {
                verb = name + 'd';
            }
            Ext.net.Notification.show({title: name, html : Ext.String.format("{0} user: {1}<br/>{2}", verb, record.getId(), operation.resultSet.message)});                
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>RESTful Store</h1>
        
        <p>(also see <a href="http://mvc.ext.net/restdemo/">http://mvc.ext.net/restdemo/</a>)</p>
       
        <ext:GridPanel 
            ID="UserGrid" 
            runat="server"
            Icon="Table"
            Frame="true"
            Title="Users"
            Height="400"
            Width="500"
            StyleSpec="margin-top: 10px">
            <Store>
                <ext:Store 
                    runat="server" 
                    AutoLoad="true"
                    AutoSync="true">
                    <Proxy>
                        <ext:RestProxy Url="RestfulPersons.ashx/person">
                            <Reader>
                                <ext:JsonReader Root="data" MessageProperty="message" />
                            </Reader>
                            <Writer>
                                <ext:JsonWriter AllowSingle="true" />
                            </Writer>
                        </ext:RestProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="Id" Name="Person">
                            <Fields>
                                <ext:ModelField Name="Id" Type="Int" UseNull="true" />
                                <ext:ModelField Name="Email" />
                                <ext:ModelField Name="First" />
                                <ext:ModelField Name="Last" />
                            </Fields>
                            <Validations>
                                <ext:LengthValidation Field="Email" Min="1" />
                                <ext:LengthValidation Field="First" Min="1" />
                                <ext:LengthValidation Field="Last" Min="1" />                                
                            </Validations>
                        </ext:Model>
                    </Model>
                    <Listeners>
                        <Write Fn="onWrite" />
                    </Listeners>
                </ext:Store>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="ID" Width="40" DataIndex="Id" />
                    <ext:Column runat="server" Text="Email" Flex="1" DataIndex="Email">
                        <Editor>
                            <ext:TextField runat="server" />    
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="First" Width="80" DataIndex="First">
                        <Editor>
                            <ext:TextField runat="server" />    
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Last" Width="80" DataIndex="Last">
                        <Editor>
                            <ext:TextField runat="server" />    
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>           
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Add" Icon="Add">
                            <Listeners>
                                <Click Handler="var grid = #{UserGrid},
                                                    store = grid.getStore();
                                                store.insert(0, new Person());
                                                grid.editingPlugin.startEdit(0, 0);" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnRemoveEmployee" runat="server" Text="Delete" Icon="Exclamation">
                            <Listeners>
                                <Click Handler="var selection = #{UserGrid}.getView().getSelectionModel().getSelection()[0];
                                                if (selection) {
                                                    #{UserGrid}.store.remove(selection);
                                                }" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Plugins>
                <ext:RowEditing runat="server" />                
            </Plugins>
            <Listeners>
                <SelectionChange Handler="#{btnRemoveEmployee}.setDisabled(!selected.length);" />
            </Listeners>
        </ext:GridPanel>
    </form>
</body>
</html>