<%@ Control Language="C#"  %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<ext:Window ID="ImgChooserDlg" runat="server"
    Height="400"
    Width="600"
    Cls="img-chooser-dlg"
    Title="Choose an Image"
    Layout="BorderLayout"
    Border="false"
    BodyBorder="0">
    <Items>
        <ext:Panel runat="server" Region="Center" AutoScroll="true">
            <Items>
                <ext:UserControlLoader runat="server" Path="IconBrowser.ascx" />
            </Items>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:TextField runat="server" 
                            FieldLabel="Filter"
                            Width="150" 
                            LabelAlign="Right" 
                            LabelWidth="35">
                            <Listeners>
                                <Change Handler="var dataview = App.ImgChooserDlg.down('dataview'),
                                                    store = dataview.store;
                                    
                                    store.suspendEvents();
                                    store.clearFilter();
                                    dataview.getSelectionModel().clearSelections();
                                    store.resumeEvents();
                                    store.filter({
                                        property: 'name',
                                        anyMatch: true,
                                        value   : newValue
                                    });" Buffer="50" />
                            </Listeners>
                        </ext:TextField>

                        <ext:ToolbarSpacer runat="server" />

                        <ext:ComboBox runat="server"
                            FieldLabel="Sort By"
                            LabelAlign="Right"
                            LabelWidth="45"
                            Width="150"
                            Editable="false">
                            <Items>
                                <ext:ListItem Text="Name" Value="name" />
                                <ext:ListItem Text="Size" Value="size" />
                            </Items>
                            <Listeners>
                                <Select Handler="App.ImgChooserDlg.down('dataview').store.sort(this.getValue());" />
                            </Listeners>
                        </ext:ComboBox>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>

        <ext:UserControlLoader runat="server" Path="InfoPanel.ascx" />
    </Items>

    <Buttons>
        <ext:Button runat="server" Text="OK">
            <Listeners>
                <Click Handler="var image = App.ImgChooserDlg.down('dataview').selModel.getSelection()[0];
                    if (image) {
                        var imageEl = Ext.fly('images').createChild({
                            tag: 'img',
                            src: image.get('url')
                        });
                        imageEl.hide().show({duration: 500}).frame();
                        var win = this.up('window');
                        win.animateTarget = imageEl;
                        win.hide();
                    }" />
            </Listeners>
        </ext:Button>

        <ext:Button runat="server" Text="Cancel">
            <Listeners>
                <Click Handler="this.up('window').hide();" />
            </Listeners>
        </ext:Button>
    </Buttons>
</ext:Window>