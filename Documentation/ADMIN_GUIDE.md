# Administrator Guide - Absence Registration Overview

## Table of Contents
1. [Installation](#installation)
2. [Initial Configuration](#initial-configuration)
3. [Role Center Management](#role-center-management)
4. [Dimension Setup](#dimension-setup)
5. [User Access Configuration](#user-access-configuration)
6. [Troubleshooting](#troubleshooting)
7. [Maintenance](#maintenance)
8. [Customization](#customization)

---

## Installation

### Prerequisites

- Microsoft Dynamics 365 Business Central version 26.0 or later
- Administrative access to the Business Central environment
- Object ID range 85000-85099 must be available

### Installation Steps

1. **Download the App**
   - Obtain the file: `Bech-Andersen Consult ApS_Absence Registration Overview_26.0.0.2.app`

2. **Install via Extension Management**
   ```
   1. Open Business Central
   2. Search for "Extension Management"
   3. Click "Upload Extension"
   4. Select the .app file
   5. Click "Deploy"
   6. Accept permissions if prompted
   7. Wait for deployment to complete (per company)
   ```

3. **Verify Installation**
   ```
   1. Check that status shows "Installed"
   2. Search for "Absence Registration Setup"
   3. Verify the page opens
   4. Check that a setup record was created automatically
   ```

### Post-Installation

The installation codeunit automatically:
- Creates the setup record with default values
- Sets "Earliest Future Absence Reg." to `<1W>` (1 week)
- Extends all supported role centers

**No manual data initialization is required.**

---

## Initial Configuration

### Access the Setup Page

1. Search for **"Absence Registration Setup"**
2. The page opens with a single record (automatically created during installation)

### Configure Basic Settings

#### 1. Earliest Future Absence Registration

**Purpose:** Defines how far into the future to show absences when users select "Limited" mode.

**Configuration:**
- Field: `Earliest Future Absence Reg.`
- Type: Date Formula
- Default: `<1W>` (1 week)
- Common values:
  - `<1W>` - One week ahead
  - `<2W>` - Two weeks ahead
  - `<1M>` - One month ahead
  - `<3M>` - Three months ahead

**Example:**
```
Setting: <2W>
Today: January 15, 2025
When user selects "Limited": Shows absences starting up to January 29, 2025
```

**Recommendation:** Start with 1-2 weeks and adjust based on user feedback.

#### 2. Employee Group Dimension

**Purpose:** Enables filtering absences by employee groups (departments, locations, teams, etc.).

**Configuration:**
1. Click in the **Employee Group Dimension** field
2. Select a dimension from the lookup (F6)
3. Common choices:
   - DEPARTMENT
   - LOCATION
   - DIVISION
   - TEAM

**Prerequisites:**
- The dimension must already exist in Dimension setup
- Dimension values must be defined
- Employees must have default dimension assignments

**Validation:**
- The **Employee Group Name** field automatically displays the dimension's name
- This helps verify the correct dimension was selected

**Example Setup:**
```
Dimension Code: DEPARTMENT
Dimension Values:
  - SALES
  - WAREHOUSE
  - ADMIN
  - IT
  - HR

Employee Assignments:
  - Employee 001 → DEPARTMENT = SALES
  - Employee 002 → DEPARTMENT = SALES
  - Employee 003 → DEPARTMENT = WAREHOUSE
  ...
```

---

## Role Center Management

### Viewing Included Role Centers

1. Open **Absence Registration Setup**
2. Click **Actions → RoleCenters Page Overview**
3. The page shows all extended role centers with their Object IDs

### Default Included Role Centers

The app automatically extends these 28 role centers:

| Role Center | Page ID | Extension Object |
|-------------|---------|------------------|
| Accountant | 9002 | 85003 |
| Accounting Manager | 9004 | 85005 |
| Accounting Services | 9027 | 85028 |
| Account Receivables | 9003 | 85004 |
| Accounts Payable Coordinator | 9025 | 85026 |
| Accounts Receivables Administrator | 9026 | 85027 |
| Administrator | 9022 | 85023 |
| Bookkeeper | 9001 | 85002 |
| Business Manager | 9006 | 85007 |
| CEO and President | 9005 | 85006 |
| Finance Manager | 9010 | 85011 |
| Job Project Manager | 9009 | 85010 |
| Job Resource Manager | 8906 | 85031 |
| Machine Operator | 9015 | 85016 |
| Production Planner | 9014 | 85015 |
| Purchasing Agent | 9008 | 85009 |
| Sales Manager | 9011 | 85012 |
| Sales Order Processor | 9007 | 85008 |
| Sales Relationship Manager | 9012 | 85013 |
| Service Dispatcher | 9018 | 85019 |
| Service Technician | 9017 | 85018 |
| Shop Supervisor (Manufacturing Foundation) | 9013 | 85014 |
| Shop Supervisor | 9016 | 85017 |
| Small Business Owner | 9029 | 85030 |
| Team Member | 9024 | 85025 |
| Warehouse Basic | 9010 | 85020 |
| Warehouse WMS | 9021 | 85022 |
| Warehouse Worker WMS | 9019 | 85021 |

### Adding Custom Role Centers

If you need to add the overview to additional custom role centers:

1. **Create Page Extension**
   ```al
   pageextension 85050 "BAC Custom RC" extends "Your Custom Role Center"
   {
       layout
       {
           addlast(rolecenter)
           {
               part(AbsenceOverview; "BAC Absence Overview")
               {
                   ApplicationArea = All;
                   Caption = 'Absence Overview';
               }
           }
       }
   }
   ```

2. **Compile and Deploy**
   - Add the file to your AL project
   - Compile and publish the extension
   - The overview will appear on the custom role center

### Removing from Specific Role Centers

To remove the overview from a role center:

1. Identify the page extension file in `Page Extensions/` folder
2. Comment out or delete the part control
3. Recompile and republish the app

---

## Dimension Setup

### Overview

The Employee Group Dimension feature allows users to filter absences by organizational groupings. This section explains how to set up dimensions properly.

### Step 1: Create or Select a Dimension

**If dimension doesn't exist:**
1. Search for **"Dimensions"**
2. Click **New**
3. Enter Code (e.g., "DEPARTMENT")
4. Enter Name (e.g., "Department")
5. Click OK

**If dimension already exists:**
- Note the dimension code for use in Absence Registration Setup

### Step 2: Define Dimension Values

1. Open the dimension record
2. Click **Dimension → Dimension Values**
3. Create values for each group:

**Example for DEPARTMENT:**
```
Code: SALES       | Name: Sales Department
Code: WAREHOUSE   | Name: Warehouse
Code: ADMIN       | Name: Administration
Code: IT          | Name: Information Technology
Code: HR          | Name: Human Resources
Code: FINANCE     | Name: Finance
```

### Step 3: Assign Dimensions to Employees

**For each employee:**
1. Open **Employees** list
2. Select an employee
3. Click **Related → Dimensions**
4. Click **New** (if dimension not already assigned)
5. Select the Employee Group Dimension (e.g., DEPARTMENT)
6. Select the appropriate Dimension Value (e.g., SALES)
7. Click OK

**Bulk Assignment (for many employees):**
1. Use Configuration Packages to import default dimensions
2. Or use Excel via API/OData
3. Or create a custom AL script for assignment

### Step 4: Link to Responsibility Centers (Optional)

This enables automatic filtering based on user's responsibility center.

**For each Responsibility Center:**
1. Search for **"Responsibility Centers"**
2. Open a responsibility center
3. Click **Related → Dimensions**
4. Add the Employee Group Dimension
5. Set the appropriate Dimension Value

**Example:**
```
Responsibility Center: SALES-US
Dimension: DEPARTMENT
Value: SALES

Result: Users with SALES-US responsibility center automatically see SALES department absences
```

### Step 5: Configure in Absence Registration Setup

1. Open **Absence Registration Setup**
2. Set **Employee Group Dimension** to your dimension code (e.g., DEPARTMENT)
3. Verify **Employee Group Name** displays correctly
4. Click OK

### Verification

Test the setup:
1. Open **Absence Overview**
2. Click in the Employee Group field
3. Press F6 to open lookup
4. Verify dimension values appear
5. Select a value and check that filtering works

---

## User Access Configuration

### Permissions Required

Users need the following permissions to use the Absence Overview:

#### Minimum Read Permissions
- Employee (Read)
- Employee Absence (Read)
- Dimension (Read)
- Dimension Value (Read)
- Default Dimension (Read)
- BAC Absence Registration Setup (Read)

#### For Creating Absences
- Employee Absence (Insert, Modify, Delete)

### Setting Up User Responsibility Centers

To enable automatic filtering by employee group:

1. **Open User Setup**
   ```
   1. Search for "User Setup"
   2. Find the user
   3. Click to edit
   ```

2. **Assign Responsibility Center**
   Set one of the following fields:
   - **Sales Resp. Ctr. Filter** (checked first)
   - **Purchase Resp. Ctr. Filter** (checked second)
   - **Service Resp. Ctr. Filter** (checked third)

3. **Ensure Responsibility Center has Dimension**
   - The responsibility center must have a default dimension assignment
   - The dimension must match the Employee Group Dimension in setup
   - The dimension value determines the automatic filter

**Example:**
```
User: JOHN
User Setup → Sales Resp. Ctr. Filter: SALES-US

Responsibility Center: SALES-US
Default Dimension → DEPARTMENT = SALES

Result: When JOHN opens Absence Overview, it automatically filters to SALES department
```

### Permission Sets

Create a custom permission set for Absence Overview users:

**Permission Set: ABSENCE-USER**
```
Table Data: Employee (Read)
Table Data: Employee Absence (Read)
Table Data: Dimension (Read)
Table Data: Dimension Value (Read)
Table Data: Default Dimension (Read)
Table Data: BAC Absence Registration Setup (Read)
Table Data: Responsibility Center (Read)
Table Data: User Setup (Read - for own record)

Page: BAC Absence Overview (Execute)
Page: Absence Registration (Execute - for viewing)
```

**Permission Set: ABSENCE-ADMIN**
```
Inherits: ABSENCE-USER

Additional:
Table Data: Employee Absence (Insert, Modify, Delete)
Table Data: BAC Absence Registration Setup (Insert, Modify, Delete)
Page: BAC Absence Registration Setup (Execute)
Page: Absence Registration (Insert, Modify, Delete)
```

---

## Troubleshooting

### Installation Issues

**Problem:** App fails to install

**Solutions:**
- Check Business Central version (must be 26.0+)
- Verify object ID range 85000-85099 is available
- Review error messages in Extension Management
- Check that no conflicting extensions exist

**Problem:** Setup record not created

**Solutions:**
- Manually run the install codeunit (Development mode)
- Or manually create setup record:
  ```
  1. Open BAC Absence Registration Setup table
  2. Insert new record with Primary Key = ''
  3. Set Earliest Future Absence Reg. = <1W>
  ```

### Configuration Issues

**Problem:** Employee Group lookup is empty

**Causes & Solutions:**
- Dimension not selected in setup → Select dimension
- No dimension values exist → Create dimension values
- Wrong dimension code → Verify correct dimension in setup

**Problem:** Users can't see any employees

**Causes & Solutions:**
- No Employee Absence records exist → Create test absences
- Filters too restrictive → Reset filters to defaults
- No permissions → Grant required table permissions
- Employee Group filter applied with no matching employees → Clear filter

**Problem:** Automatic filtering not working

**Causes & Solutions:**
- User Setup doesn't have responsibility center → Assign RC
- Responsibility Center doesn't have dimension → Add default dimension to RC
- Dimension doesn't match setup → Verify dimension codes match
- Responsibility Center filter priority (Sales checked first, then Purchase, then Service)

### Performance Issues

**Problem:** Page loads slowly with many employees

**Solutions:**
- Recommend users always use Employee Group filter
- Set "Show Future Absences" to "None" or "Limited" as default
- Reduce "Earliest Future Absence Reg." to shorter period (e.g., <1W> instead of <3M>)
- Archive old absence records periodically
- Add indexes to Employee Absence table if needed

**Problem:** Date navigation is slow

**Causes:**
- Large dataset being reprocessed on each date change
- Solution: Same as above - encourage filtering

---

## Maintenance

### Regular Maintenance Tasks

#### Monthly
- Review and archive old absence records (older than 1 year)
- Check for orphaned Employee Absence records (employees no longer exist)
- Verify dimension assignments are up-to-date

#### Quarterly
- Review Employee Group Dimension values (add/remove as needed)
- Update Responsibility Center dimension assignments for organizational changes
- Review user feedback on Future Absence limit setting

#### Annually
- Review permission sets for accuracy
- Update documentation if customizations were made
- Check for app updates from publisher

### Data Cleanup

**Archive Old Absences:**
```al
// Pseudo-code for cleanup
Delete Employee Absence records where:
  - To Date < (Today - 365 days)
  - Employee is terminated
```

**Verify Employee Assignments:**
```sql
-- SQL to find employees without dimension assignment
SELECT e."No.", e."First Name", e."Last Name"
FROM Employee e
LEFT JOIN "Default Dimension" dd ON 
  dd."Table ID" = 5200 AND 
  dd."No." = e."No." AND
  dd."Dimension Code" = 'DEPARTMENT'
WHERE dd."Dimension Value Code" IS NULL
```

### Backup and Recovery

**Before Making Changes:**
1. Export current setup record
2. Document dimension assignments
3. Note all customizations

**Backup Method:**
1. Use Configuration Packages to export:
   - BAC Absence Registration Setup
   - BAC Role Center Selection
   - Related Default Dimension records

2. Store package in secure location

**Recovery:**
1. Import Configuration Package
2. Verify settings after import
3. Test with users

---

## Customization

### Common Customization Scenarios

#### 1. Add Custom Fields to Overview

**Requirements:**
- Add fields to Employee Absence table (via table extension)
- Modify page to display new fields

**Example: Add "Approved By" field**

```al
// Table Extension
tableextension 85100 "Custom Employee Absence" extends "Employee Absence"
{
    fields
    {
        field(85100; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
}

// Page Modification
// Edit AbsenceRegistrationOverview.Page.al
// Add field to repeater:
field("Approved By"; Rec."Approved By")
{
    Caption = 'Approved By';
}
```

#### 2. Change Default Future Absence Setting

**Modify OnOpenPage trigger in AbsenceRegistrationOverview.Page.al:**

```al
trigger OnOpenPage()
begin
    // Existing code...
    FromDate := WorkDate();
    ShowFutureAbsence := ShowFutureAbsence::Limited; // Change from None to Limited
    Initialize();
end;
```

#### 3. Add Email Notification Action

**Add action to page:**

```al
action(EmailAbsenceList)
{
    Caption = 'Email Absence List';
    Image = Email;
    trigger OnAction()
    var
        EmailHandler: Codeunit "Custom Email Handler";
    begin
        EmailHandler.SendAbsenceOverview(Rec, FromDate, EmployeeGroupFilter);
    end;
}
```

#### 4. Integrate with Third-Party Systems

**Options:**
- Create API Page for external access
- Use OData to expose absence data
- Implement web service for real-time queries

**Example API Page:**

```al
page 85090 "BAC Absence API"
{
    PageType = API;
    APIPublisher = 'baconsult';
    APIGroup = 'absence';
    APIVersion = 'v1.0';
    EntityName = 'absence';
    EntitySetName = 'absences';
    SourceTable = "Employee Absence";
    
    layout
    {
        area(Content)
        {
            field(employeeNo; Rec."Employee No.") { }
            field(fromDate; Rec."From Date") { }
            field(toDate; Rec."To Date") { }
            field(causeCode; Rec."Cause of Absence Code") { }
        }
    }
}
```

### Development Best Practices

1. **Preserve Core Functionality**
   - Don't modify original objects directly
   - Use extensions and event subscribers
   - Keep customizations separate from base app

2. **Testing**
   - Test all customizations in sandbox first
   - Create test scenarios for each modification
   - Verify performance with production data volumes

3. **Documentation**
   - Document all customizations
   - Update technical documentation
   - Maintain change log

4. **Version Control**
   - Keep customizations in separate extension
   - Use Git for version control
   - Tag releases appropriately

---

## Support Resources

### Official Resources
- **Help:** https://blog.versionmanager.dk/absence-registration-overview/
- **GitHub:** https://github.com/peikba/Absence-Registration
- **EULA:** https://ba-consult.dk/downloads/warranty.txt

### Contact Information
- **Publisher:** Bech-Andersen Consult ApS
- **App Version:** 26.0.0.2
- **Support:** Contact through GitHub Issues

### Additional Learning
- Microsoft Learn - Business Central Development
- AL Language Documentation
- Business Central Community Forums

---

## Appendix

### Default Configuration Values

```json
{
  "Earliest Future Absence Reg.": "<1W>",
  "Employee Group Dimension": "",
  "ShowFutureAbsence": "None"
}
```

### File Structure Reference

```
/Codeunits
  - BACInstallAbsenceOverview.Codeunit.al (85000)

/Tables
  - BACRegistrationOverviewSetup.table.al (85000)
  - BACRoleCenterSelection.Table.al (85001)

/Pages
  - BACRegistrationOverviewSetup.Page.al (85000)
  - BACAboutAbsenceRegistration.page.al (85002)
  - AbsenceRegistrationOverview.Page.al (85003)
  - BACSelectRoleCenters.Page.al (85xxx)
  - LogoFactBox.page.al

/Page Extensions
  - 28 role center extensions (85002-85031)
```

### SQL Queries for Diagnostics

**Check dimension assignments:**
```sql
SELECT 
    e."No.", 
    e."First Name", 
    e."Last Name",
    dd."Dimension Code",
    dd."Dimension Value Code",
    dv."Name"
FROM Employee e
LEFT JOIN "Default Dimension" dd ON 
    dd."Table ID" = 5200 AND 
    dd."No." = e."No."
LEFT JOIN "Dimension Value" dv ON
    dv."Dimension Code" = dd."Dimension Code" AND
    dv."Code" = dd."Dimension Value Code"
WHERE dd."Dimension Code" = 'DEPARTMENT'
```

**Check absence records:**
```sql
SELECT 
    "Employee No.",
    "From Date",
    "To Date",
    "Cause of Absence Code",
    COUNT(*) as RecordCount
FROM "Employee Absence"
GROUP BY "Employee No.", "From Date", "To Date", "Cause of Absence Code"
HAVING COUNT(*) > 1  -- Find duplicates
```

---

**Administrator Guide Version:** 1.0  
**Last Updated:** November 9, 2025  
**For Business Central:** 26.0+
