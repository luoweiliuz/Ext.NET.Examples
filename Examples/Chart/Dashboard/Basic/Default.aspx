<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    public List<object> Data
    {
        get
        {
            var companies = new string[] 
            { 
                "3m Co",
                "Alcoa Inc",
                "Altria Group Inc",
                "American Express Company",
                "American International Group, Inc.",
                "AT&T Inc.",
                "Boeing Co.",
                "Caterpillar Inc.",
                "Citigroup, Inc.",
                "E.I. du Pont de Nemours and Company",
                "Exxon Mobil Corp",
                "General Electric Company",
                "General Motors Corporation",
                "Hewlett-Packard Co.",
                "Honeywell Intl Inc",
                "Intel Corporation",
                "International Business Machines",
                "Johnson & Johnson",
                "JP Morgan & Chase & Co",
                "McDonald\"s Corporation",
                "Merck & Co., Inc.",
                "Microsoft Corporation",
                "Pfizer Inc",
                "The Coca-Cola Company",
                "The Home Depot, Inc.",
                "The Procter & Gamble Company",
                "United Technologies Corporation",
                "Verizon Communications",
                "Wal-Mart Stores, Inc."
            };
            
            var rand = new Random();
            var data = new List<object>(companies.Length);
            
            for (int i = 0; i < companies.Length; i++)
            {
                data.Add(new { 
                    Company = companies[i],
                    Price = rand.Next(10000) / 100d,
                    Revenue = rand.Next(10000) / 100d,
                    Growth = rand.Next(10000) / 100d,
                    Product = rand.Next(10000) / 100d,
                    Market = rand.Next(10000) / 100d,
                });
            }

            return data;
        }
    }

    public List<object> RadarData
    {
        get
        {
            return new List<object> 
            { 
                new { Name = "Price", Data = 100 },
                new { Name = "Revenue %", Data = 100 },
                new { Name = "Growth %", Data = 100 },
                new { Name = "Product %", Data = 100 },
                new { Name = "Market %", Data = 100 }
            };
        }
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Form with embedded Grid</title>
    <link href="../../../../resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var form = false,
            rec = false,
            selectedStoreItem = false;

        var selectItem = function (storeItem) {
            var name = storeItem.get('company'),
                series = App.BarChart1.series.get(0),
                i, items, l;

            series.highlight = true;
            series.unHighlightItem();
            series.cleanHighlights();

            for (i = 0, items = series.items, l = items.length; i < l; i++) {
                if (name == items[i].storeItem.get('company')) {
                    selectedStoreItem = items[i].storeItem;
                    series.highlightItem(items[i]);
                    break;
                }
            }
            series.highlight = false;
        };

        var updateRecord = function (rec) {
            var name,
                series,
                i,
                l,
                items,
                json = [{
                    'Name': 'Price',
                    'Data': rec.get('price')
                }, {
                    'Name': 'Revenue %',
                    'Data': rec.get('revenue')
                }, {
                    'Name': 'Growth %',
                    'Data': rec.get('growth')
                }, {
                    'Name': 'Product %',
                    'Data': rec.get('product')
                }, {
                    'Name': 'Market %',
                    'Data': rec.get('market')
                }];
            App.RadarStore.loadData(json);
            selectItem(rec);
        };

        var afterEdit = function (field, newValue, oldValue) {
            if (rec && form) {
                if (newValue > field.maxValue) {
                    field.setValue(field.maxValue);
                } else {
                    form.updateRecord(rec);
                    updateRecord(rec);
                }
            }
        };

        var onMouseUp = function (item) {
            var series = App.BarChart1.series.get(0),
                index = Ext.Array.indexOf(series.items, item),
                selectionModel = App.CompanyGrid.getSelectionModel();

            selectedStoreItem = item.storeItem;
            selectionModel.select(index);
        };

        var onSelectionChange = function (model, records) {
            var json,
                    name,
                    i,
                    l,
                    items,
                    series,
                    fields;

            if (records[0]) {
                rec = records[0];
                if (!form) {
                    form = this.up('form').getForm();
                    fields = form.getFields();
                    fields.each(function (field) {
                        if (field.name != 'company') {
                            field.setDisabled(false);
                        }
                    });
                } else {
                    fields = form.getFields();
                }

                // prevent change events from firing
                fields.each(function (field) {
                    field.suspendEvents();
                });

                form.loadRecord(rec);
                updateRecord(rec);

                fields.each(function (field) {
                    field.resumeEvents();
                });
            }
        };
    </script>

    <style type="text/css">
        .x-panel-framed {
            padding: 0;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Dynamic Form, Grid and Charts</h1>

        <p>
            Showing companies information in a grid. Selecting a row will highlight
            the bar corresponding to that company and fill in the form with the company
            data. A radar chart will show the company information. You can update the
            information in the form to see it change live in the grid, bar chart and radar charts.
        </p>

        <ext:FormPanel 
            runat="server"
            Title="Company data"
            Frame="true"
            BodyPadding="5"
            Width="870"
            Height="720">            
            <Bin>
                <ext:Store 
                    ID="CompanyStore" 
                    runat="server" 
                    Data="<%# Data %>" 
                    AutoDataBind="true">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" Mapping="Company" />
                                <ext:ModelField Name="price" Mapping="Price" Type="Float" />
                                <ext:ModelField Name="revenue" Mapping="Revenue" Type="Float" />
                                <ext:ModelField Name="growth" Mapping="Growth" Type="Float" />
                                <ext:ModelField Name="product" Mapping="Product" Type="Float" />
                                <ext:ModelField Name="market" Mapping="Market" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Bin>

            <FieldDefaults LabelAlign="Left" MsgTarget="Side" />
            
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />    
            </LayoutConfig>

            <Items>
                <ext:Panel runat="server" Height="200" Layout="FitLayout" MarginSpec="0 0 3 0">
                    <Items>
                        <ext:Chart 
                            ID="BarChart1" 
                            runat="server" 
                            Flex="1" 
                            Shadow="true" 
                            Animate="true" 
                            StoreID="CompanyStore">
                            <Axes>
                                <ext:NumericAxis Position="Left" Fields="price" Minimum="0" Hidden="true" />
                                <ext:CategoryAxis Position="Bottom" Fields="company">
                                    <Label Font="9px Arial">
                                        <Rotate Degrees="270" />
                                        <Renderer Handler="return Ext.String.ellipsis(value, 15, false);" />
                                    </Label>
                                </ext:CategoryAxis>
                            </Axes> 

                            <Series>
                                <ext:ColumnSeries 
                                    Axis="Left" 
                                    Highlight="true" 
                                    XField="name" 
                                    YField="price">
                                    <Style Fill="#456d9f" />
                                    <HighlightConfig Fill="#a2b5ca" />
                                    <Label 
                                        Contrast="true" 
                                        Display="InsideEnd" 
                                        Field="price" 
                                        Color="#000" 
                                        Orientation="Vertical" 
                                        TextAnchor="middle"
                                        />
                                    <Listeners>
                                        <ItemMouseUp Fn="onMouseUp" />
                                    </Listeners>
                                </ext:ColumnSeries>
                            </Series>
                        </ext:Chart>
                    </Items>
                </ext:Panel>

                <ext:Panel 
                    runat="server" 
                    Flex="1" 
                    Border="false" 
                    BodyStyle="background-color: transparent;">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>

                    <Items>
                        <ext:GridPanel 
                            ID="CompanyGrid" 
                            runat="server" 
                            Flex="6" 
                            Title="Company Data" 
                            StoreID="CompanyStore">
                            <ColumnModel>
                                <Columns>
                                    <ext:Column 
                                        ID="Company" 
                                        runat="server" 
                                        Text="Company" 
                                        Flex="1" 
                                        DataIndex="company" 
                                        />
                                    <ext:Column 
                                        runat="server" 
                                        Text="Price" 
                                        Width="75" 
                                        DataIndex="price" 
                                        Align="Right">
                                        <Renderer Format="UsMoney" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Revenue" 
                                        Width="75" 
                                        DataIndex="revenue" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Growth" 
                                        Width="75" 
                                        DataIndex="growth" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Product" 
                                        Width="75" 
                                        DataIndex="product" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                    <ext:Column 
                                        runat="server" 
                                        Text="Market" 
                                        Width="75" 
                                        DataIndex="market" 
                                        Align="Right">
                                        <Renderer Handler="return value + '%';" />
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>

                            <Listeners>
                                <SelectionChange Fn="onSelectionChange" />
                            </Listeners>
                        </ext:GridPanel>

                        <ext:Panel 
                            runat="server" 
                            Flex="4" 
                            Title="Company Details" 
                            MarginSpec="0 0 0 5">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Align="Stretch" />
                            </LayoutConfig>

                            <Items>
                                <ext:FieldSet 
                                    runat="server" 
                                    Margin="5" 
                                    Flex="1" 
                                    Title="Company Details">
                                    <Defaults>
                                        <ext:Parameter Name="Width" Value="240" />
                                        <ext:Parameter Name="LabelWidth" Value="90" />
                                        <ext:Parameter Name="Disabled" Value="true" />
                                    </Defaults>

                                    <Items>
                                        <ext:TextField runat="server" FieldLabel="Name" Name="company" />

                                        <ext:NumberField 
                                            runat="server" 
                                            FieldLabel="Price" 
                                            Name="price" 
                                            MinValue="0" 
                                            MaxValue="100" 
                                            EnforceMaxLength="true" 
                                            MaxLength="5">
                                            <Listeners>
                                                <Change Buffer="200" Fn="afterEdit" />
                                            </Listeners>
                                        </ext:NumberField>

                                        <ext:NumberField 
                                            runat="server" 
                                            FieldLabel="Revenue %" 
                                            Name="revenue" 
                                            MinValue="0" 
                                            MaxValue="100" 
                                            EnforceMaxLength="true" 
                                            MaxLength="5">
                                            <Listeners>
                                                <Change Buffer="200" Fn="afterEdit" />
                                            </Listeners>
                                        </ext:NumberField>

                                        <ext:NumberField 
                                            runat="server" 
                                            FieldLabel="Growth %" 
                                            Name="growth" 
                                            MinValue="0" 
                                            MaxValue="100" 
                                            EnforceMaxLength="true" 
                                            MaxLength="5">
                                            <Listeners>
                                                <Change Buffer="200" Fn="afterEdit" />
                                            </Listeners>
                                        </ext:NumberField>

                                        <ext:NumberField 
                                            runat="server" 
                                            FieldLabel="Product %" 
                                            Name="product" 
                                            MinValue="0" 
                                            MaxValue="100" 
                                            EnforceMaxLength="true" 
                                            MaxLength="5">
                                            <Listeners>
                                                <Change Buffer="200" Fn="afterEdit" />
                                            </Listeners>
                                        </ext:NumberField>

                                        <ext:NumberField 
                                            runat="server" 
                                            FieldLabel="Market %" 
                                            Name="market" 
                                            MinValue="0" 
                                            MaxValue="100" 
                                            EnforceMaxLength="true" 
                                            MaxLength="5">
                                            <Listeners>
                                                <Change Buffer="200" Fn="afterEdit" />
                                            </Listeners>
                                        </ext:NumberField>
                                    </Items>
                                </ext:FieldSet>

                                <ext:Chart 
                                    runat="server" 
                                    Margin="0" 
                                    InsetPadding="20" 
                                    Flex="1" 
                                    Animate="true">
                                    <Store>
                                        <ext:Store 
                                            ID="RadarStore" 
                                            runat="server" 
                                            Data="<%# RadarData %>" 
                                            AutoDataBind="true">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="Name" />
                                                        <ext:ModelField Name="Data" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Axes>
                                        <ext:RadialAxis Steps="5" Maximum="100" />
                                    </Axes>
                                    <Series>
                                        <ext:RadarSeries 
                                            XField="Name" 
                                            YField="Data" 
                                            ShowInLegend="false" 
                                            ShowMarkers="true">
                                            <MarkerConfig Radius="4" Size="4" />
                                            <Style Fill="rgb(194,214,240)" Opacity="0.5" StrokeWidth="0.5" />
                                        </ext:RadarSeries>
                                    </Series>
                                </ext:Chart>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:FormPanel>
    </form>    
</body>
</html>