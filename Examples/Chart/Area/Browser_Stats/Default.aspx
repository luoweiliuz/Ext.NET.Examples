<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    public string[] COLORS = new string[]{"rgb(47, 162, 223)", "rgb(60, 133, 46)", "rgb(234, 102, 17)", "rgb(154, 176, 213)", "rgb(186, 10, 25)", "rgb(40, 40, 40)"};
    
    protected void Page_Load(object sender, EventArgs e)
    {
        var data = new List<object> 
        { 
            new { Date = new DateTime(2009, 1, 1),  IE = 44.8, Firefox = 45.5, Chrome = 3.9,  Safari = 3,   Opera = 2.3, Other = 0.5 },
            new { Date = new DateTime(2009, 2, 1),  IE = 43.6, Firefox = 46.4, Chrome = 4,    Safari = 3,   Opera = 2.2, Other = 0.8 },
            new { Date = new DateTime(2009, 3, 1),  IE = 43.3, Firefox = 46.5, Chrome = 4.2,  Safari = 3.1, Opera = 2.3, Other = 0.6 },
            new { Date = new DateTime(2009, 4, 1),  IE = 42.1, Firefox = 47.1, Chrome = 4.9,  Safari = 3,   Opera = 2.2, Other = 0.7 },
            new { Date = new DateTime(2009, 5, 1),  IE = 41,   Firefox = 47.7, Chrome = 5.5,  Safari = 3,   Opera = 2.2, Other = 0.6 },
            new { Date = new DateTime(2009, 6, 1),  IE = 40.7, Firefox = 47.3, Chrome = 6,    Safari = 3.1, Opera = 2.1, Other = 0.8 },
            new { Date = new DateTime(2009, 7, 1),  IE = 39.4, Firefox = 47.9, Chrome = 6.5,  Safari = 3.3, Opera = 2.1, Other = 0.8 },
            new { Date = new DateTime(2009, 8, 1),  IE = 39.3, Firefox = 47.4, Chrome = 7,    Safari = 3.3, Opera = 2.1, Other = 0.9 },
            new { Date = new DateTime(2009, 9, 1),  IE = 39.6, Firefox = 46.6, Chrome = 7.1,  Safari = 3.6, Opera = 2.2, Other = 0.9 },
            new { Date = new DateTime(2009, 10, 1), IE = 37.5, Firefox = 47.5, Chrome = 8,    Safari = 3.8, Opera = 2.3, Other = 0.9 },
            new { Date = new DateTime(2009, 11, 1), IE = 37.7, Firefox = 47,   Chrome = 8.5,  Safari = 3.8, Opera = 2.3, Other = 0.7 },
            new { Date = new DateTime(2009, 12, 1), IE = 37.2, Firefox = 46.4, Chrome = 9.8,  Safari = 3.6, Opera = 2.3, Other = 0.7 },                
            new { Date = new DateTime(2010, 1, 1),  IE = 36.2, Firefox = 46.3, Chrome = 10.8, Safari = 3.7, Opera = 2.2, Other = 0.8 },
            new { Date = new DateTime(2010, 2, 1),  IE = 35.3, Firefox = 46.5, Chrome = 11.6, Safari = 3.8, Opera = 2.1, Other = 0.7 },
            new { Date = new DateTime(2010, 3, 1),  IE = 34.9, Firefox = 46.2, Chrome = 12.3, Safari = 3.7, Opera = 2.2, Other = 0.7 },
            new { Date = new DateTime(2010, 4, 1),  IE = 33.4, Firefox = 46.4, Chrome = 13.6, Safari = 3.7, Opera = 2.2, Other = 0.7 },
            new { Date = new DateTime(2010, 5, 1),  IE = 32.2, Firefox = 46.9, Chrome = 14.5, Safari = 3.5, Opera = 2.2, Other = 0.7 },
            new { Date = new DateTime(2010, 6, 1),  IE = 31,   Firefox = 46.6, Chrome = 15.9, Safari = 3.6, Opera = 2.1, Other = 0.8 },
            new { Date = new DateTime(2010, 7, 1),  IE = 30.4, Firefox = 46.4, Chrome = 16.7, Safari = 3.4, Opera = 2.3, Other = 0.8 },
            new { Date = new DateTime(2010, 8, 1),  IE = 30.7, Firefox = 45.8, Chrome = 17,   Safari = 3.5, Opera = 2.3, Other = 0.7 },
            new { Date = new DateTime(2010, 9, 1),  IE = 31.1, Firefox = 45.1, Chrome = 17.3, Safari = 3.7, Opera = 2.2, Other = 0.6 },
            new { Date = new DateTime(2010, 10, 1), IE = 29.7, Firefox = 44.1, Chrome = 19.2, Safari = 3.9, Opera = 2.2, Other = 0.9 },
            new { Date = new DateTime(2010, 11, 1), IE = 28.6, Firefox = 44,   Chrome = 20.5, Safari = 4.0, Opera = 2.3, Other = 0.6 },
            new { Date = new DateTime(2010, 12, 1), IE = 27.5, Firefox = 43.5, Chrome = 22.4, Safari = 3.8, Opera = 2.2, Other = 0.6 }
        };

        var store = this.Chart1.GetStore();
        
        store.DataSource = data;
        store.DataBind();
    }
</script> 

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Area BrowserStats - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />   
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Area - BrowserStats</h1>

        <p>Display browser usage trends in an area series.</p>
        
        <p>This chart uses custom gradients for the colors and the legend is interactive.</p>
        
        <p>Click or hover on the legend items to highlight and remove them from the chart</p>

        <ext:ChartTheme 
            runat="server" 
            ThemeName="Browser" 
            Colors="<%# COLORS %>"
            AutoDataBind="true"
            />            

        <ext:Panel 
            runat="server"
            Title="What is the trend in Browser Usage?"
            Width="800"
            Height="600"
            Layout="FitLayout">           
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    StyleSpec="background:#fff;"                   
                    Theme="Browser:gradients"                    
                    Animate="true">
                    <LegendConfig Position="Right" />
                    <Store>
                        <ext:Store runat="server">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="IE" />
                                        <ext:ModelField Name="Chrome" />
                                        <ext:ModelField Name="Firefox" />
                                        <ext:ModelField Name="Safari" />
                                        <ext:ModelField Name="Opera" />
                                        <ext:ModelField Name="Other" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis                             
                            Fields="IE,Chrome,Firefox,Safari,Opera,Other"
                            Title="Usage %"
                            Grid="true"
                            Decimals="0"
                            Minimum="0"
                            Maximum="100"
                            />
                        <ext:CategoryAxis 
                            Position="Bottom"
                            Fields="Date"
                            Title="Month of the Year"
                            Grid="true">
                            <Label>
                                <Renderer Handler="return Ext.Date.format(value, 'M d');" />
                            </Label>
                        </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:AreaSeries 
                            Axis="Left"
                            Highlight="true"
                            YField="IE,Chrome,Firefox,Safari,Opera,Other">
                                <Style Opacity="0.86" StrokeWidth="1" Stroke="#666"  />
                                <Tips TrackMouse="true" Width="170" Height="28">                                   
                                    <Renderer Handler="this.setTitle(item.storeField + ' - ' + Ext.Date.format(new Date(storeItem.get('Date')), 'M y') + ' - ' + storeItem.get(item.storeField) + '%');" />
                                </Tips>
                            </ext:AreaSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>