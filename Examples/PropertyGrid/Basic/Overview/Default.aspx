<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        //PropertyGrid1.Source contains changed data
        //you can handle this data: read, save and etc

        StringBuilder html = new StringBuilder();
        html.Append("<table class=\"data\">");
        html.Append("<tr><th>Name</th><th>Value</th></tr>");

        // Loop through all PropertyGridParameters and reference by Index. 

        foreach (PropertyGridParameter param in this.PropertyGrid1.Source)
        {
            html.Append("<tr>");
            html.Append("<td>" + param.Name + "</td>");
            html.Append("<td>" + param.Value.ToString() + "</td>");
            html.Append("</tr>");
        }
        html.Append("</table>");

        this.Label1.Html = html.ToString();

        // Data can be referenced by the PropertyGridParameter 
        // "Name" value as well.
        // string name = this.PropertyGrid1.Source["(name)"].Value;
    }

    protected void AddPropertyClick(object sender, DirectEventArgs e)
    {
        PropertyGrid1.AddProperty(new PropertyGridParameter
        {
            Name = "dynProp1",
            Value = "DynamicValue",
            DisplayName = "Dynamic Property",
            Renderer =
            {
                Handler = "metadata.tdCls = 'red-label'; return value;"
            },
            Editor =
            {
                new TriggerField
                {
                   Triggers = 
                   {
                      new FieldTrigger
                      {
                         Icon = TriggerIcon.SimpleEllipsis,
                         Tag = "ellipsis"   
                      }
                   }, 
                   
                   Listeners = 
                   {
                      TriggerClick = {
                          Handler = PropertyGrid1.ClientID + ".editingPlugin.stopEditing(); Ext.Msg.alert('Trigger click', tag + ' trigger click');"   
                      }    
                   }
                }
            }
        });
        PropertyGrid1.DoLayout();
    }

    protected void RemovePropertyClick(object sender, DirectEventArgs e)
    {
        PropertyGrid1.RemoveProperty("dynProp1");
        PropertyGrid1.DoLayout();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>PropertyGrid with Button DirectEvent - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .data th {
        	font-weight : bold;
        }
        
        .data th, .data td {
            padding : 4px;
            border  : 1px solid black;
        }
        
        .red-label{
            color:Red;
        }
        
        .blue-label{
            color:Blue;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>PropertyGrid with Button DirectEvent</h1>
        
        <ext:PropertyGrid 
            ID="PropertyGrid1" 
            runat="server" 
            Width="300" 
            AutoHeight="true"
            ForceFit="true">
            <Source>
                <ext:PropertyGridParameter Name="(name)" Value="Properties Grid" />
                <ext:PropertyGridParameter Name="grouping" Value="false" Mode="Raw" />
                <ext:PropertyGridParameter Name="autoFitColumns" Value="true" Mode="Raw" />
                <ext:PropertyGridParameter Name="productionQuality" Value="false" Mode="Raw" />
                <ext:PropertyGridParameter Name="created" Value="10/15/2006">
                    <Editor>
                        <ext:DateField runat="server" />
                    </Editor>
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="tested" Value="false" Mode="Raw">
                    <Renderer Handler="metadata.tdCls = 'red-label'; return value;" />
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="version" Value="0.01" />
                <ext:PropertyGridParameter Name="borderWidth" Value="5" Mode="Raw">
                    <Editor>
                        <ext:NumberField runat="server" />
                    </Editor>
                </ext:PropertyGridParameter>
                <ext:PropertyGridParameter Name="trigger" Value="TriggerField" DisplayName="Trigger Field">
                    <Renderer Handler="metadata.tdCls = 'blue-label'; return value;" />
                    <Editor>
                        <ext:TriggerField runat="server">
                            <Triggers>
                                <ext:FieldTrigger Icon="SimpleEllipsis" Tag="ellipsis" />
                            </Triggers>
                            <Listeners>
                                <TriggerClick Handler="#{PropertyGrid1}.editingPlugins.stopEditing(); Ext.Msg.alert('Trigger click', tag + ' trigger click');" />
                            </Listeners>
                        </ext:TriggerField>
                    </Editor>
                </ext:PropertyGridParameter>
            </Source>

            <Buttons>
                <ext:Button runat="server" Text="Add property">
                    <DirectEvents>
                        <Click OnEvent="AddPropertyClick" />
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" Text="Remove property">
                    <DirectEvents>
                        <Click OnEvent="RemovePropertyClick" />
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" ID="Button1" Text="Save" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="Button1_Click" />
                    </DirectEvents>
                </ext:Button>                
            </Buttons>           
        </ext:PropertyGrid>
        
        <p><ext:Label ID="Label1" runat="server" /></p>
    </form>

</body>
</html>