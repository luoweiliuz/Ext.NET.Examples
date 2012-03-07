<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

 <script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SiteMapNode siteNode = SiteMap.RootNode;
        Node root = this.CreateNode(siteNode);
        TreePanel1.Root.Add(root);
            
        //dynamic tree root
        TreePanel2.Root.Add(this.CreateNodeWithOutChildren(siteNode));
    }
        
    //page tree node loader handler
    protected void LoadPages(object sender, NodeLoadEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.NodeID))
        {
            SiteMapNode siteMapNode = SiteMap.Provider.FindSiteMapNodeFromKey(e.NodeID);

            SiteMapNodeCollection children = siteMapNode.ChildNodes;

            if (children != null && children.Count > 0)
            {
                foreach (SiteMapNode mapNode in siteMapNode.ChildNodes)
                {
                    e.Nodes.Add(this.CreateNodeWithOutChildren(mapNode));
                }
            }
        }
    }
        
    //dynamic node creation
    private Node CreateNodeWithOutChildren(SiteMapNode siteMapNode)
    {
        Node treeNode;

        if (siteMapNode.ChildNodes != null && siteMapNode.ChildNodes.Count > 0)
        {
            treeNode = new Node();
        }
        else
        {
            treeNode = new Node();
            treeNode.Leaf = true;
        }
            
        if (!string.IsNullOrEmpty(siteMapNode.Url))
        {
            treeNode.Href = this.Page.ResolveUrl(siteMapNode.Url);
        }

        treeNode.NodeID = siteMapNode.Key;
        treeNode.Text = siteMapNode.Title;
        treeNode.Qtip = siteMapNode.Description;

        return treeNode;
    }

    //static node creation with children
    private Node CreateNode(SiteMapNode siteMapNode)
    {
        Node treeNode = new Node();

        if (!string.IsNullOrEmpty(siteMapNode.Url))
        {
            treeNode.Href = this.Page.ResolveUrl(siteMapNode.Url);    
        }
            
        treeNode.NodeID = siteMapNode.Key;
        treeNode.Text = siteMapNode.Title;
        treeNode.Qtip = siteMapNode.Description;

        SiteMapNodeCollection children = siteMapNode.ChildNodes;

        if (children != null && children.Count > 0)
        {
            foreach (SiteMapNode mapNode in siteMapNode.ChildNodes)
            {
                treeNode.Children.Add(this.CreateNode(mapNode));
            }
        }
        else
        {
            treeNode.Leaf = true;
        }
            
        return treeNode;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Load SiteMap into TreePanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var loadPage = function (tabPanel, record) {
            var tab = tabPanel.getComponent(record.getId());

            if (!tab) {
                tab = tabPanel.add({
                    id       : record.getId(),
                    title    : record.data.text,
                    closable : true,
                    loader : {
                        url      : record.data.href,
                        mode     : "iframe",
                        loadMask : {
                            showMask : true,
                            msg  : "Loading " + record.data.href + "..."
                        }
                    },
                    autoScroll : true
                });                
            }
            
            tabPanel.setActiveTab(tab);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:TreePanel 
                    ID="TreePanel1"
                    runat="server"
                    Region="West"
                    Width="300" 
                    Title="Site Map - Preload" 
                    Icon="ChartOrganisation">            
                    <Listeners>
                        <ItemClick Handler="if (record.data.href) { e.stopEvent(); loadPage(#{Pages}, record); }" />
                    </Listeners>
                </ext:TreePanel>
                <ext:TabPanel 
                    ID="Pages" 
                    runat="server" 
                    Region="Center" 
                    EnableTabScroll="true" 
                    LayoutOnTabChange="true" 
                    />
                <ext:TreePanel 
                    ID="TreePanel2" 
                    runat="server" 
                    Region="East"
                    Width="300" 
                    Title="Site Map - Dynamic" 
                    Icon="ChartOrganisation">
                    <Listeners>
                        <ItemClick Handler="if (record.data.href) { e.stopEvent(); loadPage(#{Pages}, record); }" />
                    </Listeners>
                    <Store>
                        <ext:TreeStore runat="server" OnReadData="LoadPages">
                            <Proxy>
                                <ext:PageProxy />
                            </Proxy>
                        </ext:TreeStore>
                    </Store>
                </ext:TreePanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>