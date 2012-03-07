<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        var store = this.Chart1.GetStore();
        
        store.DataSource = Ext.Net.Examples.ChartData.GenerateData(5);
        store.DataBind();
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Pie Renderer Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var segmentRenderer = function (sprite, record, attr, index, store) {
            var value = (record.get('Data1') >> 0) % 9,
                color = [ "#94ae0a", "#115fa6","#a61120", "#ff8809", "#ffd13e", "#a61187", "#24ad9a", "#7c7474", "#a66111"][value];

            return Ext.apply(attr, {
                fill: color
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Pie Renderer Example</h1>

        <p>Display 5 sets of random data using a pie chart. Reload data will randomly generate a new set of data in the store. A renderer has been set up on to dynamically change the length and color of each slice based on the data.  In addition contrast detection has been turned on to dynamically change the font color based on the color of the item it is on.</p>

        <ext:Panel 
            runat="server"
            Title="Pie Renderer Chart"
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
                    Animate="true">
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(5) %>" 
                            AutoDataBind="true">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    
                    <Series>
                        <ext:PieSeries
                            Highlight="true"
                            HighlightSegmentMargin="20"
                            AngleField="Data1"                             
                            LengthField="Data2">
                                <Style StrokeWidth="1" Stroke="#fff" />
                                <Label Field="Name" Display="Rotate" Contrast="true" Font="14px Arial" />
                                <Renderer Fn="segmentRenderer" />
                        </ext:PieSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>