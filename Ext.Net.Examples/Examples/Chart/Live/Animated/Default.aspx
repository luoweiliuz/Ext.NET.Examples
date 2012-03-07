<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    public class DataItem
    {
        public DateTime Date
        {
            get;
            set;
        }

        public int Visits
        {
            get;
            set;
        }

        public int Views
        {
            get;
            set;
        }

        public int Users
        {
            get;
            set;
        }
    }

    public List<DataItem> List
    {
        get
        {
            if ((!this.IsPostBack && !X.IsAjaxRequest) || (this.Session["LiveAnimatedList"] == null))
            {
                this.Session["LiveAnimatedList"] = new List<DataItem>();
            }

            return (List<DataItem>)this.Session["LiveAnimatedList"];
        }
        set
        {
            this.Session["LiveAnimatedList"] = value;
        }
    }

    public List<DataItem> Data
    {
        get
        {
            var data = this.List;                                
            var random = new Random();

            data.Add(new DataItem
            {
                Date = data.Count > 0 ? data.Last().Date.AddDays(1) : new DateTime(2011, 1, 1),
                Visits = Convert.ToInt32(Math.Min(100, Math.Max(data.Count > 0 ? (data.Last().Visits + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0))),
                Views = Convert.ToInt32(Math.Min(100, Math.Max(data.Count > 0 ? (data.Last().Views + (random.NextDouble() - 0.5) * 10) : random.NextDouble() * 100, 0))),
                Users = Convert.ToInt32(Math.Min(100, Math.Max(data.Count > 0 ? (data.Last().Users + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0)))
            });

            if (data.Count > 10)
            {
                data = data.Skip(Math.Max(0, data.Count() - 10)).Take(10).ToList<DataItem>();
                this.List = data;
            }

            return data;
        }
    }

    protected void GetNewData(object sender, DirectEventArgs e)
    {
        var data = this.Data;
        var timeAxis = (TimeAxis)this.Chart1.Axes[1];

        if (new DateTime(2011, 1, 7) < data.Last().Date)
        {
            this.Chart1.SetMarkerIndex(1);            
            timeAxis.SetToDate(data.Last().Date);
            timeAxis.SetFromDate(DateUnit.Day, 1);
        }

        var store = this.Chart1.GetStore();
        
        store.DataSource = data;
        store.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            var store = this.Chart1.GetStore();
            
            store.DataSource = this.Data;
            store.DataBind();
        }
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Live Updated Chart - Animated - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Live Updated Chart - Animated</h1>
        
        <p>Display 3 sets of random data in a line series.</p>
        
        <p>In this example, random data is added to the store every 2000ms and a 500ms animation will occur to animate the change visually.</p>
        
        <p>The chart will scroll and the bottom axis will update once the line reaches the right side of the chart.</p>

        <ext:Panel 
            runat="server"
            Title="Live Animated Chart"
            Width="800"
            Height="600"
            Layout="FitLayout">            
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    StyleSpec="background:#fff;"                                       
                    Animate="true">                    
                    <Store>
                        <ext:Store runat="server">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="Visits" />
                                        <ext:ModelField Name="Views" />
                                        <ext:ModelField Name="Users" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis                             
                            Fields="Views,Visits,Users"
                            Title="Number of Hits"                            
                            Minimum="0"
                            Maximum="100">
                            <GridConfig>
                                <Odd Opacity="1" Fill="#dedede" Stroke="#ddd" StrokeWidth="0.5" />
                            </GridConfig>
                        </ext:NumericAxis>                            

                        <ext:TimeAxis 
                            Position="Bottom" 
                            Fields="Date" 
                            Title="Day" 
                            DateFormat="MMM dd" 
                            Constrain="true" 
                            FromDate="<%# new DateTime(2011, 1, 1) %>"
                            ToDate="<%# new DateTime(2011, 1, 7) %>"
                            Grid="true" 
                            AutoDataBind="true"/>
                    </Axes>
                    <Series>
                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Visits">
                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                            <MarkerConfig Size="5" Radius="5" />
                        </ext:LineSeries>

                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Views">
                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                            <MarkerConfig Size="5" Radius="5" />
                        </ext:LineSeries>

                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Users">
                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                            <MarkerConfig Size="5" Radius="5" />
                        </ext:LineSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>

        <ext:TaskManager runat="server">
            <Tasks>
                <ext:Task TaskID="DataTask" AutoRun="true" Interval="2000">
                    <DirectEvents>
                        <Update OnEvent="GetNewData" />
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>    
</body>
</html>