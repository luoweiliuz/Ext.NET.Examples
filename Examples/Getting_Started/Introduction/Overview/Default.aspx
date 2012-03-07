<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Getting Started - Ext.NET Examples</title>
    <link href="/resources/css/examples.css"  rel="stylesheet" type="text/css" />
    <base target="_blank" />
</head>
<body>
    <form runat="server">
        <h1>Welcome to the Ext.NET Examples Explorer</h1>
        
        <h2>Overview</h2>
        
        <p>Ext.NET is a toolkit of AJAX enabled ASP.NET Web Controls.</p>

        <p>Ext.NET includes the powerful cross-browser <a href="http://www.extjs.com/">ExtJS</a> JavaScript Library and 
            simplifies the development of powerful and rich AJAX enabled Web Applications.</p>

        <p>Both Open-Source (Community License) or Closed-Source (Professional License) are available. 
            The <a href="http://www.ext.net/license/">License Summary</a> outlines differences between the two licensing options. 
            The code and functionality of both the Community and Professional editions are essentially the same with the only effective difference being the License under which each is released.</p>
            
        <p>Direct access to the latest Ext.NET source code, via read-only SVN access, is available to all Professional Edition License holders with a valid Support Subscription. More information regarding
            Professional Edition Licenses and Support Subscriptions is available on the <a href="http://www.ext.net/products" />Product Summary</a>.</p>
            
        <h2>System Requirements</h2>
        
        <ol class="expanded">
            <li><a href="http://www.microsoft.com/visualstudio/">Visual Studio</a> 2005, 2008 or 2010, or</li>
            <li><a href="http://www.microsoft.com/express/vwd/">Visual Web Developer Express</a> 2005, 2008 or 2010</li>
            <li>.NET Framework 3.5 (only required to be installed on machine), you can code in .NET 2.0, 3.0 or 3.5</li>
        </ol>
        
        <h2>Getting Started (Step-by-Step)</h2>
        
        <ol class="expanded">
            <li>First ensure you have Visual Studio or Visual Web Developer Express installed on your computer.
                <div class="information"><p>If you do not have a copy of Visual Studio already installed, the <a href="http://www.microsoft.com/express/vwd/">Visual Web Developer Express Edition</a> is free to use and 
                is a great way to get started with ASP.NET and Ext.NET. The Ext.NET Components work exactly the same in both environments.</p></div></li>
            
            <li><p>A Manual installation package (.zip) is available for download at <a href="http://www.ext.net/download/">http://www.ext.net/download/</a>.</p></li>
            
            <li>Create your first "Web Site" Project.
                <ol style="list-style-type: lower-roman;">
                    <li>Open Visual Studio (or Visual Web Developer) and create a new "Web Site" project. From the File Menu, select New > Web Site.</li>
                    <li>The "New Web Site" dialog will open, ensure "ASP.NET Web Site" is selected from the list of Templates.</li>
                    <li>For your first project, the "Location" option of "File System" and default file path should be fine, or modify to fit your preference.</li>
                    <li>Please select your "Language" preference. Whether you choose "Visual C#" or "Visual Basic" is ultimately just dependent on personal coding preferences. 
                        Ext.NET is written in C#, but can be used in any .NET language, including Visual Basic or C#.</li>
                    <li>Click "OK".</li>
                </ol>
            </li>
            
            <li>Add the Ext.NET Controls to your Visual Studio (or Visual Web Developer) Toolbox, see also <a href="http://ext.net/support/readme.txt">README.txt</a>
                <ol style="list-style-type: lower-roman;">
                    <li>Open Visual Studio or Visual Web Developer Express</li>
                    <li>Open an existing web site or create a new web site project.</li>
                    <li>Open or create a new .aspx page.</li>
                    <li>Open the ToolBox panel, typically located on the left side in a fly-out panel (Ctrl + Alt + x).</li>
                    <li>Create a new "Ext.NET" Tab:
                        <ol style="list-style-type: lower-alpha;">
                            <li>Right-Click in the ToolBox area</li>
                            <li>Select "Add Tab"</li>
                            <li>Enter "Ext.NET"</li>
                        </ol>
                    </li>
		            <li>Inside the "Ext.NET" tab, Right-Click and select "Choose Items...".</li>
		            <li>Under the ".NET Framework Components" Tab select the "Browse" button.</li>
		            <li>Navigate to and select the Ext.Net.dll file, choose open.</li>
                    <li>Ext.NET controls should now be added to the list and pre-checked. You can confirm by sorting the list by "Namespace" and scrolling to "Ext.Net"</li>
                    <li>Click "OK". The icons should be added to your ToolBox. You should now be able to drag/drop a Ext.NET component onto your .aspx Page.</li>
                </ol>
            </li>
           
            <li>Create your first web page.
                <ol style="list-style-type: lower-roman;">
                    <li>Open a .aspx Page</li>
                    <li>Drag the Ext.NET "ResourceManager" control onto your Page. One &lt;ext:ResourceManager> is required on each .aspx Page</li>
                    <li>Drag an Ext.NET "Window" Control onto your Page, then Save (Ctrl + s) your Page.</li>
                    <li>Hit "F5" to start debugging, or Right-Click on the Page and select "View in Browser". Your Page should now render in the browser and the &lt;ext:Window> will be displayed.</li>
                    <li>Enjoy.</li>
                </ol>
            </li>
        </ol>
    </form>
  </body>
</html>    
