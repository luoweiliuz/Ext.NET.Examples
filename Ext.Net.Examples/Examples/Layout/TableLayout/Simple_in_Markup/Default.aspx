<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple TableLayout in Markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #pnlTableLayout .x-table-layout {
            padding : 5px;
        }
        
        #pnlTableLayout .x-table-layout td {
            font-size : 11px;
            padding   : 5px;
            vertical-align : top;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport ID="ViewPort1" runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel
                id="pnlTableLayout"
                runat="server"
                Region="Center" 
                Title="Table Layout"
                Border="false"
                BodyPadding="15"
                Layout="TableLayout">
                <LayoutConfig>
                    <ext:TableLayoutConfig Columns="4" />
                </LayoutConfig>
                <Items>
                    <ext:Panel 
                        ID="Panel1" 
                        runat="server" 
                        Title="Lots of Spanning" 
                        BodyPadding="15"
                        Html="<p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p>" 
                        RowSpan="3"
                        />
                    <ext:Panel 
                        ID="Panel2" 
                        runat="server" 
                        Title="Basic Table Cell" 
                        BodyPadding="15"
                        Html="<p>Basic panel in a table cell.</p>"
                        />
                    <ext:Panel 
                        ID="Panel3" 
                        runat="server" 
                        Header="false"
                        BodyPadding="15"
                        Html="<p>Plain panel</p>"
                        />
                    <ext:Panel 
                        ID="Panel4" 
                        runat="server"
                        RowSpan="2" 
                        Title="Another Cell"
                        Width="300"
                        BodyPadding="15"
                        Html="<p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p>"
                        />
                            
                    <ext:Panel 
                        ID="Panel5" 
                        runat="server" 
                        ColSpan="2"
                        Header="false"
                        BodyPadding="15"
                        Html="Plain cell spanning two columns"
                        />
                    <ext:Panel 
                        ID="Panel6" 
                        runat="server" 
                        ColSpan="3"
                        Title="More Column Spanning"
                        BodyPadding="15"
                        Html="<p>Spanning three columns.</p>"
                        />
                    <ext:Panel 
                        ID="Panel7" 
                        runat="server" 
                        ColSpan="4"
                        Title="Spanning All Columns"
                        BodyPadding="15"
                        Html="<p>Spanning all columns.</p>"
                        />
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>
</body>
</html>