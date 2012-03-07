<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<%@ Register Src="modules/AccordionWindow.ascx" TagPrefix="mod" TagName="AccordionWindow" %>
<%@ Register Src="modules/GridWindow.ascx" TagPrefix="mod" TagName="GridWindow" %>
<%@ Register Src="modules/WhatsNew.ascx" TagPrefix="mod" TagName="WhatsNew" %>
<%@ Register Src="modules/SystemStatus.ascx" TagPrefix="mod" TagName="SystemStatus" %>

<script runat="server">
    protected void Logout_Click(object sender, DirectEventArgs e)
    {
        // Logout from Authenticated Session
        this.Response.Redirect("Default.aspx");
    }

    [DirectMethod(ShowMask = true)]
    public void CreateWindow()
    {
        Desktop.GetInstance().CreateWindow(new Window 
        { 
            Title = "New window",
            Width = 300,
            Height = 300,
            CloseAction = CloseAction.Destroy,
            Html="The window is created"
        });
    }

    [DirectMethod(ShowMask=true)]
    public void AddNewModule()
    {
        Desktop.GetInstance().RemoveModule("add-module");
        var control = Ext.Net.Utilities.ControlUtils.FindControl<Ext.Net.DesktopModuleProxy>(this.LoadControl("modules/TabWindow.ascx"));        
        control.RegisterModule();        
    }

    [DirectMethod(ShowMask = true)]
    public void AddAnotherModule()
    {
        Desktop.GetInstance().RemoveModule("add1-module");
        var m = new DesktopModule
        {
            ModuleID = "dyn-mod",
            Shortcut = new DesktopShortcut
            {
                Name = "Dynamic Module"
            },

            Launcher = new Ext.Net.MenuItem
            {
                Text = "Dynamic module"
            },

            Window = 
            {
                new Window 
                { 
                    Title = "Dynamic Window",
                    Width = 300,
                    Height = 300,
                    DefaultRenderTo = Ext.Net.DefaultRenderTo.Form,
                    Icon = Icon.ApplicationAdd                    
                }
            },

            AutoRun = true
        };

        Desktop1.AddModule(m);
    }
</script>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>Ext.NET Examples</title>

    <link href="resources/desktop.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var tile = function () {
            Ext.ComponentQuery.query('desktop')[0].tileWindows();
        };

        var cascade = function () {
            Ext.ComponentQuery.query('desktop')[0].cascadeWindows();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" /> 

        <ext:Desktop ID="Desktop1" runat="server">            
            <Modules>
                <ext:DesktopModule ModuleID="Hello" AutoRun="true">
                    <Window>
                        <ext:Window runat="server" 
                            Plain="true"
                            Padding="10"
                            Width="150"
                            Height="100"                                                        
                            Title="Greeting" 
                            CloseAction="Destroy" 
                            Maximizable="false" 
                            Minimizable="false">
                            <Content>
                                Welcome to Ext.Net desktop!
                            </Content>
                        </ext:Window>
                    </Window>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="notepad">
                    <Shortcut Name="Notepad" IconCls="x-notepad-shortcut"  SortIndex="2" />                       
                    <Launcher Text="Notepad" Icon="ApplicationForm" />
                    <Window>
                        <ext:Window runat="server"
                            Title="Notepad"
                            Width="600"
                            Height="400"
                            Icon="ApplicationForm"
                            AnimCollapse="false"
                            Border="false"
                            HideMode="Offsets"
                            Layout="FitLayout"
                            CloseAction="Destroy">
                            <Items>
                                <ext:HtmlEditor runat="server" Text="Some <b>rich</b> <font color='red'>text</font> goes <u>here</u><br>Give it a try!">
                                </ext:HtmlEditor>
                            </Items>
                        </ext:Window>
                    </Window>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="create-module">
                    <Shortcut Name="Create window" Handler="function() {#{DirectMethods}.CreateWindow();}" SortIndex="3">
                    </Shortcut>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="add-module">
                    <Shortcut Name="Render dynamic module" Handler="function() {#{DirectMethods}.AddNewModule();}" X="200" Y="100" TextCls="x-long-label">                        
                    </Shortcut>
                </ext:DesktopModule>

                <ext:DesktopModule ModuleID="add1-module">
                    <Shortcut Name="Render another module" Handler="function() {#{DirectMethods}.AddAnotherModule();}" X="200" Y="300" TextCls="x-long-label">                        
                    </Shortcut>
                </ext:DesktopModule>
            </Modules>

            <DesktopConfig Wallpaper="resources/wallpapers/blue.jpg" ShortcutDragSelector="true">
                <ShortcutDefaults IconCls="x-default-shortcut" />
                <ContextMenu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem runat="server" Text="Change Settings" />
                            <ext:MenuSeparator runat="server" />
                            <ext:MenuItem runat="server" Text="Tile" Handler="tile" Icon="ApplicationTileVertical" />
                            <ext:MenuItem runat="server" Text="Cascade" Handler="cascade" Icon="ApplicationCascade" />
                        </Items>
                    </ext:Menu>
                </ContextMenu>

                <Content>
                   <ext:Image runat="server" ImageUrl="resources/logo.png" StyleSpec="position:absolute;top: 50%;left: 50%;width: 77px; height: 78px;margin-top: -39px; margin-left: -39px;"/> 
                   <ext:Image runat="server" ImageUrl="resources/powered.png" StyleSpec="position:absolute;right:10px;bottom:20px;"/> 
                </Content>
            </DesktopConfig>

            <StartMenu Title="Ext.Net Desktop" Icon="Application" Height="300">
                <ToolConfig>
                    <ext:Toolbar runat="server" Width="100">
                        <Items>
                            <ext:Button runat="server" Text="Settings" Icon="Cog" />
                            <ext:Button runat="server" Text="Logout" Icon="Key">
                                <DirectEvents>
                                    <Click OnEvent="Logout_Click">
                                        <EventMask ShowMask="true" Msg="Good Bye..." MinDelay="1000" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </ToolConfig>
            </StartMenu>

            <TaskBar TrayWidth="100">
                <QuickStart>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button runat="server" Handler="tile" Icon="ApplicationTileVertical">
                                <QTipCfg Text="Tile windows" />
                            </ext:Button>

                            <ext:Button runat="server" Handler="cascade" Icon="ApplicationCascade">
                                <QTipCfg Text="Cascade windows" />
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </QuickStart>

                <Tray>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button ID="LangButton" runat="server" Text="EN" MenuArrow="false" Cls="x-bold-text" MenuAlign="br-tr">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:CheckMenuItem runat="server" Group="lang" Text="English" Checked="true" CheckHandler="function(item, checked) {checked && #{LangButton}.setText('EN');}" />
                                            <ext:CheckMenuItem runat="server" Group="lang" Text="French" CheckHandler="function(item, checked) {checked && #{LangButton}.setText('FR');}" />
                                            <ext:MenuSeparator runat="server" />
                                            <ext:MenuItem runat="server" Text="Show the Language Bar" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:Button>
                            <ext:ToolbarFill runat="server" />
                        </Items>
                    </ext:Toolbar>
                </Tray>
            </TaskBar>
        </ext:Desktop>

        <%--Modules from User controls--%>
        <mod:AccordionWindow runat="server" />
        <mod:GridWindow runat="server" />
        <mod:SystemStatus runat="server" />
        <mod:WhatsNew runat="server" />
    </form>  
</body>
</html>