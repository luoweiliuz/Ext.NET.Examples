<%@ Control Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples.Northwind"%>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.EmployeesStore.DataSource = Employee.GetAll();
            this.EmployeesStore.DataBind();
        }
    }

    public Store GridStore { get; set; }

    public void Show()
    {
        this.EmployeeDetailsWindow.Show();
    }

    public void SetEmployee(Employee empl)
    {        
        CompanyInfoTab.SetValues(empl);
        PersonalInfoTab.SetValues(empl);
    }

    protected void SaveEmployee(object sender, DirectEventArgs e)
    {
        NorthwindDataContext db = new NorthwindDataContext();
        int id = int.Parse(e.ExtraParams["id"]);

        Employee empl = Employee.GetEmployee(id, db);

        //Company
        empl.FirstName = this.FirstName.Text;
        empl.LastName = this.LastName.Text;
        empl.Title = this.Title.Text;

        if (!string.IsNullOrEmpty(this.ReportsTo.SelectedItem.Value))
        {
            empl.ReportsTo = int.Parse(this.ReportsTo.SelectedItem.Value);
        }
        else
        {
            empl.ReportsTo = null;
        }

        empl.HireDate = this.HireDate.SelectedDate;
        empl.Extension = this.Extension.Text;

        //Personal
        empl.Address = this.Address.Text;
        empl.City = this.City.Text;
        empl.PostalCode = this.PostCode.Text;
        empl.HomePhone = this.HomePhone.Text;
        empl.TitleOfCourtesy = this.TitleCourt.Text;
        empl.BirthDate = this.BirthDate.SelectedDate;
        empl.Region = this.Region.Text;
        empl.Country = this.Country.Text;
        empl.Notes = this.Note.Text;

        db.SubmitChanges();

        var record = this.GridStore.GetById(id);        

        this.EmployeeDetailsWindow.Hide();
        CompanyInfoTab.UpdateRecord(record);
        PersonalInfoTab.UpdateRecord(record);
        record.Commit();
    }
</script>

<ext:Window 
    ID="EmployeeDetailsWindow" 
    runat="server" 
    Icon="Group" 
    Title="Employee Details"
    Width="400" 
    Height="400" 
    AutoShow="false" 
    Modal="true" 
    Hidden="true"
    Layout="Fit">
    <Items>
        <ext:TabPanel runat="server" ActiveTabIndex="0" Border="false" DeferredRender="false">
            <Items>
                <ext:FormPanel 
                    ID="CompanyInfoTab" 
                    runat="server" 
                    Title="Company Info" 
                    Icon="ChartOrganisation"
                    DefaultAnchor="100%"
                    BodyPadding="5">
                    <Items>
                        <ext:TextField ID="EmployeeID1" runat="server" FieldLabel="Employee ID" Disabled="true" Name="EmployeeID" />
                        <ext:TextField ID="FirstName" runat="server" FieldLabel="First Name" Name="FirstName" />
                        <ext:TextField ID="LastName" runat="server" FieldLabel="Last Name" Name="LastName" />
                        <ext:TextField ID="Title" runat="server" FieldLabel="Title" Name="Title" />
                        <ext:ComboBox 
                            ID="ReportsTo" 
                            runat="server"                             
                            FieldLabel="Reports to"
                            Name="ReportsTo"
                            AllowBlank="true" 
                            DisplayField="LastName" 
                            ValueField="EmployeeID" 
                            TypeAhead="true"
                            QueryMode="Local" 
                            ForceSelection="true" 
                            TriggerAction="All" 
                            EmptyText="Select an employee..."
                            Width="250">
                            <Store>
                                <ext:Store runat="server" ID="EmployeesStore">
                                    <Model>
                                        <ext:Model runat="server" IDProperty="EmployeeID">
                                            <Fields>
                                                <ext:ModelField Name="EmployeeID" />
                                                <ext:ModelField Name="LastName" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>                            
                            </Store>
                        </ext:ComboBox>
                        <ext:DateField ID="HireDate" runat="server" FieldLabel="Hire date" Format="yyyy-M-d" Name="HireDate" />
                        <ext:TextField ID="Extension" runat="server" FieldLabel="Extension" Name="Extension" />
                    </Items>
                </ext:FormPanel>
                <ext:FormPanel 
                    ID="PersonalInfoTab" 
                    runat="server" 
                    Title="Personal Info" 
                    Icon="User"
                    DefaultAnchor="100%" 
                    BodyPadding="5">
                    <Items>
                        <ext:TextField ID="EmployeeID2" runat="server" FieldLabel="Employee ID" Disabled="true" Name="EmployeeID" SubmitValue="false" />
                        <ext:TextField ID="Address" runat="server" FieldLabel="Address" Name="Address" />
                        <ext:TextField ID="City" runat="server" FieldLabel="City" Name="City" />
                        <ext:TextField ID="PostCode" runat="server" FieldLabel="Post Code" Name="PostCode" />
                        <ext:TextField ID="HomePhone" runat="server" FieldLabel="Home Phone" Name="HomePhone" />
                        <ext:TextField ID="TitleCourt" runat="server" FieldLabel="Title Of Courtesy" Name="TitleCourt" />
                        <ext:DateField ID="BirthDate" runat="server" FieldLabel="Birth date" Format="yyyy-M-d" Name="BirthDate" />
                        <ext:TextField ID="Region" runat="server" FieldLabel="Region" Name="Region" />
                        <ext:TextField ID="Country" runat="server" FieldLabel="Country" Name="Country" />
                        <ext:TextArea ID="Note" runat="server" FieldLabel="Note" Height="50" Name="Note" />
                    </Items>
                </ext:FormPanel>
            </Items>
        </ext:TabPanel>
    </Items>
    <Buttons>
        <ext:Button ID="SaveButton" runat="server" Text="Save" Icon="Disk">
            <DirectEvents>
                <Click OnEvent="SaveEmployee" Failure="Ext.MessageBox.alert('Saving failed', 'Error during ajax event');">
                    <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="={#{EmployeeDetailsWindow}.body}" />
                    <ExtraParams>
                        <ext:Parameter Name="id" Value="#{EmployeeID1}.getValue()" Mode="Raw" />
                    </ExtraParams>
                </Click>
            </DirectEvents>
        </ext:Button>
        <ext:Button ID="CancelButton" runat="server" Text="Cancel" Icon="Cancel">
            <Listeners>
                <Click Handler="this.up('window').hide();" />
            </Listeners>
        </ext:Button>
    </Buttons>
</ext:Window>
