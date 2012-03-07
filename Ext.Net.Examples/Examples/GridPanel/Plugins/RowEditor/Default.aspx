<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.ObjectModel" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            var store = this.GridPanel1.GetStore();
            
            store.DataSource = new List<object>
            {
                new { 
                    Name = "Bill Foot", 
                    Email = "bill.foot@ext.net", 
                    Start = new DateTime(2007, 2, 5), 
                    Salary = 37000, 
                    Active = true
                },
                new { 
                    Name = "Bill Little", 
                    Email = "bill.little@ext.net", 
                    Start = new DateTime(2009, 6, 13), 
                    Salary = 53000, 
                    Active = true
                },
                new { 
                    Name = "Bob Jones", 
                    Email = "bob.jones@ext.net", 
                    Start = new DateTime(2008, 10, 6), 
                    Salary = 70000, 
                    Active = true
                },
                new { 
                    Name = "Bob Train", 
                    Email = "bob.train@ext.net", 
                    Start = new DateTime(2009, 5, 5), 
                    Salary = 68000, 
                    Active = true
                },
                new { 
                    Name = "Chris Johnson", 
                    Email = "chris.johnson@ext.net", 
                    Start = new DateTime(2009, 1, 25), 
                    Salary = 47000, 
                    Active = true
                }
            };
            
            store.DataBind();
        }
    }
</script>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>GridPanel with RowEditor Plugin - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <ext:XScript runat="server">
        <script type="text/javascript">
            var addEmployee = function () {
                var grid = #{GridPanel1};
                grid.editingPlugin.cancelEdit();

                // Create a record instance through the ModelManager
                var r = Ext.ModelManager.create({
                    name: 'New Guy',
                    email: 'new@ext.net',
                    start: new Date(),
                    salary: 50000,
                    active: true
                }, 'Employee');

                grid.store.insert(0, r);
                grid.editingPlugin.startEdit(0, 0);
            }
            
            var removeEmployee = function () {
                var grid = #{GridPanel1},
                    sm = grid.getSelectionModel();

                grid.editingPlugin.cancelEdit();
                grid.store.remove(sm.getSelection());
                if (grid.store.getCount() > 0) {
                    sm.select(0);
                }
            }
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>GridPanel with RowEditor Plugin</h1>
        
        <ext:GridPanel 
            ID="GridPanel1" 
            runat="server"
            Width="600"
            Height="400"
            Frame="true"
            Title="Employees">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Sorters>
                        <ext:DataSorter Property="start" Direction="ASC" />
                    </Sorters>
                    <Model>
                        <ext:Model runat="server" Name="Employee">
                            <Fields>
                                <ext:ModelField Name="name" Mapping="Name" Type="String" />
                                <ext:ModelField Name="email" Mapping="Email" Type="String" />
                                <ext:ModelField Name="start" Mapping="Start" Type="Date" />
                                <ext:ModelField Name="salary" Mapping="Salary" Type="Float" />
                                <ext:ModelField Name="active" Mapping="Active" Type="Boolean" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <Plugins>
                <ext:RowEditing runat="server" ClicksToMoveEditor="1" AutoCancel="false" />
            </Plugins>            
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Add Employee" Icon="UserAdd">
                            <Listeners>
                                <Click Fn="addEmployee" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnRemoveEmployee" runat="server" Text="Remove Employee" Icon="UserDelete" Disabled="true">
                            <Listeners>
                                <Click Fn="removeEmployee" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>            
            <ColumnModel>
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="25" />
                    <ext:Column runat="server"                         
                        Text="Name" 
                        DataIndex="name" 
                        Flex="1">
                        <Editor>
                            <ext:TextField runat="server" AllowBlank="false" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Text="Email" DataIndex="email" Width="160">
                        <Editor>
                            <ext:TextField runat="server" AllowBlank="false" Vtype="email" />
                        </Editor>
                    </ext:Column>
                    <ext:DateColumn runat="server" 
                        Text="Start Date" 
                        DataIndex="start" 
                        Format="MM/dd/yyyy" 
                        Width="100">
                        <Editor>
                            <ext:DateField 
                                runat="server" 
                                AllowBlank="false" 
                                Format="MM/dd/yyyy"
                                MinDate="01.01.2006" 
                                MinText="Can not have a start date before the Company existed." 
                                MaxDate="<%# DateTime.Now %>"
                                AutoDataBind="true"
                                />
                        </Editor>
                    </ext:DateColumn>
                    <ext:NumberColumn
                        runat="server"
                        Text="Salary" 
                        DataIndex="salary" 
                        Format="$0,0">
                        <Editor>
                            <ext:NumberField 
                                runat="server" 
                                AllowBlank="false" 
                                MinValue="1" 
                                MaxValue="150000" 
                                />
                        </Editor>
                    </ext:NumberColumn>
                    <ext:CheckColumn
                        runat="server"
                        Text="Active?" 
                        DataIndex="active"                         
                        Width="50">
                        <Editor>
                            <ext:Checkbox runat="server" Cls="x-grid-checkheader-editor" />
                        </Editor>
                    </ext:CheckColumn>
                </Columns>
            </ColumnModel>
            <Listeners>
                <SelectionChange Handler="#{btnRemoveEmployee}.setDisabled(!selected.length);" />
            </Listeners>
        </ext:GridPanel>
    </form>  
</body>
</html>