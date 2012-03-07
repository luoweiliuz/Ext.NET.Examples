<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../resources/css/main.css" />

    <script type="text/javascript">
        Ext.onReady(function () {
            if (top !== self) {
                Ext.select("a").on("click", function (e, el) { parent.location = el.href; }, null, { preventDefault : true });
            }
        });
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server" Cls="welcome" Layout="VBoxLayout">
        <Items>
            <ext:Container runat="server" Height="185">
                <Content>
                    <div id="welcome-title">
		                <div>Rapidly Build</div>
		                <span>Your Vision</span>
	                </div>
	                <div id="welcome-links">
		                <div id="title">Popular Examples</div>
		                <div class="list">
                            <ext:Container runat="server" Title="links" Layout="HBoxLayout">
                                <Items>
                                    <ext:Container runat="server" Flex="1">
                                        <Content>
                                            <p><span>1</span><a href="/#/Getting_Started/Introduction/Overview/">Getting Started</a></p>
                                            <p><span>2</span><a href="/#/Events/DirectEvents/Overview/">DirectEvents</a></p>
                                            <p><span>3</span><a href="/#/Events/DirectMethods/Overview/">DirectMethods</a></p>
                                        </Content>
                                    </ext:Container>
                                    <ext:Container runat="server" Flex="1">
                                        <Content>
                                            <p><span>4</span><a href="/#/GridPanel/ArrayGrid/ArrayWithPaging/">GridPanel</a></p>
                                            <p><span>5</span><a href="/#/ViewPort/Basic/Built_in_Markup/">ViewPort</a></p>
                                            <p><span>6</span><a href="/#/XRender/Basic/Add_Items/">XRender</a></p>
                                        </Content>
                                    </ext:Container>
                                </Items>
                            
                            </ext:Container>
		                </div>
	                </div>
                </Content>
            </ext:Container>

            <ext:Container runat="server">
                <Content>
                    <div id="welcome-grid">
		                <a href="/#/Getting_Started/Introduction/Component_Overview/" id="grid-badge">Component Overview</a>
		                <div id="screens"></div>
		                <div id="buttons">
			                <a href="/#/GridPanel/ArrayGrid/ArrayWithPaging/">GridPanel &#187;</a>
			                <a href="/#/Desktop/Introduction/Overview/">Desktop &#187;</a>
			                <a href="/#/Chart/Area/Basic/">Charts &#187;</a>
			                <a href="/#/Portal/Basic/Deluxe/">Portal &#187;</a>
			                <a href="/#/Calendar/Overview/Basic/">Calendar &#187;</a>
		                </div>
	                </div>
                </Content>
            </ext:Container>

            <ext:Container runat="server">
                <Content>
                    <div id="welcome-footer">
		                <span>
			                <p>100+ Components and 300+ Samples for use in your ASP.NET WebForm and MVC Applications.</p>
		                </span>
	                </div>
                </Content>
            </ext:Container>
        </Items>
    </ext:Viewport>
</body>
</html>
