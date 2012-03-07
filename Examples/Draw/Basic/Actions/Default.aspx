<%@ Page Language="C#" %>
<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Draw Actions - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />

    <script runat="server">
        protected void CreateSprite(object sender, DirectEventArgs e)
        {
            var sprite = new Sprite
            {
                SpriteID = "Sprite1",
                Type = SpriteType.Rect,
                Width = 100,
                Height = 100,
                X = 150,
                Y = 150,
                Fill = "green"
            };
            
            Draw1.Add(sprite);
            sprite.Show(true);
            this.EnableButton(sender);
        }

        protected void ChangeColor(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new SpriteAttributes { Fill = "red" }, true);
            this.EnableButton(sender);
        }

        protected void RotateLeft(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new SpriteAttributes { Rotate = new RotateAttribute { Degrees = -45 } }, true);
            this.EnableButton(sender);
        }

        protected void RotateRight(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").Animate(new AnimConfig 
            {
                Duration = 1000,
                To = 
                { 
                    new Ext.Net.Parameter("rotate", "{degrees:0}", ParameterMode.Raw)
                }
            });
            this.EnableButton(sender);
        }

        protected void Scaling(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new SpriteAttributes { Scale = new ScaleAttribute { X = 2, Y = 2 } }, true);
            this.EnableButton(sender);
        }

        protected void Translation(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new SpriteAttributes { Translate = new TranslateAttribute { X = -100, Y = -100 } }, true);
            this.EnableButton(sender);
        }

        private void EnableButton(object sender)
        {
            var button = (Ext.Net.Button)sender;
            var items = ((AbstractContainer)button.Parent).Items;
            var index = items.IndexOf(button) + 1;
            button.Disabled = true;

            if (index < items.Count)
            {
                items[index].Disabled = false;
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <h1>Draw Actions</h1>

        <ext:Window runat="server" Title="Draw Actions" Width="640" Height="480" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Frame="true" Width="200" Region="West" Layout="VBoxLayout" Margin="5">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" Pack="Center" DefaultMargins="5" />
                    </LayoutConfig>                    
                    <Items>
                        <ext:Button runat="server" Text="Create Sprite" OnDirectClick="CreateSprite" />
                        <ext:Button runat="server" Text="Change Color" OnDirectClick="ChangeColor" Disabled="true" />
                        <ext:Button runat="server" Text="Rotate -45" OnDirectClick="RotateLeft" Disabled="true" />
                        <ext:Button runat="server" Text="Rotate back (animaton)" OnDirectClick="RotateRight" Disabled="true" />
                        <ext:Button runat="server" Text="Scaling" OnDirectClick="Scaling" Disabled="true" />
                        <ext:Button runat="server" Text="Translation" OnDirectClick="Translation" Disabled="true" />
                    </Items>
                </ext:Panel>
                <ext:DrawComponent ID="Draw1" runat="server" Region="Center" ViewBox="false" StyleSpec="background:white;" />
            </Items>
        </ext:Window>
    </form>    
</body>
</html>
