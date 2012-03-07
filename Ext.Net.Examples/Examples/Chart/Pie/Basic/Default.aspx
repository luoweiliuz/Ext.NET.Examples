<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        var store = this.Chart1.GetStore();
        
        store.DataSource = Ext.Net.Examples.ChartData.GenerateData(6);
        store.DataBind();
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Pie Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var tipRenderer = function (storeItem, item) {
            //calculate percentage.
            var total = 0;

            App.Store1.each(function(rec) {
                total += rec.get('Data1');
            });
            
            this.setTitle(storeItem.get('Name') + ': ' + Math.round(storeItem.get('Data1') / total * 100) + '%');
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Pie Chart Example</h1>

        <p>Display 5 sets of random data using a pie chart. Reload data will randomly generate a new set of data in the store.</p>
        
        <p>Toggle Donut button will dynamically change the chart between a Donut and Pie chart.</p>
        
        <p>Click or hover on the legend items to highlight and remove them from the chart. In addition contrast detection has been turned on to dynamically change the font color based on the color of the item it is on.</p>

        <ext:Panel
            runat="server"
            Width="800"
            Height="600"
            Title="Semester Trends"
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
                        <ext:Button runat="server" Text="Donut" EnableToggle="true">
                            <Listeners>
                                <Toggle Handler="#{Chart1}.series.first().donut = pressed ? 35 : false;#{Chart1}.refresh();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <Items>
                <ext:Chart
                    ID="Chart1" 
                    runat="server"
                    Animate="true"
                    Shadow="true"
                    InsetPadding="60"
                    Theme="Base:gradients">
                    <LegendConfig Position="Right" />
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(6) %>" 
                            AutoDataBind="true">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Series>
                        <ext:PieSeries 
                            AngleField="Data1" 
                            ShowInLegend="true" 
                            Donut="0" 
                            Highlight="true" 
                            HighlightSegmentMargin="20">
                            <Label Field="Name" Display="Rotate" Contrast="true" Font="18px Arial" />
                            <Tips TrackMouse="true" Width="140" Height="28">
                                <Renderer Fn="tipRenderer" />
                            </Tips>
                        </ext:PieSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>