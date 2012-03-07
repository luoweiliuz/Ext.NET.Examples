<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Ext.NET Example</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        .custom-trigger {
            background-image : url(resources/images/custom-trigger.gif) !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <ext:TriggerField 
            runat="server" 
            Width="200" 
            EmptyText="Click Trigger Button -->">
            <Triggers>
                <ext:FieldTrigger IconCls="custom-trigger" />
            </Triggers>
            <Listeners>
                <TriggerClick Handler="Ext.Msg.alert('Message', 'You Clicked the Trigger!');" />
            </Listeners>
        </ext:TriggerField>
        
       
    </form>
</body>
</html>
