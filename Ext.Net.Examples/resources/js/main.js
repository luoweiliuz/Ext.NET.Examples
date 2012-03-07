var makeTab = function (id, url, title) {
    var win, 
        tab, 
        hostName, 
        exampleName, 
        node, 
        tabTip;
    
    if (id === "-") {
        id = Ext.id(undefined, "extnet");
        lookup[url] = id;
    }
    
    tabTip = url.replace(/^\//g, "");
    tabTip = tabTip.replace(/\/$/g, "");
    tabTip = tabTip.replace(/\//g, " > ");
    tabTip = tabTip.replace(/_/g, " ");
    
    win = new Ext.Window({
        id      : "w" + id,
        layout  : "fit",        
        title   : "Source Code",
        iconCls : "#PageWhiteCode",
        width   : 925,
        height  : 650,
        border  : false,
        maximizable : true,
        constrain   : true,
        closeAction : "hide",        
        listeners   : {
            show : {
                fn : function () {
                    var height = Ext.getBody().getViewSize().height;
                    
                    if (this.getSize().height > height) {
                        this.setHeight(height - 20)
                    }

                    this.body.mask("Loading...", "x-mask-loading");
                    Ext.Ajax.request({
                        url     : "ExampleLoader.ashx",
                        success : function (response) { 
                            this.body.unmask();
                            eval(response.responseText);
                        },
                        failure : function (response) {
                            this.body.unmask();
                            Ext.Msg.alert("Failure", "The error during example loading:\n" + response.responseText);
                        },
                        params : { 
                            id  : id, 
                            url : url, 
                            wId : this.nsId
                        },
                        scope : this
                    });
                },
                
                single : true
            }
        },
        buttons :[
            {
                id   : "b" + id,
                text : "Download",
                iconCls   : "#Compress",
                listeners : {
                    click : {
                        fn : function (el, e) {
                            window.location = "/GenerateSource.ashx?t=1&e=" + url;
                        }
                    }
                }
            }
        ]        
    });
    
    hostName = window.location.protocol + "//" + window.location.host;
    exampleName = url;
    
    tab = App.ExampleTabs.add(new Ext.Panel({
        id   : id,        
        tbar : [{
            text      : "Source Code",
            iconCls   : "#PageWhiteCode",
            listeners : {
                "click" : function () {
                    Ext.getCmp("w" + id).show(null);
                }
            }
        },
        /*"-",
        {
            ref : "../commentsBtn",
            text : "Comments (*)",
            iconCls : "icon-comments",
            listeners : {
                "render" : function () {
                    Ext.net.DirectMethod.request({
                        url          : "/ExampleLoader.ashx",
                        cleanRequest : true,
                        button       : this,
                        params       : {
                            url : url,
                            action : "comments.count"                            
                        },
                        success      : function (result, response, extraParams, o) {
                            o.button.setText("Comments ("+result+")");
                        }
                    });
                },
                
                "click" : function () {
                    loadComments(this, url);
                }
            }
        },*/
        "->", 
	    {
            text    : "Direct Link",
            iconCls : "#Link",
            handler : function () {
                new Ext.Window({
                    modal     : true,
                    iconCls   : "#Link",
                    layout    : "absolute",
                    defaultButton : "dl" + id,
                    width     : 400,
                    height    : 110,
                    title     : "Direct Link",
                    closable  : false,
                    resizable : false,
                    items : [{
                        id    : "dl" + id,
                        xtype : "textfield",
                        cls   : "dlText",
                        width : 364,
                        x     : 10,
                        y     : 10,
                        selectOnFocus : true,
                        readOnly : true,
                        value    : hostName + "/#" + exampleName
                    }],
                    buttons: [{
                        xtype   : "button",
                        text    : " Open",
                        iconCls : "#ApplicationDouble",
                        tooltip : "Open Example in the separate window",
                        handler : function () {
                            window.open(hostName + "/#" + exampleName);
                        }
                    },
                    {
                        xtype   : "button",
                        text    : " Open (Direct)",
                        iconCls : "#ApplicationGo",
                        tooltip : "Open Example in the separate window using a direct link",
                        handler : function () {
                            window.open(hostName + "/Examples" + url, "_blank");
                        }
                    },
                    {
                        xtype   : "button",
                        text    : "Close",
                        handler : function () {
                            this.findParentByType("window").hide(null);
                        }
                    }]
                }).show(null);
            }
        },
        "-", 
        {
            text    : "Refresh",
            handler : function () {
                Ext.getCmp(id).reload(true)
            },
            iconCls : "#ArrowRefresh"
        }],
        title    : title,
        tabTip   : tabTip,
        hideMode : "offsets",        

        loader : {
            scripts  : true,
            url      : hostName + "/Examples" + url,
            loadMask : true
        },
        listeners : {
            deactivate : {
                fn : function (el) {
                    if (this.sWin && this.sWin.isVisible()) {
                         this.sWin.hide();
                    }
                }
            },
            
            destroy : function () {
                if (this.sWin) {
                    this.sWin.close();
                    this.sWin.destroy();
                }
            }
        },
        closable : true
    }));
    
    tab.sWin = win;
    setTimeout(function(){
        App.ExampleTabs.setActiveTab(tab);
    }, 250);
    
    var node = App.exampleTree.getStore().getNodeById(id),
        expandAndSelect = function (node) {
            App.exampleTree.animate = false;
            node.bubble(function(node) {
                node.expand(false);
            }); 
            App.exampleTree.getSelectionModel().select(node);       
            App.exampleTree.animate = true;    
        };
         
    if (node) {
        expandAndSelect(node);     
    } else {
        App.exampleTree.on("load", function (node) {
            node = App.exampleTree.getStore().getNodeById(id);
            if (node) {
                expandAndSelect(node);
            }
        }, this, { delay: 10, single : true });
    }
};

var lookup = {};

var onTreeAfterRender = function (tree) {
    var sm = tree.getSelectionModel();

    Ext.create('Ext.util.KeyNav', tree.view.el, {
        enter : function (e) {
            if (sm.hasSelection()) {
                onTreeItemClick(sm.getSelection()[0], e);
            }
        }
    });
};

var onTreeItemClick = function (record, e) {
    if (record.isLeaf()) { 
        e.stopEvent(); 
        loadExample(record.get('href'), record.getId(), record.get('text')); 
    } else {
        record[record.isExpanded() ? 'collapse' : 'expand']();
    }
};

var loadExample = function (href, id, title) {
    var tab = App.ExampleTabs.getComponent(id),
        lObj = lookup[href];
        
    if (id == "-") {
        App.direct.GetHashCode(href,{
            success : function (result) {
                loadExample(href, "e" + result, title);
            }
        });
        
        return;
    }
    
    lookup[href] = id;

    if (tab) {
        App.ExampleTabs.setActiveTab(tab);
    } else {
        if (Ext.isEmpty(title)) {
            var m = /(\w+)\/$/g.exec(href);
            title = m == null ? "[No name]" : m[1];
        }
        
        title = title.replace(/<span>&nbsp;<\/span>/g, "");
        title = title.replace(/_/g, " ");
        makeTab(id, href, title);     
    }
};

var viewClick = function (dv, e) {
    var group = e.getTarget("h2", 3, true);

    if (group) {
        group.up("div").toggleClass("collapsed");
    }
};

var beforeSourceShow = function (el) {
    var height = Ext.getBody().getViewSize().height;
    
    if (el.getSize().height > height) {
        el.setHeight(height - 20);
    }
};

var change = function (token) {
    if (token) {
        loadExample(token, lookup[token] || "-" );
    } else {
        App.ExampleTabs.setActiveTab(0);
    }
};

var addToken = function (el, tab) {
    if (tab.loader && tab.loader.url) {
        var host = window.location.protocol + "//" + window.location.host + "/Examples",
            token = tab.loader.url.substr(host.length);
        
        if (!Ext.isEmpty(token)) {
            Ext.History.add(token);
        }
    } else {                
        Ext.History.add("");                
    }
};

var keyUp = function (field, e) {
    var tree = App.exampleTree,
        text = field.getRawValue();
    
    if (e.getKey() === 40) {
        return;
    }
        
    if (Ext.isEmpty(text, false)) {
        clearFilter(field);
    }
    
    if (text.length < 3) {
        return;
    }    
    
    if (Ext.isEmpty(text, false)) {
        return;
    }
    
    field.getTrigger(0).show();
    
    if (e.getKey() === Ext.EventObject.ESC) {
        clearFilter(field);
    } else {
        var re = new RegExp(".*" + text + ".*", "i");
        
        tree.clearFilter(true);
        
        tree.filterBy(function (node) {
            var match = re.test(node.data.text.replace(/<span>&nbsp;<\/span>/g, "")),
                pn = node.parentNode;
                
            if (match && node.isLeaf()) {
               pn.hasMatchNode = true;
            }
            
            if (pn != null && pn.fixed) {
                if (node.isLeaf() === false) {
                    node.fixed = true;
                }
                return true;
            }            
                
            if (node.isLeaf() === false) {
                node.fixed = match;
                return match;
            }            
            
            return (pn != null && pn.fixed) || match;
        }, { expandNodes : false });

        tree.getView().animate = false;
        tree.getRootNode().cascadeBy(function (node) {
            if (node.isRoot()) {
               return;
            }            
            
            if ((node.getDepth() === 1) || 
               (node.getDepth() === 2 && node.hasMatchNode)) {
               node.expand(false);
            }
            
            delete node.fixed;
            delete node.hasMatchNode;
        }, tree);
        tree.getView().animate = true;
    }
};

var clearFilter = function (field, trigger, index, e) {
    var tree = App.exampleTree;
    
    field.setValue(""); 
    field.getTrigger(0).hide();
    tree.clearFilter(true);     
    field.focus(false, 100);        
};

var filterSpecialKey = function (field, e) {
    if (e.getKey() == e.DOWN) {
        var n = App.exampleTree.getRootNode().findChildBy(function (node) {
            return node.isLeaf() && !node.data.hidden;
        }, App.exampleTree, true);
        
        if (n) {
            App.exampleTree.expandPath(n.getPath(), null, null, function(){
                App.exampleTree.getSelectionModel().select(n);
                App.exampleTree.getView().focus();            
            });            
        }
    }
};

var filterNewExamples = function (checkItem, checked) {
    var tree = App.exampleTree;
        
    if (checked) {
        tree.clearFilter(true);
        tree.filterBy(function (node) {
            return new RegExp("<span>&nbsp;</span>").test(node.data.text);
        });    
    } else {
        tree.clearFilter(true);
    }
};

var loadComments = function (at, url) {
    App.winComments.url = url;
    
    App.winComments.show(at, function () {
        updateComments(false, url);
        App.TagsView.store.reload();
    });
};

var updateComments = function (updateCount, url) {
    winComments.body.mask("Loading...", "x-mask-loading");
    Ext.net.DirectMethod.request({
        url: "/ExampleLoader.ashx",
        cleanRequest : true,
        params       : {
            url : url,
            action : "comments.build"                            
        },
        success      : function (result, response, extraParams, o) {
            if (result && result.length > 0) {
                App.tplComments.overwrite(CommentsBody.body, result);
            }
            
            if (updateCount) {
                App.ExampleTabs.getActiveTab().commentsBtn.setText("Comments ("+result.length+")");
            }
        },
        complete    : function (success, result, response, extraParams, o) {
            App.winComments.body.unmask();
        }
    });
};

if (window.location.href.indexOf("#") > 0) {
    var directLink = window.location.href.substr(window.location.href.indexOf("#") + 1);
    
    Ext.onReady(function () {
        if (!Ext.isEmpty(directLink, false)) {
            loadExample(directLink, "-");
        }
    }, window, { delay : 100 });
}