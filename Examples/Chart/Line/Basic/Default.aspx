<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        var store = this.Chart1.GetStore();
        
        store.DataSource = Ext.Net.Examples.ChartData.GenerateData();
        store.DataBind();
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Example</h1>

	    <p>Display 2 sets of random data in a line series. Reload data will randomly generate a new set of data in the store. Click on the legend items to remove them from the chart.</p>

        <ext:Panel 
            runat="server"
            Title="Line Chart"
            Width="800"
            Height="600"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button 
                            runat="server" 
                            Text="Reload Data" 
                            Icon="ArrowRefresh" 
                            OnDirectClick="ReloadData" 
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    StyleSpec="background:#fff;"                   
                    Shadow="true"
                    StandardTheme="Category1"
                    Animate="true">
                    <LegendConfig Position="Right" />
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>" 
                            AutoDataBind="true">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis                             
                            Fields="Data1,Data2,Data3"
                            Title="Number of Hits"
                            MinorTickSteps="1"
                            Minimum="0">
                            <GridConfig>
                                <Odd Opacity="1" Fill="#ddd" Stroke="#bbb" StrokeWidth="0.5" />
                            </GridConfig>
                        </ext:NumericAxis>                            

                        <ext:CategoryAxis 
                            Position="Bottom"
                            Fields="Name"
                            Title="Month of the Year"
                            />                            
                    </Axes>
                    <Series>
                        <ext:LineSeries Axis="Left" XField="Name" YField="Data1">
                            <HighlightConfig Size="7" Radius="7" />
                            <MarkerConfig Type="Cross" Size="4" Radius="4" StrokeWidth="0" />
                        </ext:LineSeries>

                        <ext:LineSeries Axis="Left" Smooth="3" XField="Name" YField="Data2">
                            <HighlightConfig Size="7" Radius="7" />
                            <MarkerConfig Type="Circle" Size="4" Radius="4" StrokeWidth="0" />
                        </ext:LineSeries>

                        <ext:LineSeries Axis="Left" Smooth="3" Fill="true" XField="Name" YField="Data3">
                            <HighlightConfig Size="7" Radius="7" />
                            <MarkerConfig Type="Circle" Size="4" Radius="4" StrokeWidth="0" />
                        </ext:LineSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>