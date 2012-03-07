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
    <title>Filled Radar Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Radar Fill Example</h1>

        <p>Display 3 sets of random data in a filled radar series. Reload data will randomly generate a new set of data in the store.</p> 
        
        <p>Note this example uses a radial axis. Click or hover on the legend items to highlight and remove them from the chart.</p>

        <ext:Panel 
            runat="server"
            Title="Filled Radar Chart"
            Width="800"
            Height="600"
            StyleSpec="overflow:hidden;"
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
                    StandardTheme="Category2"
                    InsetPadding="20"
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
                        <ext:RadialAxis />
                    </Axes>
                    <Series>
                        <ext:RadarSeries XField="Name" YField="Data1" ShowInLegend="true">
                            <Style Opacity="0.4" />
                        </ext:RadarSeries>

                        <ext:RadarSeries XField="Name" YField="Data2" ShowInLegend="true">
                            <Style Opacity="0.4" />
                        </ext:RadarSeries>

                        <ext:RadarSeries XField="Name" YField="Data3" ShowInLegend="true">
                            <Style Opacity="0.4" />
                        </ext:RadarSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>