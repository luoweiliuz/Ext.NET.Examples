<%@ Control Language="C#" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    public List<object> feeds = new List<object> 
    { 
        new {title = "Sencha Blog", url = "http://feeds.feedburner.com/extblog"},
        new {title = "Sencha Forums", url = "http://sencha.com/forum/external.php?type=RSS2"},
        new {title = "Ajaxian", url = "http://feeds.feedburner.com/ajaxian"}
    };

    protected void AddFeedClick(object sender, DirectEventArgs e)
    {
        UserControlRenderer.Render(new UserControlRendrerConfig 
        { 
            UserControlPath = "uc/FeedWindow.ascx",
            SingleControl = true,
            Mode = RenderMode.RenderTo
        });
    }
</script>

<ext:Panel runat="server"
    Cls="feed-panel"
    AnimCollapse="true"
    Layout="FitLayout"
    Title="Feeds">
    <PreInit Handler="this.addEvents('feedselect');" />
    <Bin>
        <ext:Menu runat="server">
            <Items>
                <ext:MenuItem runat="server" Text="Load feed" IconCls="feed-load">
                    <Listeners>
                        <Click Handler="FeedViewer.FeedPanel.loadFeed(this.up().activeFeed);" />
                    </Listeners>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Add feed" IconCls="feed-add">
                    <DirectEvents>
                        <Click OnEvent="AddFeedClick"/>
                    </DirectEvents>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Remove feed" IconCls="feed-remove">
                    <Listeners>
                        <Click Fn="FeedViewer.FeedPanel.removeFeed" />
                    </Listeners>
                </ext:MenuItem>
            </Items>
            <Listeners>
                <Hide Handler="this.activeFeed = null;" />
            </Listeners>
        </ext:Menu>
    </Bin>
    <TopBar>
        <ext:Toolbar runat="server">
            <Items>
                <ext:Button runat="server" Text="Add feed" IconCls="feed-add" OnDirectClick="AddFeedClick">
                </ext:Button>

                <ext:Button runat="server" ItemID="remove" Text="Remove feed" IconCls="feed-remove">
                    <Listeners>
                        <Click Fn="FeedViewer.FeedPanel.removeFeed" />
                    </Listeners>
                </ext:Button>
            </Items>
        </ext:Toolbar>
    </TopBar>
    <Items>        
        <ext:DataView runat="server" 
            SingleSelect="true"
            TrackOver="true"
            Cls="feed-list"
            ItemSelector=".feed-list-item"
            OverItemCls="feed-list-item-hover">
            <Store>
                <ext:Store runat="server" Data="<%# feeds %>" AutoDataBind="true">
                    <Model>
                        <ext:Model runat="server" Name="Feed">
                            <Fields>
                                <ext:ModelField Name="title" />
                                <ext:ModelField Name="url" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>

            <Tpl>
                <Html>
                    <tpl for=".">
                        <div class="feed-list-item">
                            {title}
                        </div>
                    </tpl>
                </Html>
            </Tpl>

            <Listeners>
                <SelectionChange Fn="FeedViewer.FeedPanel.onSelectionChange" />
                <ItemContextMenu Fn="FeedViewer.FeedPanel.onContextMenu" />
                <ViewReady Handler="this.getSelectionModel().select(this.store.first());" />
            </Listeners>
        </ext:DataView>
    </Items>
</ext:Panel>