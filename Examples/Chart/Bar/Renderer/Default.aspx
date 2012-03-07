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
    <title>Bar Renderer - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var barRenderer = function (sprite, record, attr, index, store) {
            var fieldValue = Math.random() * 20 + 10,
                value = (record.get('Data1') >> 0) % 5,
                color = ['rgb(213, 70, 121)',
                            'rgb(44, 153, 201)',
                            'rgb(146, 6, 157)',
                            'rgb(49, 149, 0)',
                            'rgb(249, 153, 0)'][value];

            return Ext.apply(attr, {
                fill: color
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Bar Renderer Sample</h1>

        <p>Displaying a horizontal bar series with a bar renderer that modifies the color of each bar.</p>

        <ext:Panel 
            runat="server"
            Title="Bar Renderer"
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
                    StyleSpec="background:#fff"
                    Animate="true">
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
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Axes>
                        <ext:NumericAxis                             
                            Fields="Data1"
                            Position="Bottom"
                            Grid="true"
                            Title="Number of Hits"
                            Minimum="0">
                            <Label>
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
                        </ext:NumericAxis>                            

                        <ext:CategoryAxis 
                            Fields="Name"
                            Title="Month of the Year"
                            />                            
                    </Axes>

                    <Series>
                        <ext:BarSeries 
                            Axis="Bottom"                            
                            XField="Name" 
                            YField="Data1">                            
                            <Label 
                                Display="InsideEnd" 
                                Field="Data1" 
                                Orientation="Horizontal" 
                                Color="#333" 
                                TextAnchor="middle" 
                                Contrast="true">
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
                            <Renderer Fn="barRenderer" />
                        </ext:BarSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>