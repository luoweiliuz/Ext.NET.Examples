<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Charts - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <style type="text/css">    
        .x-panel {
            margin-bottom : 20px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Charts Example</h1> 

        <p>Displaying multiple charts and mixed charts with mouse over and click interaction.</p>

        <ext:Panel
            runat="server"
            Width="600"
            Height="300"
            Title="Ext.Net Visits Trends, 2007/2008 (No styling)"
            Layout="FitLayout">
            <Items>
                <ext:Chart runat="server" InsetPadding="30">
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
                        <ext:NumericAxis Minimum="0" Fields="Data1" Grid="true">
                            <Label Font="10px Arial">
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name">
                            <Label Font="11px Arial">
                                <Renderer Handler="return value.substr(0, 3) + ' 07';" />
                            </Label>
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:LineSeries Axis="Left" XField="Name" YField="Data1">
                            <Listeners>
                                <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                            </Listeners>

                            <Tips runat="server" TrackMouse="true" Width="80" Height="40">                            
                                <Renderer Handler="this.setTitle(storeItem.get('Name') + '<br />' + storeItem.get('Data1'));"></Renderer>
                            </Tips>

                            <Style Fill="#38B8BF" Stroke="#38B8BF" StrokeWidth="3" />

                            <MarkerConfig 
                                Type="Circle" 
                                Size="4" 
                                Radius="4" 
                                StrokeWidth="0" 
                                Fill="#38B8BF" 
                                Stroke="#38B8BF" 
                                />
                        </ext:LineSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>

        <ext:Panel 
            runat="server"
            Width="600"
            Height="300"
            Title="Ext.Net Visits Trends, 2007/2008 (Simple styling)"
            Layout="FitLayout">
            <Items>
                <ext:Chart runat="server" InsetPadding="30">
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
                        <ext:NumericAxis Minimum="0" Fields="Data1" Grid="true">
                            <Label Font="10px Arial">
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name">
                            <Label Font="11px Arial">
                                <Renderer Handler="return value.substr(0, 3);" />
                            </Label>
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:LineSeries Axis="Left" XField="Name" YField="Data1">
                            <Listeners>
                                <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                            </Listeners>

                            <Tips runat="server" TrackMouse="true" Width="110" Height="25">                            
                                <Renderer Handler="this.setTitle(storeItem.get('Data1') + ' visits in ' + storeItem.get('Name').substr(0, 3));"></Renderer>
                            </Tips>

                            <Style Fill="#38B8BF" Stroke="#38B8BF" StrokeWidth="3" />

                            <MarkerConfig 
                                Type="Circle" 
                                Size="4" 
                                Radius="4" 
                                StrokeWidth="0" 
                                Fill="#38B8BF" 
                                Stroke="#38B8BF" 
                                />
                        </ext:LineSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>

        <ext:Panel 
            runat="server"
            Width="600"
            Height="300"
            Title="Ext.Net Visits Trends, 2007/2008 (Full styling)"
            Layout="FitLayout">
            <Items>
                <ext:Chart runat="server" InsetPadding="30">
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
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Gradients>
                        <ext:Gradient GradientID="bar-gradient" Angle="90">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="#99BBE8" />
                                <ext:GradientStop Offset="70" Color="#77AECE" />
                                <ext:GradientStop Offset="100" Color="#77AECE" />
                            </Stops>
                        </ext:Gradient>
                    </Gradients>

                    <Axes>
                        <ext:NumericAxis Minimum="0" Maximum="100" Fields="Data1" Grid="true">
                            <Label Font="10px Arial">
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name" Grid="true">
                            <Label Font="11px Arial">
                                <Renderer Handler="return value.substr(0, 3);" />
                            </Label>
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:ColumnSeries Axis="Left" XField="Name" YField="Data1">
                            <Style Fill="url(#bar-gradient)" StrokeWidth="3" />                            
                        </ext:ColumnSeries>

                        <ext:LineSeries Axis="Left" XField="Name" YField="Data2">
                            <Listeners>
                                <ItemMouseUp Handler="Ext.net.Notification.show({title:'Item Selected', html:item.value[1] + ' visits on ' + Ext.Date.monthNames[item.value[0]]});" />
                            </Listeners>

                            <Tips runat="server" TrackMouse="true" Width="110" Height="25">                            
                                <Renderer Handler="this.setTitle(storeItem.get('Data2') + ' visits in ' + storeItem.get('Name').substr(0, 3));"></Renderer>
                            </Tips>

                            <Style Fill="#18428E" Stroke="#18428E" StrokeWidth="3" />

                            <MarkerConfig 
                                Type="Circle" 
                                Size="4" 
                                Radius="4" 
                                StrokeWidth="0" 
                                Fill="#18428E" 
                                Stroke="#18428E" 
                                />
                        </ext:LineSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>