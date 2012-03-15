<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multiple DateFields with DateRange Validation - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var onKeyUp = function (field) {
            var v = this.getRawValue(),
                field;

            if (this.startDateField) {
                field = Ext.getCmp(this.startDateField);
                field.setMaxValue();
                this.dateRangeMax = null;
            } else if (this.endDateField) {
                field = Ext.getCmp(this.endDateField);
                field.setMinValue();
                this.dateRangeMin = null;
            }

            field.validate();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Multiple DateFields with DateRange Validation</h1>
        
        <p>This example demonstrates two date fields acting as a date range. Selecting an initial date sets the minimum value for the end field. Selecting an ending date sets a maximum value for the start field.</p>
        
        <p>If a value is specified / selected in the 'DateField1 field', the 'DateField2 field' doesn't allow any date prior to the 'DateField1' entry to be specified / selected and vice versa.</p>
        
        <ext:Window 
            runat="server" 
            Width="350"
            Title="DateRange"
            Icon="Date"
            AutoHeight="true"
            Closable="false"
            BodyPadding="5"
            Layout="Anchor"
            DefaultAnchor="100%">
            <Items>
                <ext:DateField 
                    ID="DateField1" 
                    runat="server"
                    Vtype="daterange"
                    FieldLabel="To"
                    EnableKeyEvents="true">  
                    <CustomConfig>
                        <ext:ConfigItem Name="endDateField" Value="DateField2" Mode="Value" />
                    </CustomConfig>
                    <Listeners>
                        <KeyUp Fn="onKeyUp" />
                    </Listeners>
                </ext:DateField>
                
                <%--// Alternative syntax using custom config property attributes. --%>

                <%--<ext:DateField 
                    ID="DateField1" 
                    runat="server" 
                    FieldLabel="To"
                    Vtype="daterange"
                    EndDateField="DateField2"
                    EnableKeyEvents="true">
                    <Listeners>
                        <KeyUp Fn="onKeyUp" />
                    </Listeners>
                 </ext:DateField>--%>
                    
                <ext:DateField 
                    ID="DateField2"
                    runat="server" 
                    Vtype="daterange"
                    FieldLabel="From"
                    EnableKeyEvents="true">    
                    <CustomConfig>
                        <ext:ConfigItem Name="startDateField" Value="DateField1" Mode="Value" />
                    </CustomConfig>
                    <Listeners>
                        <KeyUp Fn="onKeyUp" />
                    </Listeners>
                </ext:DateField>
                
                
                <%--// Alternative syntax using custom config property attributes. --%>
                
                <%--<ext:DateField 
                    ID="DateField2" 
                    runat="server" 
                    Vtype="daterange"
                    FieldLabel="From"
                    StartDateField="DateField1"
                    EnableKeyEvents="true">
                    <Listeners>
                        <KeyUp Fn="onKeyUp" />
                    </Listeners>
                 </ext:DateField>--%>  
            </Items>           
        </ext:Window>                
   </form>
</body>
</html>
