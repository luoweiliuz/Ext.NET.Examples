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
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>
        
        <p>Display a sets of random data in a column series. Reload data will randomly generate a new set of data in the store.</p>

        <ext:Panel 
            runat="server"
            Title="Column Chart"
            Width="800"
            Height="600"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Reload Data" Icon="ArrowRefresh" OnDirectClick="ReloadData" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    Shadow="true"
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
                            Grid="true"
                            Title="Number of Hits"
                            Minimum="0">
                            <Label>
                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                            </Label>
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
                            <Tips runat="server" TrackMouse="true" Width="140" Height="28">
                                <Renderer Handler="this.setTitle(storeItem.get('Name') + ': ' + storeItem.get('Data1'));" />
                            </Tips>
                            <Label
                                Display="InsideEnd" 
                                Field="Data1" 
                                Orientation="Horizontal" 
                                Color="#333" 
                                TextAnchor="middle" >
                                <Renderer Handler="return Ext.util.Format.number(value, '0');" />
                            </Label>
                        </ext:ColumnSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>