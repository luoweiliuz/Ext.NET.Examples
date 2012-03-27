<%@ Page Language="C#" %>

<%@ Import Namespace="System.Linq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.TestData(5000);
            this.Store1.DataBind();
        }
    }

    private object[] TestData(int count)
    {
        var firstNames = new string[] { "Ed", "Tommy", "Aaron", "Abe", "Jamie", "Adam", "Dave", "David", "Jay", "Nicolas", "Nige" };
        var lastNames = new string[] { "Spencer", "Maintz", "Conran", "Elias", "Avins", "Mishcon", "Kaneda", "Davis", "Robinson", "Ferrero", "White" };
        var ratings = new int[] { 1, 2, 3, 4, 5 };
        var salaries = new int[] { 100, 400, 900, 1500, 1000000 };

        var data = new object[count];
        var rnd = new Random();

        for (int i = 0; i < count; i++)
        {
            var ratingId = rnd.Next(ratings.Length);
            var salaryId = rnd.Next(salaries.Length);
            var firstNameId = rnd.Next(firstNames.Length);
            var lastNameId = rnd.Next(lastNames.Length);

            var rating = ratings[ratingId];
            var salary = salaries[salaryId];
            var name = String.Format("{0} {1}", firstNames[firstNameId], lastNames[lastNameId]);

            data[i] = new object[] { name, rating, salary };
        }

        return data;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Buffered Scrolling - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Buffered Scrolling</h1>

        <p>Ext.Net 2's brand new grid supports infinite scrolling, which enables you to load any number of records into a grid without paging.</p>

        <p>The new grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>

        <p>This example illustrates loading of all the records up front and buffering the rendering.</p>
        
        <ext:GridPanel 
            runat="server" 
            Title="Bufffered Grid of 5,000 random records" 
            DisableSelection="true"
            Width="700" 
            Height="500">
            <Store>
                <ext:Store 
                    ID="Store1" 
                    runat="server" 
                    PageSize="5000" 
                    Buffered="true">                    
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="name" />
                                <ext:ModelField Name="rating" Type="Int" />
                                <ext:ModelField Name="salary" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>            
                </ext:Store>
            </Store>            
            <View>
                <ext:GridView runat="server" TrackOver="false" />
            </View>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="40" Sortable="false" />
                    <ext:Column runat="server" Text="Name" Flex="1" DataIndex="name" />
                    <ext:Column runat="server" Text="Rating" Width="125" DataIndex="rating" />
                    <ext:Column runat="server" Text="Salary" Width="125" DataIndex="salary" Align="Right">
                        <Renderer Format="UsMoney" />
                    </ext:Column>                    
                </Columns>
            </ColumnModel>            
        </ext:GridPanel>
    </form>
</body>
</html>
