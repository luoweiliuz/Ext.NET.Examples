<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    public List<object> Data
    {
        get
        {
            return new List<object> 
            { 
                new {Year = 2005, Comedy = 34000000, Action = 23890000, Drama = 18450000, Thriller = 20060000},
                new {Year = 2006, Comedy = 56703000, Action = 38900000, Drama = 12650000, Thriller = 21000000},
                new {Year = 2007, Comedy = 42100000, Action = 50410000, Drama = 25780000, Thriller = 23040000},
                new {Year = 2008, Comedy = 38910000, Action = 56070000, Drama = 24810000, Thriller = 26940000}
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Stacked Bar Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Stacked Bar Chart Sample</h1>

        <p>Showing movie taking by genre as a stacked bar chart sample. Filter the stacks by clicking on the legend items.</p>

        <ext:Panel 
            runat="server"
            Width="800"
            Height="400"
            Title="Stacked Bar Chart - Movies by Genre"
            Layout="FitLayout">
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    Shadow="true"
                    Animate="true">
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Data %>" 
                            AutoDataBind="true">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Year" />
                                        <ext:ModelField Name="Comedy" />
                                        <ext:ModelField Name="Action" />
                                        <ext:ModelField Name="Drama" />
                                        <ext:ModelField Name="Thriller" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <LegendConfig Position="Right" />

                    <Axes>
                        <ext:NumericAxis                             
                            Fields="Comedy,Action,Drama,Thriller"
                            Position="Bottom"
                            Grid="true"
                            RoundToDecimal="false">
                            <Label>
                                <Renderer Handler="return String(value).replace(/000000$/, 'M');" />
                            </Label>
                        </ext:NumericAxis>                            

                        <ext:CategoryAxis Fields="Year" />                            
                    </Axes>

                    <Series>
                        <ext:BarSeries 
                            Axis="Bottom"
                            Gutter="80"
                            XField="Year" 
                            YField="Comedy,Action,Drama,Thriller"
                            Stacked="true">
                            <Tips TrackMouse="true" Width="65" Height="28">
                                <Renderer Handler="this.setTitle(String(item.value[1] / 1000000) + 'M');" />
                            </Tips>
                        </ext:BarSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>