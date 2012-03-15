<%@ Control Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    public static string[] MemoryColors = new string[]{ "rgb(244, 16, 0)", "rgb(248, 130, 1)", "rgb(0, 7, 255)", "rgb(84, 254, 0)" };

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.LastCore1 = 0;
            this.LastCore2 = 0;
            this.Pass = 99;
            this.UpdateCharts();
        }
    }

    protected void UpdateTask(object sender, DirectEventArgs e)
    {
        this.UpdateCharts();
    }

    private object GenerateData(string[] names)
    {
        var data = new List<object>();
        double rest = names.Length;
        var random = new Random();
        
        for (int i = 0; i < names.Length; i++)
        {
            var consume = Math.Floor(random.NextDouble() * rest * 100) / 100 + 2;
            rest = rest - (consume - 5);
            data.Add(new 
            { 
                Name = names[i],
                Memory = consume
            });
        }

        return data;
    }

    public int Pass
    {
        get
        {
            var obj = this.Session["pass"];
            return obj != null ? (int)obj : 99;
        }
        set
        {
            this.Session["pass"] = value;
        }
    }

    private double GenerateCPUValue(double factor, Random random)
    {
        var value = factor + ((Math.Floor(random.NextDouble() * 2) % 2) > 0 ? -1 : 1) * Math.Floor(random.NextDouble() * 9);

        if (value < 0 || value > 100)
        {
            value = 50;
        }

        return value;
    }

    private double LastCore1
    {
        get
        {
            var obj = this.Session["core1"];
            return obj != null ? (double)obj : 0d;
        }
        set
        {
            this.Session["core1"] = value;
        }
    }

    private double LastCore2
    {
        get
        {
            var obj = this.Session["core2"];
            return obj != null ? (double)obj : 0d;
        }
        set
        {
            this.Session["core2"] = value;
        }
    }

    private void GenerateCPULoad()
    {
        var core1 = this.LastCore1;
        var core2 = this.LastCore2;
        var pass = this.Pass;
        var random = new Random();
        
        if (X.IsAjaxRequest)
        {
            CPULoadStore.RemoveAt(0);

            CPULoadStore.Each(new JFunction 
            {  
                Args = new string[]{"item", "key"},
                Handler = "item.data.Time = key;" // update time
            });
            
            core1 = this.GenerateCPUValue(core1, random);
            core2 = this.GenerateCPUValue(core2, random);

            CPULoadStore.LoadData(new []{new { Core1 = core1, Core2 = core2, Time = pass }}, true);            
        }
        else
        {
            var data = new List<object>();
            data.Add(new { Core1 = 0, Core2 = 0, Time = 0 });            
            
            for (var i = 1; i < 100; i++) {
                core1 = this.GenerateCPUValue(core1, random);
                core2 = this.GenerateCPUValue(core2, random);
                
                data.Add(new 
                {
                    Core1 = core1,
                    Core2 = core2,
                    Time = i
                });
            }

            CPULoadStore.DataSource = data;
            CPULoadStore.DataBind();            
            this.Pass = 99;
        }

        this.LastCore1 = core1;
        this.LastCore2 = core2;
    }
    
    private void UpdateCharts()
    {
        var pass = this.Pass;
        
        if (pass % 3 == 0 || !X.IsAjaxRequest)
        {
            MemoryStore.DataSource = this.GenerateData(new string[]{"Wired", "Active", "Inactive", "Free"});
            MemoryStore.DataBind();
            if (X.IsAjaxRequest)
            {
                MemoryChart.Call("refresh");
            }
        }

        if (pass % 2 == 0 || !X.IsAjaxRequest)
        {
           ProcessStore.DataSource = this.GenerateData(new string[] { "Explorer", "Monitor", "Charts", "Desktop", "Ext3", "Ext4" });
           ProcessStore.DataBind();
        }

        this.GenerateCPULoad();
        
        this.Pass++;
    }
</script>

<script type="text/javascript">
    var processRenderer = function(sprite, record, attr, index, store) {
        var lowColor = Ext.draw.Color.fromString('#b1da5a'),
            value = record.get('Memory'),
            color;

        if (value > 5) {
            color = lowColor.getDarker((value - 5) / 15).toString();
        } else {
            color = lowColor.getLighter(((5 - value) / 20)).toString();
        }

        if (value >= 8) {
            color = '#CD0000';
        }

        return Ext.apply(attr, {
            fill: color
        });
    };
</script>

<ext:DesktopModuleProxy runat="server">
    <Module ModuleID="systemstatus">
        <Shortcut Name="System Status" IconCls="x-status-shortcut" SortIndex="2" />
        <Window>
            <ext:Window ID="SystemStatusWnd" runat="server"
                Width="800" 
                Height="600"                 
                AnimCollapse="false"
                ConstrainHeader="true"         
                Border="false"      
                CloseAction="Destroy" 
                Layout="Fit"
                Title="System Status">               
                <Bin>                    
                    <ext:Store ID="CPULoadStore" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Core1" />
                                    <ext:ModelField Name="Core2" />
                                    <ext:ModelField Name="Time" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>

                    <ext:Store ID="MemoryStore" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Name" />
                                    <ext:ModelField Name="Memory" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>

                    <ext:Store ID="ProcessStore" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Name" />
                                    <ext:ModelField Name="Memory" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>

                    <ext:TaskManager ID="TaskManager1" runat="server">
                        <Tasks>
                            <ext:Task TaskID="updateCharts" WaitPreviousRequest="true" AutoRun="false" Interval="2000">
                                <DirectEvents>
                                    <Update OnEvent="UpdateTask" />
                                </DirectEvents>
                            </ext:Task>
                        </Tasks>
                    </ext:TaskManager>

                    <ext:ChartTheme runat="server" ThemeName="Memory" 
                        Colors="<%# MemoryColors %>"
                        AutoDataBind="true" />
                </Bin>
                <Items>
                    <ext:Panel runat="server">
                        <LayoutConfig>
                            <ext:HBoxLayoutConfig Align="Stretch" />
                        </LayoutConfig>
                        <Items>
                            <ext:Container runat="server" 
                                Flex="1">
                                <LayoutConfig>
                                    <ext:VBoxLayoutConfig Align="Stretch" />
                                </LayoutConfig>
                                <Items>
                                    <ext:Chart ID="CPUChart1" runat="server"
                                        Flex="1"
                                        StandardTheme="Category1"
                                        Animate="false" 
                                        Legend="true"
                                        StoreID="CPULoadStore">
                                        <Axes>
                                            <ext:NumericAxis 
                                                Position="Left"
                                                Minimum="0"
                                                Maximum="100"
                                                Fields="Core1"
                                                Title="CPU Load"
                                                Grid="true">
                                                <LabelTitle Font="13px Arial" />
                                                <Label Font="11px Arial" />
                                            </ext:NumericAxis>
                                        </Axes>
                                        <Series>
                                            <ext:LineSeries
                                                Title="Core 1 (3.4GHz)"
                                                ShowMarkers="false"
                                                Fill="true"
                                                Axis="Left"
                                                XField="Time"
                                                YField="Core1">
                                                <Style StrokeWidth="1" />
                                            </ext:LineSeries>
                                        </Series>
                                    </ext:Chart>

                                    <ext:Chart  ID="CPUChart2" runat="server"
                                        Flex="1"
                                        StandardTheme="Category2"
                                        Animate="false"
                                        Legend="true"
                                        StoreID="CPULoadStore">
                                        <Axes>
                                            <ext:NumericAxis 
                                                Position="Left"
                                                Minimum="0"
                                                Maximum="100"
                                                Fields="Core2"
                                                Title="CPU Load"
                                                Grid="true">
                                                <LabelTitle Font="13px Arial" />
                                                <Label Font="11px Arial" />
                                            </ext:NumericAxis>
                                        </Axes>
                                        <Series>
                                            <ext:LineSeries
                                                Title="Core 2 (3.4GHz)"
                                                ShowMarkers="false"
                                                Fill="true"
                                                Axis="Left"
                                                XField="Time"
                                                YField="Core2">
                                                <Style StrokeWidth="1" />
                                            </ext:LineSeries>
                                        </Series>
                                    </ext:Chart>
                                </Items>
                            </ext:Container>

                            <ext:Container runat="server" 
                                Flex="1">
                                <LayoutConfig>
                                    <ext:VBoxLayoutConfig Align="Stretch" />
                                </LayoutConfig>
                                <Items>
                                    <ext:Chart ID="MemoryChart" runat="server"
                                        Flex="1"
                                        StoreID="MemoryStore"
                                        InsetPadding="40"
                                        Shadow="true"
                                        Animate="true"
                                        Theme="Memory:gradients">                                        
                                        <LegendConfig Position="Right" />
                                        <Series>
                                            <ext:PieSeries
                                                Donut="30"
                                                AngleField="Memory"
                                                ShowInLegend="true"
                                                Highlight="true"
                                                HighlightSegmentMargin="20">
                                                <Tips 
                                                    TrackMouse="true"
                                                    Width="140"
                                                    Height="28">
                                                    <Renderer Handler="this.setTitle(storeItem.get('Name') + ': ' + Math.round(storeItem.get('Memory') / #{MemoryStore}.sum('Memory') * 100) + '%');" />
                                                </Tips>                    
                                                <Label Field="Name" Display="Rotate" Contrast="true" Font="12px Arial" />
                                            </ext:PieSeries>
                                        </Series>
                                    </ext:Chart>

                                    <ext:Chart runat="server"
                                        Flex="1"
                                        StandardTheme="Category1"
                                        StoreID="ProcessStore">
                                        <AnimateConfig Easing="EaseInOut" Duration="750" />
                                        <Axes>
                                            <ext:NumericAxis
                                                Position="Left"
                                                Minimum="0"
                                                Maximum="10"
                                                Fields="Memory"
                                                Title="Memory">
                                                <LabelTitle Font="13px Arial" />
                                                <Label Font="11px Arial" />
                                            </ext:NumericAxis>

                                            <ext:CategoryAxis
                                                Position="Bottom"
                                                Fields="Name"
                                                Title="System Processes">
                                                <LabelTitle Font="bold 14px Arial" />
                                                <Label>
                                                    <Rotate Degrees="45" />
                                                </Label>
                                            </ext:CategoryAxis>
                                        </Axes>

                                        <Series>
                                            <ext:ColumnSeries
                                                Title="Processes"
                                                XField="Name"
                                                YField="Memory">
                                                <Renderer Fn="processRenderer" />
                                                <Style StrokeWidth="1" />
                                            </ext:ColumnSeries>
                                        </Series>
                                    </ext:Chart>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:Panel>
                </Items>   
                <Listeners>
                    <AfterRender Handler="#{TaskManager1}.startTask('updateCharts');" />
                </Listeners>             
            </ext:Window>
        </Window>
    </Module>
</ext:DesktopModuleProxy>