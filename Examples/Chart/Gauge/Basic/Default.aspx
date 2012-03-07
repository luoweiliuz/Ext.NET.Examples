<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        var store1 = this.Chart1.GetStore();
        var store2 = this.Chart2.GetStore();
        var store3 = this.Chart3.GetStore();
        
        store1.DataSource = Ext.Net.Examples.ChartData.GenerateData();
        store1.DataBind();

        store2.DataSource = Ext.Net.Examples.ChartData.GenerateData();
        store2.DataBind();

        store3.DataSource = Ext.Net.Examples.ChartData.GenerateData();
        store3.DataBind();
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Gauge Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Gauge</h1>

        <p>Displaying three custom gauge charts bound to different data stores with different configuration options and easings.</p>
        
        <p>Click on <b>Reload Data</b> to update the information.</p>

        <ext:Panel 
            runat="server"
            Title="Gauge Charts"
            Width="800"
            Height="250">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
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
                    InsetPadding="25"
                    Flex="1">
                    <AnimateConfig Easing="ElasticIn" Duration="1000" />
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
                        <ext:GaugeAxis Minimum="0" Maximum="100" Steps="10" Margin="-10" />
                    </Axes>
                    <Series>
                        <ext:GaugeSeries AngleField="Data1" Donut="0" ColorSet="#F49D10,#ddd" />
                    </Series>
                </ext:Chart>

                <ext:Chart 
                    ID="Chart2" 
                    runat="server"
                    Animate="true"
                    StyleSpec="background:#fff;"
                    InsetPadding="25"
                    Flex="1">
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
                        <ext:GaugeAxis Minimum="0" Maximum="100" Steps="10" Margin="7" />
                    </Axes>
                    <Series>
                        <ext:GaugeSeries AngleField="Data1" Donut="30" ColorSet="#82B525,#ddd" />
                    </Series>
                </ext:Chart>

                <ext:Chart 
                    ID="Chart3" 
                    runat="server"
                    StyleSpec="background:#fff;"
                    InsetPadding="25"
                    Flex="1">
                    <AnimateConfig Easing="BounceOut" Duration="500" />
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
                        <ext:GaugeAxis Minimum="0" Maximum="100" Steps="10" Margin="7" />
                    </Axes>
                    <Series>
                        <ext:GaugeSeries AngleField="Data1" Donut="80" ColorSet="#3AA8CB,#ddd" />
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>