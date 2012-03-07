<%@ Page Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities"%>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Ext.Net.Examples" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.ResourceManager1.DirectEventUrl = this.Request.Url.AbsoluteUri;
            
            // Reset the Session Theme on Page_Load.
            // The Theme switcher will persist the current theme only 
            // until the main Page is refreshed.
            this.Session["Ext.Net.Theme"] = Ext.Net.Theme.Gray;

            this.TriggerField1.Focus();
        }
    }

    protected void GetExamplesNodes(object sender, NodeLoadEventArgs e)
    {
        if (e.NodeID == "Root")
        {
            var nodes = this.Page.Cache["ExamplesTreeNodes"] as Ext.Net.NodeCollection;

            if (nodes == null)
            {
                nodes = UIHelpers.BuildTreeNodes(false);
                this.Page.Cache.Add("ExamplesTreeNodes", nodes, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration, CacheItemPriority.Default, null);
            }

            e.Nodes = nodes;
        }
    }

    [DirectMethod]
    public string GetThemeUrl(string theme)
    {
        Theme temp = (Theme)Enum.Parse(typeof(Theme), theme);

        this.Session["Ext.Net.Theme"] = temp;

        return temp == Ext.Net.Theme.Default ? "Default" : this.ResourceManager1.GetThemeUrl(temp);
    }
    
    [DirectMethod]
    public static int GetHashCode(string s)
    {
        return Math.Abs("/Examples".ConcatWith(s).ToLower().GetHashCode());
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Examples - Open Source ASP.NET Web Controls with Sencha Ext JS</title>

    <link rel="stylesheet" type="text/css" href="resources/css/main.css" />
    <script type="text/javascript" src="resources/js/main.js"></script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" InitScriptMode="Linked" />
    
    <ext:History runat="server">
        <Listeners>
            <Change Fn="change" />
        </Listeners>
    </ext:History>
    
    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel 
                runat="server" 
                Header="false"
                Region="North"
                Border="false"
                Height="69">
                <Content>
                    <div id="titlebar">
	                    <div id="left">
		                    <div class="minor">Ext.NET</div>		                    <div class="title">Examples Explorer <span class="title-sub">(Version 2.0 Beta)</span></div>
		                    <div class="badge">built with Ext.NET</div>
	                    </div>
	                    <div id="right"><a href="http://www.ext.net/"></a></div>
                    </div>
                </Content>    
            </ext:Panel>
            <ext:Panel 
                runat="server"
                Region="West" 
                Layout="Fit" 
                Width="240" 
                Header="false"
                Collapsible="true" 
                Split="true" 
                CollapseMode="Mini" 
                Margins="0 0 4 4"
                Border="false">
                <Items>
                    <ext:TreePanel 
                        ID="exampleTree" 
                        runat="server" 
                        Header="false"
                        AutoScroll="true" 
                        Lines="false"
                        UseArrows="true"
                        CollapseFirst="false"
                        RootVisible="false"
                        BodyPaddingSummary="12 0 0 0">
                        <TopBar>
                            <ext:Toolbar runat="server">
                                <Items>
                                    <ext:TriggerField 
                                        ID="TriggerField1" 
                                        runat="server" 
                                        EnableKeyEvents="true" 
                                        Flex="1"
                                        EmptyText="Filter Examples...">
                                        <Triggers>
                                            <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                        </Triggers>
                                        <Listeners>
                                            <KeyUp Fn="keyUp" Buffer="100" />
                                            <TriggerClick Fn="clearFilter" />
                                            <SpecialKey Fn="filterSpecialKey" />
                                        </Listeners>
                                    </ext:TriggerField>
                                            
                                    <ext:Button runat="server" Icon="Cog" ToolTip="Options">
                                        <Menu>
                                            <ext:Menu runat="server">
                                                <Items>
                                                    <ext:MenuItem runat="server" Text="Expand All" IconCls="icon-expand-all">
                                                        <Listeners>
                                                            <Click Handler="#{exampleTree}.expandAll(false);" />
                                                        </Listeners>
                                                    </ext:MenuItem>
                                                            
                                                    <ext:MenuItem runat="server" Text="Collapse All" IconCls="icon-collapse-all">
                                                        <Listeners>
                                                            <Click Handler="#{exampleTree}.collapseAll(false);" />
                                                        </Listeners>
                                                    </ext:MenuItem>

                                                    <ext:MenuSeparator runat="server" />

                                                    <ext:CheckMenuItem runat="server" Text="NEW Only">
                                                        <Listeners>
                                                            <CheckChange Fn="filterNewExamples" />
                                                        </Listeners>
                                                    </ext:CheckMenuItem>

                                                    <ext:MenuSeparator runat="server" />
                                                    <ext:MenuItem runat="server" Text="Theme" Icon="Paintcan">
                                                        <Menu>
                                                            <ext:Menu runat="server">
                                                                <Items>
                                                                    <ext:CheckMenuItem ID="DefaultThemeItem" runat="server" Text="Default" Group="theme" />
                                                                    <ext:CheckMenuItem ID="GrayThemeItem" runat="server" Text="Gray" Group="theme" Checked="true"  />
                                                                    <ext:CheckMenuItem ID="AccessThemeItem" runat="server" Text="Access" Group="theme" />
                                                                </Items>
                                                                <Listeners>
                                                                    <Click Handler="#{DirectMethods}.GetThemeUrl(menuItem.text,{
                                                                        success : function (result) {
                                                                            Ext.net.ResourceMgr.setTheme(result);
                                                                            #{ExampleTabs}.items.each(function (el) {
                                                                                if (!Ext.isEmpty(el.iframe)) {
                                                                                    if (el.getBody().Ext) {
                                                                                        el.getBody().Ext.net.ResourceMgr.setTheme(result, menuItem.text.toLowerCase());
                                                                                    }
                                                                                }
                                                                            });
                                                                        }
                                                                    });" />
                                                                </Listeners>
                                                            </ext:Menu>
                                                        </Menu>
                                                    </ext:MenuItem>
                                                </Items>
                                            </ext:Menu>
                                        </Menu>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        
                        <Store>
                            <ext:TreeStore runat="server" OnReadData="GetExamplesNodes">
                                <Proxy>
                                    <ext:PageProxy>
                                        <RequestConfig Method="GET" Type="Load" />
                                    </ext:PageProxy>
                                </Proxy>
                                <Root>
                                    <ext:Node NodeID="Root" Expanded="true" />
                                </Root>
                            </ext:TreeStore>
                        </Store>
    
                        <Listeners>
                            <ItemClick Handler="onTreeItemClick(record, e);" />
                            <AfterRender Fn="onTreeAfterRender" />
                        </Listeners>                                                           
                    </ext:TreePanel>
                </Items>
            </ext:Panel>
            <ext:TabPanel 
                ID="ExampleTabs" 
                runat="server" 
                Region="Center" 
                Margins="0 4 4 0" 
                EnableTabScroll="true"                
                Cls="tabs"
                MinTabWidth="115">
                <Items>
                    <ext:Panel 
                        ID="tabHome" 
                        runat="server" 
                        Title="Home"
                        HideMode="Offsets"
                        Icon="Application">
                        <Loader runat="server" Mode="Frame" Url="Home/">
                            <LoadMask ShowMask="true" />
                        </Loader>
                    </ext:Panel>
                </Items>
                <Listeners>
                    <TabChange Fn="addToken" />
                </Listeners>
                <Plugins>
                    <ext:TabCloseMenu runat="server" />
                </Plugins>
            </ext:TabPanel>
        </Items>
    </ext:Viewport>
    
    <ext:Window 
        ID="LinkWindow" 
        runat="server"
        Modal="true"
        Hidden="true"
        Icon="Link"
        Layout="absolute"
        Width="400"
        Height="110"
        Title="Direct Link"
        Closable="false"
        Resizable="false">
        <Items>
            <ext:TextField 
                ID="exampleLink" 
                runat="server"
                Width="364"
                Cls="dlText"
                X="10"
                Y="10"
                SelectOnFocus="true"
                ReadOnly="true"
                />            
        </Items>
        <Listeners>
            <Show Handler="exampleLink.setValue(this.exampleName);" />
        </Listeners>
        <Buttons>
            <ext:Button 
                runat="server"
                Text=" Open"
                Icon="ApplicationDouble">
                <Listeners>
                    <Click Handler="window.open(LinkWindow.exampleName);" />
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Title="Open Example in the separate window" />
                </ToolTips>
            </ext:Button>
            <ext:Button 
                runat="server"
                Text=" Open (Direct)"
                Icon="ApplicationGo">
                <Listeners>
                    <Click Handler="window.open(LinkWindow.exampleUrl, '_blank');" />
                </Listeners>
                <ToolTips>
                    <ext:ToolTip runat="server" Title="Open Example in the separate window using a direct link" />
                </ToolTips>
            </ext:Button>
            <ext:Button runat="server" Text="Close">
                <Listeners>
                    <Click Handler="this.findParentByType('window').hide(null);" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
    
	<script type="text/javascript">
	    var _gaq = _gaq || [];
	    _gaq.push(['_setAccount', 'UA-19135912-3']);
	    _gaq.push(['_setDomainName', '.ext.net']);
	    _gaq.push(['_trackPageview']);
	    _gaq.push(['_setAllowHash', false]);

	    (function () {
	        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	    })();
	</script>	
</body>
</html>