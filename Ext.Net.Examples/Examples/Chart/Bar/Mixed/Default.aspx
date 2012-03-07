<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        var store = this.Chart1.GetStore();
        
        store.DataSource = Ext.Net.Examples.ChartData.GenerateData(8);
        store.DataBind();
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Mixed Charts - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Mixed Charts Example</h1>

        <p>Display 3 sets of random data using a line, bar, and scatter series. Reload data will randomly generate a new set of data in the store.</p>

        <ext:Panel 
            runat="server"
            Title="Mixed Charts"
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

                        <ext:Button 
                            runat="server" 
                            Text="Animate" 
                            Icon="ShapesManySelect" 
                            EnableToggle="true" 
                            Pressed="true">
                            <Listeners>
                                <Toggle Handler="#{Chart1}.animate = pressed ? {easing: 'ease', duration: 500} : false;" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    StyleSpec="background:#fff;"                   
                    StandardTheme="Category1"
                    Animate="true">
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(8) %>" 
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
                            Grid="true"
                            />
                        <ext:CategoryAxis 
                            Position="Bottom"
                            Fields="Name"
                            Title="Month of the Year"
                            />                            
                    </Axes>
                    <Series>
                        <ext:ColumnSeries Axis="Left" XField="Name" YField="Data1" />
                        <ext:ScatterSeries Axis="Left" XField="Name" YField="Data2">
                            <MarkerConfig Type="Circle" Size="5" />
                        </ext:ScatterSeries>
                        <ext:LineSeries Axis="Left" Smooth="3" Fill="true" XField="Name" YField="Data3" />
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>
