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
    <title>Area Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Area Chart Sample</h1>

        <p>Display 7 sets of random data in an area series.</p>
        
        <p>Reload data will randomly generate a new set of data in the store.</p>
        
        <p>Click or hover on the legend items to highlight and remove them from the chart.  The bottom axis has had it's labels rotated.</p>

        <ext:Panel
            runat="server"
            Title="Area Chart"
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
                    Legend="true"
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
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                        <ext:ModelField Name="Data4" />
                                        <ext:ModelField Name="Data5" />
                                        <ext:ModelField Name="Data6" />
                                        <ext:ModelField Name="Data7" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis                             
                            Fields="Data1,Data2,Data3,Data4,Data5,Data6,Data7"
                            Title="Number of Hits"
                            Minimum="0">
                            <GridConfig>
                                <Odd Opacity="1" Fill="#ddd" Stroke="#bbb" StrokeWidth="1" />
                            </GridConfig>
                        </ext:NumericAxis>                            

                        <ext:CategoryAxis 
                            Position="Bottom"
                            Fields="Name"
                            Title="Month of the Year"
                            Grid="true">
                            <Label>
                                <Rotate Degrees="315" />
                            </Label>
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:AreaSeries 
                            Axis="Left"
                            XField="Name"
                            YField="Data1,Data2,Data3,Data4,Data5,Data6,Data7">
                                <Style Opacity="0.93" />
                            </ext:AreaSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>