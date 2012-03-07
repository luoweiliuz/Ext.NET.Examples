<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic"%>
<%--<%@ Import Namespace="ListView=Ext.Net.ListView"%>--%>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            //We do not need to DataBind on an DirectEvent
            return;
        }
        
        List<object> data = new List<object>();
        
        for (int i = 1; i <= 10; i++)
        {
            data.Add(new { ID = "S" + i, Name = "Supplier " + i});
        }
        
        this.Store1.DataSource = data;
        this.Store1.DataBind();
    }
    
    private void RemoveFromCache(string id)
    {
        X.Js.Call("removeFromCache", id);
    }

    private void AddToCache(string id)
    {
        X.Js.Call("addToCache", id);
    }

    protected void BeforeExpand(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["id"];
        
        Store store = new Store { ID = "StoreRow_"+id };

        Model model = new Model();
        model.IDProperty = "ID";
        model.Fields.Add("ID", "Name");
        store.Model.Add(model);

        List<object> data = new List<object>();
        
        for (int i = 1; i <= 10; i++)
        {
            data.Add(new { ID = "P"+i, Name = "Product " + i });
        }

        store.DataSource = data;

        //this.RemoveFromCache(store.ID);
        //store.Render();
        //this.AddToCache(store.ID);

        GridPanel grid = new GridPanel
        {
            ID = "GridPanelRow_" + id,
            Height = 200,
            Store = { store }
        };
        
        grid.ColumnModel.Columns.Add(new Column
                                         {
                                             Text = "Products's Name",
                                             DataIndex = "Name"
                                         });
        grid.ColumnModel.ID = "GridPanelRowCM_" + id;

        grid.View.Add(new Ext.Net.GridView { ID = "GridPanelRowView_" + id });

        //important
        X.Get("row-" + id).SwallowEvent(new string[] { "click", "mousedown", "mouseup", "dblclick"}, true);

        this.RemoveFromCache(grid.ID);
        grid.Render("row-" + id, RenderMode.RenderTo);
        this.AddToCache(grid.ID);
    }
    
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>RowExpander with GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <ext:ResourcePlaceHolder runat="server" Mode="Script" />
    
    <script type="text/javascript">
        var ns = App;
        ns.lookup = [];
        
        var clean = function () {
            if (ns.lookup.length > 0) {
                ns.RowExpander1.collapseAll();
                
                Ext.each(ns.lookup, function (control) {
                    if (control) {
                        control.destroy();
                    }
                });
                
                ns.lookup = [];
            }            
        };

        var removeFromCache = function (c) {
            c = window[c];
            Ext.Array.remove(ns.lookup, c);
            
            if (c) {
                c.destroy();
            }
        };

        var addToCache = function (c) {
            ns.lookup.push(ns[c]);
        };
        
        var beforeUpdate = function (view, record, rowIndex){    
            var grid = window["GridPanelRow_"+record.getId()];
            if(grid && !grid.moved){
                var ce = grid.getEl(), 
                    el = Ext.net.ResourceMgr.getAspForm() || Ext.getBody();                    
                    
                ce.addCls("x-hidden");
                
                el.dom.appendChild(ce.dom);
                grid.moved = true;
        
                view.on("itemupdate", function (){
                    if(!grid.moved){
                        return;
                    }
                    var row = view.getNode(rowIndex),              
                        body = Ext.DomQuery.selectNode("div.x-grid-rowbody", row);                
                
                    Ext.fly("row-"+record.getId()).appendChild(ce.dom);
                    ce.removeCls("x-hidden");  
                    grid.moved = false;       
                    body.rendered = true;                       
                }, view, {single:true});
            }
        };

        var beforeRemove = function (view, record, rowIndex){    
            removeFromCache("GridPanelRow_"+record.getId());
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Row Expander Plugin with GridPanel</h1>
        
        <p>The caching is presented, GridPanel renders once only (until view refresh)</p>
        
        <ext:Store ID="Store1" runat="server">
            <Model>
                <ext:Model runat="server" IDProperty="ID">
                    <Fields>
                        <ext:ModelField Name="ID" />
                        <ext:ModelField Name="Name" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
        
        <ext:GridPanel 
            ID="GridPanel1" 
            runat="server" 
            StoreID="Store1" 
            Title="Expander Rows with ListView" 
            Collapsible="true"
            AnimCollapse="true" 
            Icon="Table" 
            Width="600" 
            Height="600">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Supplier" DataIndex="Name" Flex="1" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" >
                    <Listeners>
                        <BeforeRefresh Fn="clean" />                        
                        <BeforeItemUpdate Fn="beforeUpdate" />
                        <BeforeItemRemove Fn="beforeRemove" />
                    </Listeners>
                </ext:GridView>
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
            <Plugins>
                <ext:RowExpander ID="RowExpander1" runat="server" EnableCaching="true">
                    <Template runat="server">
                        <Html>
							<div id="row-{ID}" style="background-color:White;"></div>
						</Html>
                    </Template>
                    <DirectEvents>
                        <BeforeExpand 
                            OnEvent="BeforeExpand" 
                            Before="return !body.rendered;" 
                            Success="body.rendered=true;">
                            <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="={#{GridPanel1}.body}" />
                            <ExtraParams>
                                <ext:Parameter Name="id" Value="record.getId()" Mode="Raw" />
                            </ExtraParams>
                        </BeforeExpand>
                    </DirectEvents>
                </ext:RowExpander>
            </Plugins>            
        </ext:GridPanel>
    </form>
</body>
</html>