<%@ Control Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<ext:Panel runat="server" Title="UserControl1" Flex="1" Height="200">    
    <MessageBusListeners>
        <ext:MessageBusListener Name="ToUserControl1.*" Handler="this.body.createChild({html: name, tag:'p'});" />
    </MessageBusListeners>

    <Buttons>
        <ext:Button runat="server" Text="Publish 'FromUserControl.FromUC1'">
            <Listeners>
                <Click BroadcastOnBus="FromUserControl.FromUC1" />
            </Listeners>
        </ext:Button>

        <ext:Button runat="server" Text="Publish 'ToUserControl2.event1'">
            <Listeners>
                <Click BroadcastOnBus="ToUserControl2.event1" />
            </Listeners>
        </ext:Button>
    </Buttons>
</ext:Panel>