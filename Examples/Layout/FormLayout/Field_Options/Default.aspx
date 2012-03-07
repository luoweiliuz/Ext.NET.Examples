<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormLayout Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        .blueborder {
        	border: dotted 1px blue;
        	padding:1px 0px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
            
        <ext:Panel 
            runat="server" 
            Frame="true" 
            Title="Label Style and Separator" 
            Width="400"
            LabelSeparator="-" 
            LabelWidth="55"
            Layout="AnchorLayout">
            <Defaults>
                <ext:Parameter Name="LabelStyle" Value="color:red;" Mode="Value" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" />
                <ext:TextField 
                    runat="server" 
                    FieldLabel="Label" 
                    LabelStyle="color:blue;" 
                    LabelSeparator="+" 
                    AnchorHorizontal="95%" 
                    />
            </Items>
        </ext:Panel>
        
        <br />
        
        <ext:Panel 
            ID="Panel1" 
            runat="server" 
            Frame="true" 
            Title="Without labels" 
            Width="400" 
            Layout="AnchorLayout">
            <Defaults>
                <ext:Parameter Name="HideLabel" Value="true" Mode="Raw" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" />
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" />
            </Items>
        </ext:Panel>
    
        <br />
        
        <ext:Panel 
            ID="Panel2" 
            runat="server" 
            Frame="true" 
            Title="Item style" 
            Width="400"
            Layout="AnchorLayout">
            <Defaults>
                <ext:Parameter Name="Cls" Value="blueborder" Mode="Value" />
            </Defaults>
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" />
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" />
            </Items>
        </ext:Panel>
        
        <br />
        
        <ext:Panel 
            ID="Panel3" 
            runat="server" 
            Frame="true" 
            Title="Label Top Align" 
            Width="400"
            Layout="AnchorLayout">
            <Items>
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" LabelAlign="Top" />
                <ext:TextField runat="server" FieldLabel="Label" AnchorHorizontal="95%" LabelAlign="Top" />
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
