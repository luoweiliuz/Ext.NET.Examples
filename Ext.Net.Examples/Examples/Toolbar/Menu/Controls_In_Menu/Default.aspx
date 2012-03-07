<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
     {
        string[][] data = new string[10][];
        
        for (int i = 0; i < data.Length; i++)
        {
            data[i] = new string[5];
        
            for (int j = 0; j < data[i].Length; j++)
            {
                data[i][j] = string.Format("[{0},{1}]", i+1, j+1);
            }
        }
        
        this.Store1.DataSource = data;
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var cellSelect = function (grid, record, ceIlndex, textField, ctxMenu) {
            var name = grid.columns[ceIlndex].dataIndex,
                value = record.get(name);

            textField.setValue(value);
            ctxMenu.hide();
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <ext:Menu ID="ContextMenu" runat="server">
        <Items>
            <ext:GridPanel 
                ID="GridPanel1" 
                runat="server" 
                EnableHdMenu="false"
                Border="false"
                Width="420"
                Height="245">
                <Store>
                    <ext:Store ID="Store1" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Col1" />
                                    <ext:ModelField Name="Col2" />
                                    <ext:ModelField Name="Col3" />
                                    <ext:ModelField Name="Col4" />
                                    <ext:ModelField Name="Col5" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>    
                </Store>
                <ColumnModel runat="server">
		            <Columns>
                        <ext:RowNumbererColumn runat="server" Width="25" />
                        <ext:Column runat="server" Text="Column ¹1" Width="75" DataIndex="Col1" />
                        <ext:Column runat="server" Text="Column ¹2" Width="75" DataIndex="Col2" />
                        <ext:Column runat="server" Text="Column ¹3" Width="75" DataIndex="Col3" />
                        <ext:Column runat="server" Text="Column ¹4" Width="75" DataIndex="Col4" />
                        <ext:Column runat="server" Text="Column ¹5" Width="75" DataIndex="Col5" />
		            </Columns>
                </ColumnModel> 
                <View>
                    <ext:GridView runat="server" ForceFit="true" />
                </View>            
                <Listeners>                                
                    <AfterRender Handler="this.headerCt.getMenu().allowOtherMenus = true;" />
                    <CellClick Handler="cellSelect(this, record, cellIndex, #{TextField1}, #{ContextMenu});" />
                </Listeners>  
            </ext:GridPanel>                    
        </Items>
    </ext:Menu>
    
    <h1>Menus with Controls</h1>
    
    <h2>Click the right button on the text field for select value</h2>
    
    <ext:TextField 
        ID="TextField1" 
        runat="server" 
        Width="200" 
        ContextMenuID="ContextMenu" 
        ReadOnly="true" />
    
    <h2>See Menu in the Toolbar</h2>
    
    <ext:Toolbar runat="server" Width="500">
        <Items>
            <ext:Button runat="server" Text="Form controls" Icon="NoteEdit">
                <Menu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem runat="server" Icon="NoteEdit" Text="Item" />
                            <ext:TextField runat="server" Width="200" MarginSpec="0 0 2 30" />
                            <ext:DateField runat="server" Width="200" MarginSpec="0 0 2 30" />
                            <ext:MenuSeparator runat="server" />
                            <ext:TextArea 
                                runat="server" 
                                Width="200" 
                                Height="100" 
                                MarginSpec="0 0 2 30" 
                                />
                            <ext:MenuSeparator runat="server" />
                            <ext:ComboBox 
                                ID="ComboBox1" 
                                runat="server" 
                                Width="200" 
                                Editable="false" 
                                MarginSpec="0 0 2 30">
                                <Items>
                                    <ext:ListItem Text="Text1" />
                                    <ext:ListItem Text="Text2" />
                                    <ext:ListItem Text="Text3" />
                                    <ext:ListItem Text="Text4" />
                                    <ext:ListItem Text="Text5" />
                                </Items>
                                <SelectedItems>
                                    <ext:ListItem Value="Text4" />
                                </SelectedItems>
                            </ext:ComboBox>    
                            <ext:MenuSeparator runat="server" />
                            <ext:FieldSet 
                                runat="server" 
                                Title="Account Information" 
                                MarginSpec="0 0 2 30">
                                <Items>
                                    <ext:TextField runat="server" Width="170" HideLabel="true" />           
                                    <ext:TextField runat="server" Width="170" HideLabel="true" />                
                                </Items>
                            </ext:FieldSet>
                        </Items>
                    </ext:Menu>
                </Menu>
            </ext:Button>
            
            <ext:Button runat="server" Text="Panels" Icon="Application">
                <Menu>
                    <ext:Menu ID="PanelsMenu" runat="server">
                        <Items>
                            <ext:Panel 
                                ID="AutoLoadPanel" 
                                runat="server" 
                                Title="Ext.NET Site (lazy loading)"   
                                Width="300" 
                                Height="200">
                                <TopBar>
                                    <ext:Toolbar runat="server">
                                        <Items>
                                            <ext:ToolbarFill />
                                            <ext:Button runat="server" Text="Reload" Icon="ArrowRefreshSmall">
                                                <Listeners>
                                                    <Click Handler="this.up('panel').reload();" />
                                                </Listeners>
                                            </ext:Button>
                                        </Items>
                                    </ext:Toolbar>
                                </TopBar>
                                <Loader runat="server" Url="http://www.ext.net/" Mode="Frame">
                                    <LoadMask ShowMask="true" />
                                </Loader>
                            </ext:Panel>
                                
                            <ext:MenuSeparator />
                            
                            <ext:TabPanel 
                                runat="server" 
                                ActiveTabIndex="0" 
                                Width="300" 
                                Height="100">
                                <Items>
                                    <ext:Panel runat="server" Title="Tab1" Icon="Tab">
                                        <Items>
                                            <ext:Button ID="Button3" runat="server" Text="Close Menu" Icon="Door">
                                                <Listeners>
                                                    <Click Handler="this.up('menu').hide();" />
                                                </Listeners>
                                            </ext:Button>                        
                                        </Items>
                                    </ext:Panel>
                                    <ext:Panel runat="server" Title="Tab2" Icon="Tab" />
                                    <ext:Panel runat="server" Title="Tab3" Icon="Tab" />
                                </Items>                                
                            </ext:TabPanel>                                
                        </Items>
                    </ext:Menu>
                </Menu>
            </ext:Button>
            <%--<ext:Button runat="server" Text="Property Grid" Icon="Table">
                <Menu>
                    <ext:Menu ID="Menu2" runat="server">
                        <Items>
                            <ext:PropertyGrid 
                                ID="PropertyGrid1" 
                                runat="server" 
                                Width="300" 
                                Height="300">
                                <Source>
                                    <ext:PropertyGridParameter Name="(name)" Value="Properties Grid" />
                                    <ext:PropertyGridParameter Name="grouping" Value="false" Mode="Raw" />
                                    <ext:PropertyGridParameter Name="autoFitColumns" Value="true" Mode="Raw" />
                                    <ext:PropertyGridParameter Name="productionQuality" Value="false" Mode="Raw" />
                                    <ext:PropertyGridParameter Name="created" Value="10/15/2006">
                                        <Editor>
                                            <ext:DateField ID="DateField1" runat="server" HideTrigger="true">
                                            </ext:DateField>
                                        </Editor>
                                    </ext:PropertyGridParameter>
                                    <ext:PropertyGridParameter Name="tested" Value="false" Mode="Raw" />
                                    <ext:PropertyGridParameter Name="version" Value="0.01" />
                                    <ext:PropertyGridParameter Name="borderWidth" Value="5" Mode="Raw" />
                                </Source>
                                <View>
                                    <ext:GridView runat="server" ForceFit="true" ScrollOffset="2" />
                                </View>
                                <Buttons>
                                    <ext:Button runat="server" Text="Save" Icon="Disk">                    
                                    </ext:Button>                
                                </Buttons>           
                            </ext:PropertyGrid>                                
                        </Items>                                                
                    </ext:Menu>
                </Menu>
            </ext:Button>--%>
            <ext:Button runat="server" Text="Layouts" Icon="Layout">
                <Menu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:Panel runat="server" Width="300" Height="200" Layout="BorderLayout">
                                <Items>
                                    <ext:Panel runat="server" Region="West" Split="true" Collapsible="true" Title="West" Width="100" />
                                    <ext:Panel runat="server" Region="Center" Title="Center" />
                                </Items>
                            </ext:Panel>
                                
                            <ext:Panel runat="server" Width="300" Height="200" Layout="Accordion">
                                <Items>
                                    <ext:Panel runat="server" Title="Panel1" Collapsed="false" />
                                    <ext:Panel runat="server" Title="Panel2" />
                                    <ext:Panel runat="server" Title="Panel3" />
                                </Items>
                            </ext:Panel>                               
                        </Items>                        
                    </ext:Menu>
                </Menu>
            </ext:Button>
        </Items>
    </ext:Toolbar>
</body>
</html>
