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
    <title>Reload Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Reload Column Chart Sample</h1>

        <p>Displaying a Column Chart Sample that animates when refreshing the data set.</p>

        <ext:Panel 
            runat="server"
            Width="800"
            Height="400"
            Title="Column Chart with Reload - Hits per Month"
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
                    Shadow="true"                    
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
                            Grid="true"
                            Title="Hits"
                            Minimum="0"
                            Maximum="100"
                            />

                        <ext:CategoryAxis 
                            Position="Bottom"
                            Fields="Name"
                            Title="Months">
                            <Label>
                                <Rotate Degrees="270" />
                            </Label>
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:ColumnSeries 
                            Axis="Left"
                            Gutter="80"                            
                            XField="Name" 
                            YField="Data1">
                            <Tips TrackMouse="true" Width="74" Height="38">
                                <Renderer Handler="this.setTitle(storeItem.get('Name') + '<br />' + storeItem.get('Data1'));" />
                            </Tips>
                            <Style Fill="#38B8BF" />
                        </ext:ColumnSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>