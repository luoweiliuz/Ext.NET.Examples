<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scrolling - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var renderTopic = function(value, p, record) {
            return Ext.String.format(
                '<a href="http://sencha.com/forum/showthread.php?t={2}" target="_blank">{0}</a>',
                value,
                record.data.forumtitle,
                record.getId(),
                record.data.forumid
            );
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Infinite Scrolling</h1>

        <p>Ext.Net 2's brand new grid supports infinite scrolling, which enables you to load any number of records into a grid without paging.</p>
        
        <p>The new grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>
        
        <ext:GridPanel 
            runat="server" 
            Width="700" 
            Height="500"
            
            Title="ExtJS.com - Browse Forums">
            <Store>
                <ext:Store 
                    runat="server" 
                    RemoteSort="true" 
                    Buffered="true" 
                    AutoLoad="false">
                    <Proxy>
                        <ext:JsonPProxy Url="http://www.sencha.com/forum/remote_topics/index.php" SimpleSortMode="true">
                            <Reader>
                                <ext:JsonReader Root="topics" TotalProperty="totalCount" />
                            </Reader>
                        </ext:JsonPProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server" IDProperty="threadid">
                            <Fields>
                                <ext:ModelField Name="title" />
                                <ext:ModelField Name="forumtitle" />
                                <ext:ModelField Name="forumid" />
                                <ext:ModelField Name="author" />
                                <ext:ModelField Name="replycount" Type="Int" />
                                <ext:ModelField Name="lastpost" Mapping="lastpost" Type="Date" DateFormat="timestamp" /> 
                                <ext:ModelField Name="lastposter" />
                                <ext:ModelField Name="excerpt" />
                                <ext:ModelField Name="threadid" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="lastpost" Direction="DESC" />
                    </Sorters>
                </ext:Store>
            </Store>           
            <ColumnModel runat="server">
		        <Columns>
                    <ext:RowNumbererColumn runat="server" Width="50" Sortable="false" />
                    <ext:Column ID="topic" runat="server" Text="Topic" DataIndex="title" Flex="1" Sortable="false">
                        <Renderer Fn="renderTopic" />
                    </ext:Column>
                    <ext:Column runat="server" Text="Author" DataIndex="author" Width="100" Hidden="true" Sortable="true" />
                    <ext:Column runat="server" Text="Replies" DataIndex="replycount" Width="70" Align="Center" Sortable="false" />
                    <ext:Column runat="server" Text="Last Post" DataIndex="lastpost" Width="130" Sortable="true">
                        <Renderer Format="Date" FormatArgs="'n/j/Y g:i A'" />
                    </ext:Column>
		        </Columns>
            </ColumnModel>           
            <View>
                <ext:GridView runat="server" TrackOver="false" LoadMask="false">                    
                </ext:GridView>
            </View> 
            <SelectionModel>
                <ext:RowSelectionModel runat="server" PruneRemoved="false" Mode="Multi" />
            </SelectionModel>           
            <Listeners>
                <AfterRender Handler="var me = this; me.store.prefetch({start: 0, limit: 99, callback: function() { me.store.guaranteeRange(0, 49); }});" Delay="100" />                
            </Listeners>
        </ext:GridPanel>
    </form>
</body>
</html>