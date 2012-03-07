<%@ Page Language="C#" ValidateRequest="false" %>

<%@ Import Namespace="Ext.Net.Utilities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    [DirectMethod]
    public void UpdateData()
    {
        string pattern = this.BuildRegexPattern();

        this.txtPattern.Text = pattern;
        
        MatchCollection matches;
        
        try
        {
            matches = Regex.Matches(this.TextArea1.Text, pattern, RegexOptions.IgnoreCase);
        }
        catch
        {
            return;
        }
        
        var words = new List<WordItem>();
        
        var word = "";

        foreach (Match match in matches)
        {
            word = this.chkIgnoreCase.Checked ? match.Value.Trim().ToLower() : match.Value.Trim();

            if (word.IsEmpty())
            {
                continue;
            }

            if (words.Contains(new WordItem { Word = word }))
            {
                words.Find(item => item.Word == word).Increment(); 
            }
            else
            {
                words.Add(new WordItem { Word = word, Count = 1 }); 
            }
        }

        // Order the List Alphabetically
        var sortedByAlpha = words.OrderBy(item => item.Word);
        
        // Order the List by Word Count
        var sortedByCount = sortedByAlpha.OrderByDescending(item => item.Count);

        var max = Convert.ToInt32(this.intRecordLimit.Number);

        this.Store1.Data = sortedByCount.Take(max > 0 ? max : 99);
        this.Store1.DataBind();
    }

    private string BuildRegexPattern()
    {
        string pattern = @"\b{0}{1}{2}{3}{4}{5}{6}\b"; // @"\b(?!and|not)(?![0-9])[a-z0-9]{3,}\b";

        var exclusionWords = Regex.Matches(this.txtExclusionWords.Text.Trim(), @"\b[a-zA-Z0-9]+\b").Join("|");

        int maxMinTotalLength = this.txtPrefixPattern.Text.Trim().Length + this.txtSuffixPattern.Text.Length;
        
        string exclusionWordsPattern = exclusionWords.Length > 0 ? "(?!" + exclusionWords + ")" : ""; //0
        string allowIntegersPrefixPattern = chkAllowIntegerPrefix.Checked ? "" : @"(?![0-9])"; //1
        string prefixPattern = string.Format("{0}", this.txtPrefixPattern.Text.Length > 0 ? "(" + this.txtPrefixPattern.Text + ")" : ""); //2
        string alphaCharPattern = @"[" + this.txtWordPattern.Text; //3
        string allowIntegersPattern = this.chkAllowIntegers.Checked ? "0-9]" : "]"; //4
        string maxMinWordLengthPattern = string.Format("{{{0},{1}}}", this.intMinWordLength.Number - maxMinTotalLength, intMaxWordLength.Number - maxMinTotalLength); //5
        string suffixPattern = string.Format("{0}", this.txtSuffixPattern.Text.Length > 0 ? "(" + this.txtSuffixPattern.Text + ")" : ""); //6

        return string.Format(pattern, exclusionWordsPattern, allowIntegersPrefixPattern, prefixPattern, alphaCharPattern, allowIntegersPattern, maxMinWordLengthPattern, suffixPattern);
    }

    public class WordItem : IEquatable<WordItem>
    {
        public string Word { get; set; }

        private int count = 0;
        
        public int Count
        {
            get
            {
                return this.count;
            }
            set
            {
                this.count = value;
            }
        }

        public void Increment()
        {
            this.Count++;
        }

        public bool Equals(WordItem other)
        {
            return this.Word == other.Word;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Word Wrench - Ext.NET Examples</title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <Listeners>
                <DocumentReady Handler="
                    var fields = Ext.ComponentQuery.query('field[autoUpdateData=true], button[autoUpdateData=true]');

                    for(var i = 0; i < fields.length; i++) {
                        fields[i].on('change', function (item) {
                            App.direct.UpdateData();
                        }, fields[i], { buffer : 500 });
                    }" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:FormPanel runat="server" Region="Center" Layout="HBoxLayout">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Panel 
                            runat="server" 
                            Title="Word Wrench"
                            Icon="Wrench" 
                            Margins="5 5 5 5" 
                            Flex="2"
                            Layout="FitLayout"
                            BodyBorder="0">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button runat="server" Text="Clear" Icon="ArrowUndo">
                                            <Listeners>
                                                <Click Handler="App.TextArea1.clear()" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:TextArea 
                                    ID="TextArea1" 
                                    runat="server"
                                    Margins="0 0 -5 0"
                                    EmptyText="[Paste Text Here] and Word Wrench will find words."
                                    AutoUpdateData="true"
                                    />
                            </Items>
                        </ext:Panel>
                        <ext:FormPanel
                            ID="frmSettings"
                            runat="server" 
                            Title="Settings" 
                            Flex="1"
                            Icon="Cog" 
                            Split="true" 
                            BodyPadding="5"
                            Margins="5 5 5 0"
                            DefaultAnchor="100%"
                            Layout="VBoxLayout">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Align="Stretch" />
                            </LayoutConfig>
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ToolbarFill runat="server" />
                                        <ext:Button 
                                            ID="btnForm"
                                            runat="server" 
                                            Text="Reset" 
                                            Icon="ArrowRedo" 
                                            OnClientClick="App.btnForm.up('form').reset();"
                                            />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:Container runat="server" Flex="2" Layout="HBoxLayout">
                                    <LayoutConfig>
                                        <ext:HBoxLayoutConfig Align="Stretch" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Container 
                                            runat="server" 
                                            Flex="1" 
                                            Layout="AnchorLayout" 
                                            DefaultAnchor="100%">
                                            <Items>
                                                <ext:TextField
                                                    ID="txtWordPattern" 
                                                    runat="server"
                                                    FieldLabel="Word Pattern"
                                                    Text="a-zA-Z"
                                                    AllowBlank="false"
                                                    AutoUpdateData="true"
                                                    />
                                                <ext:NumberField 
                                                    ID="intRecordLimit" 
                                                    runat="server" 
                                                    FieldLabel="Unique Words" 
                                                    Number="20" 
                                                    MinValue="1" 
                                                    MaxValue="99" 
                                                    AllowDecimals="false"
                                                    AutoUpdateData="true"
                                                    />
                                                <ext:FieldContainer 
                                                    runat="server" 
                                                    FieldLabel="Word Length"
                                                    Layout="HBoxLayout">
                                                    <LayoutConfig>
                                                        <ext:HBoxLayoutConfig DefaultMargins="0 5 0 0" />
                                                    </LayoutConfig>
                                                    <Items>
                                                        <ext:NumberField 
                                                            ID="intMinWordLength" 
                                                            runat="server" 
                                                            HideLabel="true"
                                                            Flex="1" 
                                                            Number="3" 
                                                            MinValue="1" 
                                                            MaxValue="99"
                                                            AllowDecimals="false"
                                                            AllowBlank="false"
                                                            AutoUpdateData="true"
                                                            />
                                                        <ext:DisplayField runat="server" Text="Min" Flex="1" />
                                                        <ext:NumberField 
                                                            ID="intMaxWordLength" 
                                                            runat="server" 
                                                            HideLabel="true"
                                                            Flex="1"
                                                            Number="20" 
                                                            MinValue="1" 
                                                            MaxValue="99" 
                                                            AllowDecimals="false"
                                                            AllowBlank="false"
                                                            AutoUpdateData="true"
                                                            />
                                                        <ext:DisplayField runat="server" Text="Max" Flex="1" />
                                                    </Items>
                                                </ext:FieldContainer>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container 
                                            runat="server" 
                                            Flex="1" 
                                            Layout="AnchorLayout" 
                                            DefaultAnchor="100%" 
                                            Margins="0 0 0 12" 
                                            DefaultLabelAlign="right">
                                            <Items>
                                                <ext:TextField 
                                                    ID="txtPrefixPattern" 
                                                    runat="server" 
                                                    FieldLabel="Prefix" 
                                                    AutoUpdateData="true" 
                                                    />
                                                <ext:TextField 
                                                    ID="txtSuffixPattern" 
                                                    runat="server" 
                                                    FieldLabel="Suffix" 
                                                    AutoUpdateData="true" 
                                                    />
                                                <ext:Checkbox 
                                                    ID="chkAllowIntegerPrefix" 
                                                    runat="server" 
                                                    FieldLabel=" " 
                                                    LabelSeparator="" 
                                                    BoxLabel="Allow Integer Prefix"
                                                    AutoUpdateData="true"
                                                    />
                                                <ext:Checkbox 
                                                    ID="chkAllowIntegers" 
                                                    runat="server" 
                                                    Checked="true" 
                                                    FieldLabel=" " 
                                                    LabelSeparator="" 
                                                    BoxLabel="Allow Integers"
                                                    AutoUpdateData="true"
                                                    />
                                                <ext:Checkbox 
                                                    ID="chkIgnoreCase" 
                                                    runat="server" 
                                                    Checked="true" 
                                                    FieldLabel=" " 
                                                    LabelSeparator="" 
                                                    BoxLabel="Ignore Case"
                                                    AutoUpdateData="true"
                                                    />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                                <ext:TextArea 
                                    ID="txtExclusionWords" 
                                    runat="server"
                                    Flex="1"
                                    FieldLabel="Exclusion Words" 
                                    LabelAlign="Top" 
                                    Text="and the"
                                    AutoUpdateData="true"
                                    />
                                <ext:TextArea
                                    ID="txtPattern"
                                    runat="server"
                                    Flex="1"
                                    FieldLabel="Regex Pattern (Auto Generated)"
                                    LabelAlign="Top" 
                                    ReadOnly="true"
                                    />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:FormPanel>
                <ext:Container 
                    ID="Container1" 
                    runat="server" 
                    Region="South" 
                    Split="true" 
                    Height="350"
                    Layout="HBoxLayout">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch"/>
                    </LayoutConfig>
                    <Bin>
                        <ext:Store ID="Store1" runat="server" AutoLoad="true" SortOnLoad="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Word" />
                                        <ext:ModelField Name="Count" Type="Int" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Sorters>
                                <ext:DataSorter Property="Count" Direction="DESC" />
                            </Sorters>
                            <Listeners>
                                <DataChanged Handler="App.GridPanel1.setTitle('Words (' + this.getCount() + ' unique)');" />
                            </Listeners>
                        </ext:Store>
                    </Bin>
                    <Items>
                        <ext:Chart 
                            ID="Chart1" 
                            runat="server"
                            Shadow="true"
                            Animate="true"
                            Flex="6"
                            StoreID="Store1">
                            <Axes>
                                <ext:NumericAxis
                                    Fields="Count"
                                    Grid="true"
                                    Title="Count"
                                    Minimum="0"
                                    MajorTickSteps="1"
                                    />
                                <ext:CategoryAxis 
                                    Position="Bottom"
                                    Fields="Word">
                                    <Label>
                                        <Rotate Degrees="315" />
                                    </Label>
                                </ext:CategoryAxis>
                            </Axes>
                            <Series>
                                <ext:ColumnSeries
                                    Axis="Left"
                                    Highlight="true" 
                                    XField="Word"  
                                    YField="Count">
                                    <Tips 
                                        runat="server" 
                                        TrackMouse="true" 
                                        Width="140" 
                                        Height="28">
                                        <Renderer Handler="this.setTitle(storeItem.get('Word') + ' (' + storeItem.get('Count') + ')');" />
                                    </Tips>
                                    <Label
                                        Display="InsideEnd" 
                                        Field="Count" 
                                        Orientation="Horizontal" 
                                        Color="#333" 
                                        TextAnchor="middle"
                                        />
                                </ext:ColumnSeries>
                            </Series>
                        </ext:Chart>
                        <ext:GridPanel 
                            ID="GridPanel1" 
                            runat="server" 
                            Title="Words" 
                            Flex="2" 
                            Margins="0 5 5 5"
                            StoreID="Store1">
                            <ColumnModel>
                                <Columns>
                                    <ext:Column runat="server" Text="Word" DataIndex="Word" Flex="1" />
                                    <ext:Column runat="server" Text="Count" DataIndex="Count" />
                                </Columns>            
                            </ColumnModel>
                        </ext:GridPanel>
                        <ext:Panel 
                            runat="server" 
                            Title="Raw Data" 
                            Layout="FitLayout" 
                            BodyPadding="5"
                            Margins="0 0 5 0"
                            Flex="1">
                            <TopBar>
                                 <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Checkbox 
                                            ID="Checkbox1" 
                                            runat="server" 
                                            BoxLabel="Include Count" 
                                            Checked="true" 
                                            Height="18">
                                            <Listeners>
                                                <Change Handler="App.DataView1.refresh();" />
                                            </Listeners>
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:DataView 
                                    ID="DataView1" 
                                    runat="server" 
                                    StoreID="Store1"
                                    AutoScroll="true" 
                                    Flex="1"
                                    ItemSelector="div"
                                    Margins="5">
                                    <Tpl runat="server">
                                        <Html>
							                <tpl for=".">
                                                <tpl if="App.Checkbox1.getValue()">
                                                    <div>{Word} ({Count})</div>
                                                </tpl>
                                                <tpl if="!App.Checkbox1.getValue()">
                                                    <div>{Word}</div>
                                                </tpl>

							                </tpl>
						                </Html>
                                    </Tpl>    
                                </ext:DataView>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>