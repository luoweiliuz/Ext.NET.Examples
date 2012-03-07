<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <link href="../resources/css/examples.css" rel="stylesheet" type="text/css" />    
    <link rel="stylesheet" type="text/css" href="../resources/css/main.css" />
</head>
<body>
    <ext:ResourceManager runat="server" />
    <img src="../resources/images/ext_net_logo_small.gif" />
    
    <p>&nbsp;</p>

    <ext:GridPanel
        ID="GridPanel1"
        runat="server" 
        Title="Recent SVN Commits" 
        Region="Center"
        Width="850" 
        Height="500">
        <Store>
            <ext:Store runat="server">
                <Proxy>
                    <ext:JsonPProxy Url="http://api.ext.net/log/get/">
                        <Reader>
                            <ext:JsonReader Root="data" />
                        </Reader>
                    </ext:JsonPProxy>
                </Proxy>
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="revision" />
                            <ext:ModelField Name="author" />
                            <ext:ModelField Name="date" Type="Date" />
                            <ext:ModelField Name="tag" />
                            <ext:ModelField Name="message" />
                            <ext:ModelField Name="actions" IsComplex="true" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column runat="server" Text="Revision" DataIndex="revision" />
                <ext:Column runat="server" Text="Author" DataIndex="author" />
                <ext:DateColumn runat="server" Text="Date" DataIndex="date" Format="yyyy-MM-dd" />
                <ext:Column runat="server" Text="Tag" DataIndex="tag" />
                <ext:Column runat="server" Text="Message" DataIndex="message" Flex="1" />
            </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:RowSelectionModel runat="server" Mode="Multi" />
        </SelectionModel>
        <View>
            <ext:GridView runat="server" TrackOver="true" LoadMask="true" />
        </View>
        <Features>
            <ext:GridFilters runat="server" Local="true">
                <Filters>
                    <ext:NumericFilter DataIndex="revision" />
                    <ext:ListFilter DataIndex="author" Options="vladimir,Daniil.Veriga,geoffrey.mcgill" />
                    <ext:DateFilter DataIndex="date" />
                    <ext:ListFilter DataIndex="tag" Options="NEW,FIX,UPDATE" />
                    <ext:StringFilter DataIndex="message" />
                </Filters>
            </ext:GridFilters>
        </Features>
        <Plugins>
            <ext:RowExpander runat="server">
                <Template runat="server">
                    <Html>
                        <div style="padding:5px;">
						<b>Description:</b><br /> 
                            <div style="margin-left: 25px;">{message}</div>
                        <br />
						<b>Actions:</b>
                            <ol style="margin-left:25px !important; list-style-type: decimal !important;">
                                <tpl for="actions"><li>{description}</li></tpl>
                            </ol>
                        </div>
					</Html>
                </Template>
            </ext:RowExpander>
        </Plugins>
    </ext:GridPanel>
</body>
</html>
