<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Original Header - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <ext:Viewport runat="server" Layout="Border">
        <Items> 
            <ext:Panel 
                runat="server" 
                Width="300" 
                Border="false" 
                Region="West" 
                Layout="Fit" 
                BodyPadding="5">
                <Items>
                    <ext:Panel runat="server" Layout="Accordion" Margins="0 0 15 0">
                        <LayoutConfig>
                            <ext:AccordionLayoutConfig OriginalHeader="true" />
                        </LayoutConfig>
                        <Items>
                            <ext:Panel runat="server" Title="Item 1" Border="false" />
                            <ext:Panel runat="server" Title="Item 2" Border="false" />
                            <ext:Panel runat="server" Title="Item 3" Border="false" />
                            <ext:Panel runat="server" Title="Item 4" Border="false" />
                            <ext:Panel runat="server" Title="Item 5" Border="false" />
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
            
            <ext:Panel runat="server" Margins="5" Region="Center" BodyPadding="10">
                <Content>
                    <h1>Original header of the Accordion's item</h1>
                </Content>
            </ext:Panel>
        </Items>
    </ext:Viewport>
</body>
</html>
