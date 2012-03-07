<%@ Control Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Ext.Net.Utilities.ControlUtils.FindControls<Ext.Net.SplitButton>(this).ForEach(
            delegate(Ext.Net.SplitButton button)
                {
                    Ext.Net.Menu menu = new Ext.Net.Menu();
                    menu.Items.Add(new Ext.Net.MenuItem("Menu Item 1"));
                    menu.Items.Add(new Ext.Net.MenuItem("Menu Item 2"));
                    menu.Items.Add(new Ext.Net.MenuItem("Menu Item 3"));
                    
                    button.Menu.Add(menu);
                });
    }
</script>

<h1>Split Buttons</h1>

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
        <ext:SplitButton runat="server" Text="Add User" />
        <ext:SplitButton runat="server" Text="Add User" Scale="Medium" />
        <ext:SplitButton runat="server" Text="Add User" Scale="Large" />
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
        <ext:SplitButton runat="server" IconCls="add16" />
        <ext:SplitButton runat="server" IconCls="add24" Scale="Medium" />
        <ext:SplitButton runat="server" IconCls="add32" Scale="Large" />
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
        <ext:SplitButton runat="server" Text="Add User" IconCls="add16" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add24" Scale="Medium" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add32" Scale="Large" />
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
        <ext:SplitButton runat="server" Text="Add User" IconCls="add16" IconAlign="Top" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add24" Scale="Medium" IconAlign="Top" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add32" Scale="Large" IconAlign="Top" />
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
        <ext:SplitButton runat="server" Text="Add User" IconCls="add16" IconAlign="Right" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add24" Scale="Medium" IconAlign="Right" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add32" Scale="Large" IconAlign="Right" />
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
        <ext:SplitButton runat="server" Text="Add User" IconCls="add16" IconAlign="Bottom" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add24" Scale="Medium" IconAlign="Bottom" />
        <ext:SplitButton runat="server" Text="Add User" IconCls="add32" Scale="Large" IconAlign="Bottom" />
    </Items>
</ext:Panel>
