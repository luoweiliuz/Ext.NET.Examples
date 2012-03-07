<%@ Control Language="C#" %>

<%@ Import Namespace="Ext.Net.Examples.Northwind"%>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.EmployeesStore.DataSource = Employee.GetAll();
        this.EmployeesStore.DataBind();
    }
</script>
<ext:XScript runat="server">
    <script type="text/javascript">
        Ext.applyIf(CompanyX, {
            open : function () {
                rec = this.getRecord();
            
                if (rec != null) {
                    win = #{winDetails};
                
                    win.show();
                    win.setTitle(Ext.String.format("Employee Details : {0}, {1}", rec.data.LastName, rec.data.FirstName));
                
                    #{CompanyInfoTab}.getForm().loadRecord(rec);
                    #{PersonalInfoTab}.getForm().loadRecord(rec);
                }
            },
        
            save : function () {
                var rec = this.getRecord();
            
                if (rec != null) {
                    #{CompanyInfoTab}.getForm().updateRecord(rec);
                    #{PersonalInfoTab}.getForm().updateRecord(rec);
                }
            
                #{winDetails}.hide();
                this.refresh();
            }
        });
    </script>
</ext:XScript>

<ext:Window 
    ID="winDetails" 
    runat="server" 
    Title="Employee Details" 
    Icon="Group" 
    Width="400" 
    Height="400" 
    Modal="true"
    Hidden="true"
    Layout="Fit">
    <Items>
        <ext:TabPanel runat="server" Border="false">
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
                            AllowBlank="true"
                            DisplayField="LastName"
                            ValueField="EmployeeID"
                            TypeAhead="true" 
                            QueryMode="Local"
                            Name="ReportsTo"
                            ForceSelection="true"
                            TriggerAction="All"
                            EmptyText="Select an employee...">
                            <Store>
                                <ext:Store ID="EmployeesStore" runat="server">
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
                        <ext:DateField ID="HireDate" runat="server" FieldLabel="Hire date" Format="yyyy-MM-dd" Name="HireDate" />
                        <ext:TextField runat="server" ID="Extension" FieldLabel="Extension" Name="Extension" />
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
                        <ext:DateField ID="BirthDate" runat="server" FieldLabel="Birth date" Format="yyyy-MM-dd" Name="BirthDate" />
                        <ext:TextField ID="Region" runat="server" FieldLabel="Region" Name="Region" />
                        <ext:TextField ID="Country" runat="server" FieldLabel="Country" Name="Country" />
                        <ext:TextArea ID="Note" runat="server" FieldLabel="Note" Height="50" Name="Note" />
                    </Items>
                </ext:FormPanel>
            </Items>                
        </ext:TabPanel>
    </Items>
    <Buttons>
        <ext:Button ID="btnPrevious" runat="server" Text="Previous" Icon="PreviousGreen">
            <Listeners>
                <Click Handler="CompanyX.previous();" />
            </Listeners>
        </ext:Button>
    
        <ext:Button ID="btnSave" runat="server" Text="Save" Icon="Disk">
           <Listeners>
                <Click Handler="CompanyX.save();" />
            </Listeners>
        </ext:Button>
        
        <ext:Button ID="btnCancel" runat="server" Text="Cancel" Icon="Cancel">
            <Listeners>
                <Click Handler="this.up('window').hide();" />
            </Listeners>
        </ext:Button>
        
        <ext:Button ID="btnNext" runat="server" Text="Next" Icon="NextGreen">
            <Listeners>
                <Click Handler="CompanyX.next();" />
            </Listeners>
        </ext:Button>
    </Buttons>
</ext:Window>