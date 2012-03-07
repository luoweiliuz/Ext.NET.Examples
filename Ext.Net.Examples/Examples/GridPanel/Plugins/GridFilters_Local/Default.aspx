<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.ObjectModel" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = FiltersTestData.Data;
            this.Store1.DataBind();
        }
    }
    
    protected void SetFilter(object sender, DirectEventArgs e)
    {
        StringFilter sf = (StringFilter)GridFilters1.Filters[1];
        sf.SetValue("3m Co");
        sf.SetActive(true);
    }
</script>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>GridPanel with Local Filtering, Sorting and Paging - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectEventUrl="default.aspx" />
    
    <h1>GridPanel with Local Filtering, Sorting and Paging</h1>
    
    <p>Please see column header menu for apllying filters</p>
    
    <ext:Store runat="server" ID="Store1" PageSize="10">
        <Model>
            <ext:Model runat="server" IDProperty="Id">
                <Fields>
                    <ext:ModelField Name="Id" Type="Int" />
                    <ext:ModelField Name="Company" Type="String" />
                    <ext:ModelField Name="Price" Type="Float" />
                    <ext:ModelField Name="Date" Type="Date" DateFormat="yyyy-MM-ddTHH:mm:ss" />
                    <ext:ModelField Name="Size" Type="String" />
                    <ext:ModelField Name="Visible" Type="Boolean" />
                </Fields>
            </ext:Model>
        </Model>
        <Sorters>
            <ext:DataSorter Property="Company" Direction="ASC" />
        </Sorters>        
    </ext:Store>
    
    <ext:Window 
        ID="Window1" 
        runat="server"         
        Width="700" 
        Height="400" 
        Closable="false"
        Collapsible="true"
        Title="Example" 
        Maximizable="true"
        Layout="Fit">
        <Items>
            <ext:GridPanel runat="server" Border="false" StoreID="Store1">
                <ColumnModel runat="server">
                    <Columns>
                        <ext:Column runat="server" Text="ID" DataIndex="Id" />
                        <ext:Column runat="server" Text="Company" DataIndex="Company" />
                        <ext:Column runat="server" Text="Price" DataIndex="Price">
                            <Renderer Format="UsMoney" />
                        </ext:Column>
                        <ext:DateColumn runat="server" Text="Date" DataIndex="Date" Align="Center" Format="yyyy-MM-dd" />
                        <ext:Column runat="server" Text="Size" DataIndex="Size" />
                        <ext:Column runat="server" Text="Visible" DataIndex="Visible" Align="Center">
                            <Renderer Handler="return (value) ? 'Yes':'No';" />
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <Features>
                    <ext:GridFilters runat="server" ID="GridFilters1" Local="true">
                        <Filters>
                            <ext:NumericFilter DataIndex="Id" />
                            <ext:StringFilter DataIndex="Company" />
                            <ext:NumericFilter DataIndex="Price" />
                            <ext:DateFilter DataIndex="Date">
                                <DatePickerOptions runat="server" TodayText="Now" />
                            </ext:DateFilter>
                            <ext:ListFilter DataIndex="Size" Options="extra small,small,medium,large,extra large" />
                            <ext:BooleanFilter DataIndex="Visible" />
                        </Filters>
                    </ext:GridFilters>
                </Features>
                <BottomBar>
                    <ext:PagingToolbar runat="server">
                        <Items>
                            <ext:ToolbarSeparator runat="server" />
                            <ext:Button runat="server" Text="Find '3m Co'">
                                <DirectEvents>
                                    <Click OnEvent="SetFilter" />
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:PagingToolbar>
                </BottomBar>                   
            </ext:GridPanel>
        </Items>
    </ext:Window>
</body>
</html>
