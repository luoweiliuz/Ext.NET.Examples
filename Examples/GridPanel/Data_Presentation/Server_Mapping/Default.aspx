<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        var store = this.GridPanel1.GetStore();
        
        store.DataSource = Employee.GetAll();
        store.DataBind();
    }

    public class Employee
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public Department Department { get; set; }

        public static List<Employee> GetAll()
        {
            return new List<Employee>
            {
               new Employee
               {
                   ID = 1,
                   Name = "Nancy",
                   Surname = "Davolio",
                   Department = Department.GetAll()[0]
               },
               new Employee
               {
                   ID = 2,
                   Name = "Andrew",
                   Surname = "Fuller",
                   Department = Department.GetAll()[2]
               }
            };
        }
    }

    public class Department
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public static List<Department> GetAll()
        {
            return new List<Department>
            {
                new Department { ID = 1, Name = "Department A" },
                new Department { ID = 2, Name = "Department B" },
                new Department { ID = 3, Name = "Department C" }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Server Mapping - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            AutoHeight="true" 
            Title="List" 
            Icon="Application">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="ID">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="Name" />
                                <ext:ModelField Name="Surname" />
                                <ext:ModelField Name="Department" ServerMapping="Department.Name" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">                
                <Columns>
                    <ext:Column runat="server" Text="ID" DataIndex="ID" />
                    <ext:Column runat="server" Text="NAME" DataIndex="Name" />
                    <ext:Column runat="server" Text="SURNAME" DataIndex="Surname" />
                    <ext:Column runat="server" Text="Department" DataIndex="Department" Width="240" />
                </Columns>
            </ColumnModel>            
        </ext:GridPanel>
    </form>
</body>
</html>
