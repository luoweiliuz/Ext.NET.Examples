<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spotlight - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <ext:XScript runat="server">
        <script type="text/javascript">
            var updateSpot = function (cmp) {
                #{Spot}.show(cmp);
                updateButtons(cmp);
            };

            var hideSpot = function () {
                if (#{Spot}.active) {
                    #{Spot}.hide();
                }
            
                updateButtons();
            };

            var getButton = function(panel) {
                return panel.dockedItems.last().items.first();
            };

            var updateButtons = function (cmp) {
                cmp = cmp || {};
                getButton(#{Panel1}).setDisabled(cmp.id != #{Panel1}.id);
                getButton(#{Panel2}).setDisabled(cmp.id != #{Panel2}.id);
                getButton(#{Panel3}).setDisabled(cmp.id != #{Panel3}.id);
            };
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server">
            <Listeners>
                <DocumentReady Handler="updateButtons();" />
            </Listeners>
        </ext:ResourceManager>
        
        <h1>Spotlight</h1>

        <p>This control allows you to restrict input to a particular element by masking all other page content.</p>
        
        <ext:Spotlight ID="Spot" runat="server" Easing="EaseOut" Duration="0.3" />
        
        <ext:Button runat="server" Text="Start">
            <Listeners>
                <Click Handler="updateSpot(#{Panel1});" />
            </Listeners>
        </ext:Button>
        
        <ext:Panel runat="server" Border="false" Layout="TableLayout">
            <LayoutConfig>
                <ext:TableLayoutConfig Columns="3" />
            </LayoutConfig>
            <Items>
                <ext:Panel ID="Panel1" runat="server" 
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="150"
                    Html="Some panel content goes here!" 
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button1" runat="server" Text="Next Panel">
                            <Listeners>
                                <Click Handler="updateSpot(#{Panel2});" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" 
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="150"
                    Html="Some panel content goes here!" 
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button2" runat="server" Text="Next Panel">
                            <Listeners>
                                <Click Handler="updateSpot(#{Panel3});" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
                <ext:Panel ID="Panel3" runat="server" 
                    Frame="true"
                    Title="Demo Panel"
                    Width="200"
                    Height="150"
                    Html="Some panel content goes here!" 
                    PaddingSummary="10px 15px">
                    <Buttons>
                        <ext:Button ID="Button3" runat="server" Text="Done">
                            <Listeners>
                                <Click Handler="hideSpot();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
            </Items>
        </ext:Panel>        
    </form>
</body>
</html>
