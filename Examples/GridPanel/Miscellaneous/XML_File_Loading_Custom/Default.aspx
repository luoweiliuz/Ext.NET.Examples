<%@ Page Language="C#" %>
  
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Custom XML file loading - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var idConvert = function (value, record) {
            var xmlNode = record.raw;
            return xmlNode.attributes[0].value;   
        };

        var categoryConvert = function (value, record) {
            var xmlNode = record.raw;
            return xmlNode.attributes[1].value;   
        };

        var linksConvert = function (value, record) {
            var xmlNode = record.raw,
                nodes = xmlNode.childNodes,
                links = [],
                i,
                j,
                link,
                url;

            for (i = 0; i < nodes.length; i++) {
                link = nodes[i];
                if (link.nodeName === "link") {
                    for (j = 0; j < link.childNodes.length; j++) {
                        url = link.childNodes[j];
                        if (url.nodeName === "url") {
                            links.push([url.childNodes[0].data]);
                        }
                    }
                }
            }
            return links;
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Custom XML file loading</h1>
        
    <p>This example shows how to load a data from a custom XML file directly.</p>
        
    <ext:GridPanel 
        runat="server"
        Title="Categories"
        Frame="true" 
        Height="300" 
        Width="300">
        <Store>
            <ext:Store runat="server">
                <Proxy>
                    <ext:AjaxProxy Url="categories.xml">
                        <Reader>
                            <ext:XmlReader Record="category" />
                        </Reader>
                    </ext:AjaxProxy>
                </Proxy>
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="id">
                                <Convert Fn="idConvert" />
                            </ext:ModelField>
                            <ext:ModelField Name="category">
                                <Convert Fn="categoryConvert" />
                            </ext:ModelField>
                            <ext:ModelField Name="links">
                                <Convert Fn="linksConvert" />
                            </ext:ModelField>
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column 
                    runat="server" 
                    ID="Category" 
                    Text="Category" 
                    DataIndex="category" 
                    Flex="1" />
                <ext:Column 
                    runat="server" 
                    Text="ID" 
                    DataIndex="id" />
            </Columns>
        </ColumnModel>
        <Plugins>
            <ext:RowExpander runat="server">
                <Component>
                    <ext:GridPanel runat="server" Height="150" Title="Links">
                        <Store>
                            <ext:Store ID="StoreLinks" runat="server">
                                <Model>
                                    <ext:Model runat="server">
                                        <Fields>
                                            <ext:ModelField Name="link" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                                <Reader>
                                    <ext:ArrayReader />
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:Column runat="server" Text="Link" DataIndex="link" Flex="1" />
                            </Columns>
                        </ColumnModel>
                    </ext:GridPanel>
                </Component>
                <Listeners>
                    <Expand Handler="#{StoreLinks}.loadData(record.get('links'));
                                           body.swallowEvent([ 'click', 'mousedown', 'mouseup', 'dblclick'], true);" />
                </Listeners>
            </ext:RowExpander>
        </Plugins>
    </ext:GridPanel>
</body>
</html>