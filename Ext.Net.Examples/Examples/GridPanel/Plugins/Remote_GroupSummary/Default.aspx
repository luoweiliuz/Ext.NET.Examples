<%@ Page Language="C#" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<script runat="server">    
    protected void OnReadData(object sender, StoreReadDataEventArgs e)
    {
        CultureInfo ci = new CultureInfo("en-US");
        Store store = GridPanel1.Store.Primary;
        var data = new List<Project> 
             { 
                 new Project(100, "Ext Forms: Field Anchoring", 112, "Integrate 2.0 Forms with 2.0 Layouts", 6, 150, 0, DateTime.Parse("06/24/2007",ci)),
                 new Project(100, "Ext Forms: Field Anchoring", 113, "Implement AnchorLayout", 4, 150, 0, DateTime.Parse("06/25/2007",ci)),
                 new Project(100, "Ext Forms: Field Anchoring", 114, "Add support for multiple types of anchors", 4, 150, 0, DateTime.Parse("06/27/2007",ci)),
                 new Project(100, "Ext Forms: Field Anchoring", 115, "Testing and debugging", 8, 0, 0, DateTime.Parse("06/29/2007",ci)),
                 new Project(101, "Ext Grid: Single-level Grouping", 101, "Add required rendering \"hooks\" to GridView", 6, 100, 0, DateTime.Parse("07/01/2007",ci)),
                 new Project(101, "Ext Grid: Single-level Grouping", 102, "Extend GridView and override rendering functions", 6, 100, 0, DateTime.Parse("07/03/2007",ci)),
                 new Project(101, "Ext Grid: Single-level Grouping", 103, "Extend Store with grouping functionality", 4, 100, 0, DateTime.Parse("07/04/2007",ci)),
                 new Project(101, "Ext Grid: Single-level Grouping", 121, "Default CSS Styling", 2, 100, 0, DateTime.Parse("07/05/2007",ci)),
                 new Project(101, "Ext Grid: Single-level Grouping", 104, "Testing and debugging", 6, 100, 0, DateTime.Parse("07/06/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 105, "Ext Grid plugin integration", 4, 125, 0, DateTime.Parse("07/01/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 106, "Summary creation during rendering phase", 4, 125, 0, DateTime.Parse("07/02/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 107, "Dynamic summary updates in editor grids", 6, 125, 0, DateTime.Parse("07/05/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 108, "Remote summary integration", 4, 125, 0, DateTime.Parse("07/05/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 109, "Summary renderers and calculators", 4, 125, 0, DateTime.Parse("07/06/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 110, "Integrate summaries with GroupingView", 10, 125, 0, DateTime.Parse("07/11/2007",ci)),
                 new Project(102, "Ext Grid: Summary Rows", 111, "Testing and debugging", 8, 125, 0, DateTime.Parse("07/15/2007",ci))
             };

        var summaryData = new List<object> 
        {
            new {Name = "Ext Grid: Single-level Grouping", Description = 13, Estimate = 6, Rate = 100, Due = DateTime.Parse("07/06/2012",ci), Cost = 1234},
	        new {Name = "Ext Forms: Field Anchoring", Description = 14, Estimate = 9, Rate = 50, Due = DateTime.Parse("06/29/2007",ci), Cost = 999},
	        new {Name = "Ext Grid: Summary Rows", Description = 11, Estimate = 4, Rate = 44, Due = DateTime.Parse("06/29/2011",ci), Cost = 789}
        };

        store.Data = new { data, summaryData };
        store.DataBind();
    }

    public class Project
    {
        public Project(int projectId, string name, int taskId, string description, int estimate, double rate, double cost, DateTime due)
        {
            this.ProjectID = projectId;
            this.Name = name;
            this.TaskID = taskId;
            this.Description = description;
            this.Estimate = estimate;
            this.Rate = rate;
            this.Due = due;
        }

        public int ProjectID { get; set; }
        public string Name { get;set; }
        public int TaskID { get; set; }
        public string Description { get;set; }
        public int Estimate { get;set; }
        public double Rate { get; set; }
        public double Cost { get; set; }
        public DateTime Due { get; set; }
    }
</script>

<html>
<head runat="server">
    <title>Grouping with Remote Summary - Ext.NET Examples</title>
    
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
   
    <style type="text/css">
        .x-grid-body .x-grid-cell-Cost {
            background-color : #f1f2f4;
        }
         
        .x-grid-row-summary .x-grid-cell-Cost .x-grid-cell-inner{
            background-color : #e1e2e4;
        }    

        .task .x-grid-cell-inner {
            padding-left: 15px;
        }

        .x-grid-row-summary .x-grid-cell-inner {
            font-weight: bold;
            font-size: 11px;
            background-color : #f1f2f4;
        } 
    </style>
</head>
<body>
    <form runat="server">
        <h1>Grouping with Remote Summary</h1>
        <p>This example demonstrates the use of the GroupingSummaryFeature with server-side summary calculation (results are intentionally wrong).</p>        

        <ext:ResourceManager runat="server"/>
        
        <ext:GridPanel 
            ID="GridPanel1" 
            runat="server" 
            Title="Sponsored Projects"
            Icon="ApplicationViewColumns"
            Width="800"
            Height="450">
            <Store>
                <ext:Store runat="server" GroupField="Name" OnReadData="OnReadData">
                    <Sorters>
                        <ext:DataSorter Property="Due" Direction="ASC" />
                    </Sorters>                    
                    <Model>
                        <ext:Model runat="server" IDProperty="TaskID">
                            <Fields>
                                <ext:ModelField Name="ProjectID" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="TaskID" />
                                <ext:ModelField Name="Description" />
                                <ext:ModelField Name="Estimate" Type="Int" />
                                <ext:ModelField Name="Rate" Type="Float" />
                                <ext:ModelField Name="Due" Type="Date" />
                                <ext:ModelField Name="Cost" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Proxy>
                        <ext:PageProxy>
                            <Reader>
                                <ext:JsonReader Root="data.data" />
                            </Reader>
                        </ext:PageProxy>
                    </Proxy>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:SummaryColumn                        
                        runat="server"
                        TdCls="task"
                        Text="Task"                       
                        Sortable="true"
                        DataIndex="Description"
                        Hideable="false"
                        Flex="1">
                        <SummaryRenderer Handler="return ((value === 0 || value > 1) ? '(' + value +' Tasks)' : '(1 Task)');" />                            
                    </ext:SummaryColumn>
                     
                    <ext:Column runat="server" Text="Project" DataIndex="Name" Width="20" />
                     
                    <ext:SummaryColumn
                        runat="server"
                        Width="85"
                        Text="Due Date"
                        Sortable="true"
                        DataIndex="Due">
                        <Renderer Format="Date" FormatArgs="'m/d/Y'" />         
                        <SummaryRenderer Fn="Ext.util.Format.dateRenderer('m/d/Y')" />                                                               
                    </ext:SummaryColumn>
 
                    <ext:SummaryColumn
                        runat="server"  
                        Width="75"
                        Text="Estimate"
                        Sortable="true"
                        DataIndex="Estimate">
                        <Renderer Handler="return value +' hours';" />
                        <SummaryRenderer Handler="return value +' hours';" />                        
                    </ext:SummaryColumn>
                     
                    <ext:SummaryColumn
                        runat="server"
                        Width="75"
                        Text="Rate"
                        Sortable="true"
                        DataIndex="Rate"
                        SummaryType="Average">
                        <Renderer Format="UsMoney" />
                        <SummaryRenderer Fn="Ext.util.Format.usMoney" />                         
                    </ext:SummaryColumn>
                     
                    <ext:SummaryColumn
                        runat="server"
                        Width="75"
                        ID="Cost"
                        Text="Cost"
                        Sortable="false"
                        Groupable="false"
                        DataIndex="Cost">
                        <Renderer Handler="return Ext.util.Format.usMoney(record.data.Estimate * record.data.Rate);" />
                        <SummaryRenderer Fn="Ext.util.Format.usMoney" />
                    </ext:SummaryColumn>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" StripeRows="false" />
            </View>         
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Toggle" ToolTip="Toggle the visibility of summary row">
                            <Listeners>
                                <Click Handler="#{GroupingSummary1}.toggleSummaryRow(!#{GroupingSummary1}.showSummaryRow);#{GroupingSummary1}.view.refresh();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>   
            <Features>               
                <ext:GroupingSummary ID="GroupingSummary1" runat="server" GroupHeaderTpl="{name}" HideGroupedHeader="true" RemoteRoot="data.summaryData">                   
                </ext:GroupingSummary>
            </Features>  
        </ext:GridPanel>
    </form>
  </body>
</html>