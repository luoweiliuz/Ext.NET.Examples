<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        var store = this.Chart1.GetStore();
        
        store.DataSource = Ext.Net.Examples.ChartData.GenerateData(5, 0);
        store.DataBind();
    }
</script> 

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />   
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>

        <p>Display a sets of random data in a column series. Reload data will randomly generate a new set of data in the store.</p>

        <ext:ChartTheme 
            ID="FancyTheme" 
            runat="server" 
            ThemeName="Fancy" 
            Colors="url(#v-1),url(#v-2),url(#v-3),url(#v-4),url(#v-5)">
            <Axis Fill="#eee" Stroke="#eee" />
            <AxisLabelLeft Fill="#eee" />
            <AxisLabelBottom Fill="#eee" />
            <AxisTitleLeft Fill="#eee" />
            <AxisTitleBottom Fill="#eee" />
        </ext:ChartTheme>

        <ext:Panel 
            runat="server"
            Title="Column Chart"
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
                    Theme="Fancy"
                    Shadow="true">
                    <AnimateConfig Easing="BounceOut" Duration="750" />
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData(5, 0) %>" 
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

                    <Background Fill="rgb(17, 17, 17)" />

                    <Gradients>
                        <ext:Gradient GradientID="v-1" Angle="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(212, 40, 40)" />
                                <ext:GradientStop Offset="100" Color="rgb(117, 14, 14)" />
                            </Stops>
                        </ext:Gradient>

                        <ext:Gradient GradientID="v-2" Angle="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(180, 216, 42)" />
                                <ext:GradientStop Offset="100" Color="rgb(94, 114, 13)" />
                            </Stops>
                        </ext:Gradient>

                        <ext:Gradient GradientID="v-3" Angle="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(43, 221, 115)" />
                                <ext:GradientStop Offset="100" Color="rgb(14, 117, 56)" />
                            </Stops>
                        </ext:Gradient>

                        <ext:Gradient GradientID="v-4" Angle="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(45, 117, 226)" />
                                <ext:GradientStop Offset="100" Color="rgb(14, 56, 117)" />
                            </Stops>
                        </ext:Gradient>

                        <ext:Gradient GradientID="v-5" Angle="0">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="rgb(187, 45, 222)" />
                                <ext:GradientStop Offset="100" Color="rgb(85, 10, 103)" />
                            </Stops>
                        </ext:Gradient>
                    </Gradients>

                    <Axes>
                        <ext:NumericAxis                             
                            Fields="Data1"                                                        
                            Title="Number of Hits"
                            Minimum="0"
                            Maximum="100">
                            <Label>
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
                            <GridConfig>
                                <Odd Stroke="#555" />
                                <Even Stroke="#555" />
                            </GridConfig>
                        </ext:NumericAxis>                            

                        <ext:CategoryAxis 
                            Position="Bottom"
                            Fields="Name"
                            Title="Month of the Year"
                            />                            
                    </Axes>

                    <Series>
                        <ext:ColumnSeries 
                            Axis="Left"
                            Highlight="true" 
                            XField="Name" 
                            YField="Data1">                            
                            <Label 
                                Display="InsideEnd" 
                                Field="Data1" 
                                Orientation="Horizontal" 
                                Fill="#fff" 
                                Font="17px Arial" 
                                TextAnchor="middle">
                                <Renderer Handler="return Ext.util.Format.number(value, '0');" />
                            </Label>
                            <Style Opacity="0.95" />
                            <Renderer Handler="var colors = ['url(#v-1)','url(#v-2)','url(#v-3)','url(#v-4)','url(#v-5)'];attributes.fill = colors[index % colors.length]; return attributes;" />
                        </ext:ColumnSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>