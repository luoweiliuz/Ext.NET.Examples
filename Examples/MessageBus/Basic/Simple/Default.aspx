<%@ Page Language="C#" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script runat="server">
        protected void PublishEvent(object sender, DirectEventArgs e)
        {
            MessageBus.Default.Publish("Msg.Server", "It is an event from server side");
        }

        protected void ServerBusEvent(object sender, DirectEventArgs e)
        {
            Panel2.Body.CreateChild(new DomObject
            {
                Html = e.ExtraParams["message"],
                Tag = HtmlTextWriterTag.P,
                CustomConfig =
                {
                    new ConfigItem("style", "color:green;", ParameterMode.Value)
                }
            });
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <p>
            Please see the following links to understand message (token) syntax
        </p>
        <p>
            <a href="http://www.openajax.org/member/wiki/OpenAjax_Hub_2.0_Specification">OpenAjax Hub 2.0 Specification</a>
            <br />
            <a href="http://www.openajax.org/member/wiki/OpenAjax_Hub_2.0_Specification_Topic_Names">OpenAjax Hub 2.0 Specification Topic Names</a>
        </p>
    
        <ext:Container runat="server" Layout="HBoxLayout">
            <Items>
                <ext:Panel ID="Panel1" runat="server" Title="Catch all App events" Width="300" Height="300" BodyPadding="5" Margins="5">
                    <MessageBusListeners>
                        <ext:MessageBusListener Name="App.*" Handler="this.body.createChild({html: name + ' from ' + data.item.id, tag:'p'});" />
                    </MessageBusListeners>
            
                    <Buttons>
                        <ext:Button ID="Button1" runat="server" Text="Publish 'App.event1'">
                            <Listeners>
                                <Click BroadcastOnBus="App.event1" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="Button2" runat="server" Text="Publish 'App.event2'">
                            <Listeners>
                                <Click BroadcastOnBus="App.event2" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>    

                <ext:Panel ID="Panel2" runat="server" Title="Category events" Width="350" Height="300" BodyPadding="5" Margins="5">
                    <MessageBusListeners>
                        <ext:MessageBusListener Name="Msg.Log" Handler="this.body.createChild({html: data, tag:'p', style:'color:blue;'});" />
                        <ext:MessageBusListener Name="Msg.Error" Handler="this.body.createChild({html: data, tag:'p', style:'color:red;'});" />
                    </MessageBusListeners>

                    <MessageBusDirectEvents>
                        <ext:MessageBusDirectEvent Name="Msg.Server" OnEvent="ServerBusEvent">
                            <ExtraParams>
                                <ext:Parameter Name="message" Value="data" Mode="Raw" />
                            </ExtraParams>
                        </ext:MessageBusDirectEvent>
                    </MessageBusDirectEvents>
            
                    <Buttons>
                        <ext:Button runat="server" Text="Publish 'Log'">
                            <Listeners>
                                <Click Handler="Ext.net.Bus.publish('Msg.Log', 'It is a log message');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Publish 'Error'">
                            <Listeners>
                                <Click Handler="Ext.net.Bus.publish('Msg.Error', 'It is an error message');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Publish 'Server'">
                            <DirectEvents>
                                <Click OnEvent="PublishEvent" />
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Panel>
            </Items>
        </ext:Container>
        
    </form>
</body>
</html>
