<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SiteMapNode siteNode = SiteMap.RootNode;
        Node root = this.CreateNode(siteNode);
        root.AllowDrag = false;
        root.Expanded = true;
        TreePanel1.Root.Add(root);
    }

    //static node creation with children
    private Node CreateNode(SiteMapNode siteMapNode)
    {
        Node treeNode = new Node();
        
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
    <title>Tree Filter - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var filterTree = function (tf, e) {
            var tree = App.TreePanel1,
                text = tf.getRawValue();            

            tree.clearFilter();
            
            if (Ext.isEmpty(text, false)) {
                return;
            }
            
            if (e.getKey() === Ext.EventObject.ESC) {
                clearFilter();
            } else {
                var re = new RegExp(".*" + text + ".*", "i");
                
                tree.filterBy(function (node) {
                    return re.test(node.data.text);
                });
            }
        };
        
        var clearFilter = function () {
            var field = App.TriggerField1,
                tree = App.TreePanel1;
            
            field.setValue(""); 
            tree.clearFilter(true);             
            tree.getView().focus();            
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Tree Filter</h1>
        
        <ext:TreePanel 
            ID="TreePanel1"
            runat="server" 
            Height="300" 
            Width="250"
            UseArrows="true"
            Animate="true">           
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarTextItem runat="server" Text="Filter:" />
                        <ext:ToolbarSpacer />
                        <ext:TriggerField 
                            ID="TriggerField1" 
                            runat="server" 
                            EnableKeyEvents="true">
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" />
                            </Triggers>
                            <Listeners>
                                <KeyUp Fn="filterTree" Buffer="250" />
                                <TriggerClick Handler="clearFilter();" />
                            </Listeners>
                        </ext:TriggerField>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:TreePanel>
    </form>
</body>
</html>