<%@ Control Language="C#" %>

<%@ Import Namespace="Ext.Net.Utilities" %>
<%@ Import Namespace="Button=Ext.Net.Button" %>
<%@ Import Namespace="Menu=Ext.Net.Menu" %>
<%@ Import Namespace="MenuItem=Ext.Net.MenuItem" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        ControlUtils.FindControls<Button>(this).ForEach(
            delegate(Button button)
                {
                    Menu menu = new Menu();
                    menu.Items.Add(new MenuItem("Menu Item 1"));
                    menu.Items.Add(new MenuItem("Menu Item 2"));
                    menu.Items.Add(new MenuItem("Menu Item 3"));
                    
                    button.Menu.Add(menu);
                });
    }
</script>

<h1>Menu Buttons</h1>

<ext:Panel 
    runat="server" 
    BaseCls="x-plain" 
    Cls="btn-panel" 
    Layout="TableLayout">
    <LayoutConfig>
        <ext:TableLayoutConfig Columns="3" />
    </LayoutConfig>
    <Items>
        <ext:Panel runat="server" Border="false" ColSpan="3" BodyStyle="background:transparent;">
            <Content>
                <h3 style="padding: 15px 0 3px;">Text Only</h3>
            </Content>
        </ext:Panel>
        <ext:Button runat="server" Text="Add User" />
        <ext:Button runat="server" Text="Add User" Scale="Medium" />
        <ext:Button runat="server" Text="Add User" Scale="Large" />
    </Items>
</ext:Panel>

<ext:Panel 
    runat="server" 
    BaseCls="x-plain" 
    Cls="btn-panel" 
    Layout="TableLayout">
    <LayoutConfig>
        <ext:TableLayoutConfig Columns="3" />
    </LayoutConfig>
    <Items>
        <ext:Panel runat="server" Border="false" ColSpan="3" BodyStyle="background:transparent;">
            <Content>
                <h3 style="padding: 15px 0 3px;">Icon Only</h3>
            </Content>
        </ext:Panel>
        <ext:Button runat="server" IconCls="add16" />
        <ext:Button runat="server" IconCls="add24" Scale="Medium" />
        <ext:Button runat="server" IconCls="add32" Scale="Large" />
    </Items>
</ext:Panel>

<ext:Panel 
    runat="server" 
    BaseCls="x-plain" 
    Cls="btn-panel" 
    Layout="TableLayout">
    <LayoutConfig>
        <ext:TableLayoutConfig Columns="3" />
    </LayoutConfig>
    <Items>
        <ext:Panel runat="server" Border="false" ColSpan="3" BodyStyle="background:transparent;">
            <Content>
                <h3 style="padding: 15px 0 3px;">Icon and Text (left)</h3>
            </Content>
        </ext:Panel>
        <ext:Button runat="server" Text="Add User" IconCls="add16" />
        <ext:Button runat="server" Text="Add User" IconCls="add24" Scale="Medium" />
        <ext:Button runat="server" Text="Add User" IconCls="add32" Scale="Large" />
    </Items>
</ext:Panel>

<ext:Panel 
    runat="server" 
    BaseCls="x-plain" 
    Cls="btn-panel" 
    Layout="TableLayout">
    <LayoutConfig>
        <ext:TableLayoutConfig Columns="3" />
    </LayoutConfig>
    <Items>
        <ext:Panel runat="server" Border="false" ColSpan="3" BodyStyle="background:transparent;">
            <Content>
                <h3 style="padding: 15px 0 3px;">Icon and Text (top)</h3>
            </Content>
        </ext:Panel>
        <ext:Button runat="server" Text="Add User" IconCls="add16" IconAlign="Top" />
        <ext:Button runat="server" Text="Add User" IconCls="add24" Scale="Medium" IconAlign="Top" />
        <ext:Button runat="server" Text="Add User" IconCls="add32" Scale="Large" IconAlign="Top" />
    </Items>
</ext:Panel>

<ext:Panel 
    runat="server" 
    BaseCls="x-plain" 
    Cls="btn-panel" 
    Layout="TableLayout">
    <LayoutConfig>
        <ext:TableLayoutConfig Columns="3" />
    </LayoutConfig>
    <Items>
        <ext:Panel runat="server" Border="false" ColSpan="3" BodyStyle="background:transparent;">
            <Content>
                <h3 style="padding: 15px 0 3px;">Icon and Text (right)</h3>
            </Content>
        </ext:Panel>
        <ext:Button runat="server" Text="Add User" IconCls="add16" IconAlign="Right" />
        <ext:Button runat="server" Text="Add User" IconCls="add24" Scale="Medium" IconAlign="Right" />
        <ext:Button runat="server" Text="Add User" IconCls="add32" Scale="Large" IconAlign="Right" />
    </Items>
</ext:Panel>

<ext:Panel 
    runat="server" 
    BaseCls="x-plain" 
    Cls="btn-panel" 
    Layout="TableLayout">
    <LayoutConfig>
        <ext:TableLayoutConfig Columns="3" />
    </LayoutConfig>
    <Items>
        <ext:Panel runat="server" Border="false" ColSpan="3" BodyStyle="background:transparent;">
            <Content>
                <h3 style="padding: 15px 0 3px;">Icon and Text (bottom)</h3>
            </Content>
        </ext:Panel>
        <ext:Button runat="server" Text="Add User" IconCls="add16" IconAlign="Bottom" />
        <ext:Button runat="server" Text="Add User" IconCls="add24" Scale="Medium" IconAlign="Bottom" />
        <ext:Button runat="server" Text="Add User" IconCls="add32" Scale="Large" IconAlign="Bottom" />
    </Items>
</ext:Panel>
