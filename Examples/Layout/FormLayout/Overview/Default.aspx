<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormLayouts built in markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>FormLayouts built in markup</h1>
        
        <h2>Form1 - Very Simple</h2>

        <ext:Panel 
            ID="Panel1" 
            runat="server" 
            Title="Simple Form"
            PaddingSummary="5px 5px 0"
            Width="350"
            Frame="true"
            ButtonAlign="Center"
            Layout="AnchorLayout">
            <Items>
                <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" AnchorHorizontal="100%" />
                <ext:TextField runat="server" FieldLabel="Last Name" AnchorHorizontal="100%" />
                <ext:TextField runat="server" FieldLabel="Company" AnchorHorizontal="100%" />
                <ext:TextField runat="server" FieldLabel="Email" Vtype="email" AnchorHorizontal="100%" />
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>

        <h2>Form 2 - Adding fieldsets</h2>
        
        <ext:Panel 
            ID="Panel2" 
            runat="server"
            Title="Simple Form with FieldSets"
            PaddingSummary="5px 5px 0"
            Width="350"
            Frame="true"
            ButtonAlign="Center">
            <Items>
                <ext:FieldSet 
                    runat="server"
                    CheckboxToggle="true"
                    Title="User Information"
                    AutoHeight="true"
                    Collapsed="true"
                    Layout="AnchorLayout">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" AnchorHorizontal="100%" />
                        <ext:TextField runat="server" FieldLabel="Last Name" AnchorHorizontal="100%" />
                        <ext:TextField runat="server" FieldLabel="Company" AnchorHorizontal="100%" />
                        <ext:TextField runat="server" FieldLabel="Email" AnchorHorizontal="100%" />
                    </Items>
                </ext:FieldSet>
                <ext:FieldSet
                    runat="server"
                    CheckboxToggle="true"
                    Title="Phone Number"
                    AutoHeight="true"
                    Layout="AnchorLayout">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:TextField runat="server" FieldLabel="Home" Text="(888) 555-1212" AnchorHorizontal="100%" />
                        <ext:TextField runat="server" FieldLabel="Business" AnchorHorizontal="100%" />
                        <ext:TextField runat="server" FieldLabel="Mobile" AnchorHorizontal="100%" />
                        <ext:TextField runat="server" FieldLabel="Fax" AnchorHorizontal="100%" />
                    </Items>
                </ext:FieldSet>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>
        
        <h2>Form 3 - A little more complex</h2>
        
        <ext:Panel 
            ID="Panel3"
            runat="server" 
            Title="Multi Column, Nested Layouts and Anchoring" 
            Frame="true"
            PaddingSummary="5px 5px 0"
            Width="600"
            ButtonAlign="Center">
            <Items>
                <ext:Container runat="server" Layout="Column" Height="100">
                    <Items>
                        <ext:Container runat="server" Layout="AnchorLayout" ColumnWidth=".5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" AnchorHorizontal="95%" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Company" AnchorHorizontal="95%" LabelAlign="Top"  />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="AnchorLayout" ColumnWidth=".5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Last Name" AnchorHorizontal="95%" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Email" AnchorHorizontal="95%" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:Container>
                <ext:Container runat="server" Layout="AnchorLayout">
                    <Items>
                        <ext:HtmlEditor runat="server" Height="200" FieldLabel="Biography" AnchorHorizontal="98%" LabelAlign="Top" />
                    </Items>
                </ext:Container>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>
        
        <h2>Form 4 - Forms can be a TabPanel...</h2>
        
        <ext:Panel
            ID="Panel4"
            runat="server"
            Border="false"
            Width="350"
            ButtonAlign="Center"
            Layout="Fit">
            <Items>
                <ext:TabPanel runat="server" ActiveTabIndex="0">
                    <Items>
                        <ext:Panel 
                            runat="server" 
                            Title="Personal Details" 
                            AutoHeight="true" 
                            BodyPadding="10"
                            Layout="AnchorLayout">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" AnchorHorizontal="100%" />
                                <ext:TextField runat="server" FieldLabel="Last Name" AnchorHorizontal="100%" />
                                <ext:TextField runat="server" FieldLabel="Company" AnchorHorizontal="100%" />
                                <ext:TextField runat="server" FieldLabel="Email" AnchorHorizontal="100%" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel 
                            runat="server"
                            Title="Phone Numbers"
                            AutoHeight="true"
                            BodyPadding="10"
                            Layout="AnchorLayout">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Home" Text="(888) 555-1212" AnchorHorizontal="100%" />
                                <ext:TextField runat="server" FieldLabel="Business" AnchorHorizontal="100%" />
                                <ext:TextField runat="server" FieldLabel="Mobile" AnchorHorizontal="100%" />
                                <ext:TextField runat="server" FieldLabel="Fax" AnchorHorizontal="100%" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>
        
        <h2>Form 5 - Form with TabPanel</h2>
        
        <ext:Panel
            ID="Panel5"
            runat="server"
            Title="Inner Tabs"
            Width="600"
            BodyPadding="5"
            ButtonAlign="Center">
            <Items>
                <ext:Container runat="server">
                    <Items>
                        <ext:Container runat="server" Layout="AnchorLayout" ColumnWidth=".5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" AnchorHorizontal="95%" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Company" AnchorHorizontal="95%" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                        <ext:Container runat="server" Layout="AnchorLayout" ColumnWidth=".5">
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Last Name" AnchorHorizontal="95%" LabelAlign="Top" />
                                <ext:TextField runat="server" FieldLabel="Email" AnchorHorizontal="95%" LabelAlign="Top" />
                            </Items>
                        </ext:Container>
                    </Items>
                </ext:Container>
                <ext:TabPanel 
                    runat="server" 
                    ActiveTabIndex="0" 
                    Plain="true"
                    Height="235">
                    <Items>
                        <ext:Panel
                            runat="server" 
                            Title="Personal Details" 
                            AutoHeight="true" 
                            BodyPadding="10"
                            Layout="AnchorLayout">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                                <ext:Parameter Name="LabelAlign" Value="top" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="First Name" AllowBlank="false" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Last Name" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Company" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Email" Width="230" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Title="Phone Numbers"
                            AutoHeight="true" 
                            BodyPadding="10"
                            Layout="AnchorLayout">
                            <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                                <ext:Parameter Name="LabelAlign" Value="top" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Home" Text="(888) 555-1212" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Business" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Mobile" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Fax" Width="230" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel
                            runat="server"
                            Title="Biography"
                            BodyPadding="10"
                            Layout="Fit">
                            <Items>
                                <ext:HtmlEditor runat="server" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel 
                            ID="Tab4"
                            runat="server"
                            Title="Tab 4"
                            Layout="AnchorLayout"
                            BodyPadding="10" >
                             <Defaults>
                                <ext:Parameter Name="LabelWidth" Value="75" Mode="Raw" />
                                <ext:Parameter Name="LabelAlign" Value="top" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" FieldLabel="Name" Width="230" />
                                <ext:TextField runat="server" FieldLabel="Age" Width="230" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" />
                <ext:Button runat="server" Text="Cancel" />
            </Buttons>
        </ext:Panel>
    </form>
</body>
</html>