# Technical Architecture Documentation

## System Architecture

### Component Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Role Centers (28+)                   │
│         (Business Manager, Sales Manager, etc.)         │
└────────────────────┬────────────────────────────────────┘
                     │ Page Extensions
                     ▼
┌─────────────────────────────────────────────────────────┐
│              BAC Absence Overview (Page 85003)          │
│                     [ListPart]                          │
└─────────────┬───────────────────────────────┬───────────┘
              │                               │
              ▼                               ▼
┌─────────────────────────┐   ┌──────────────────────────┐
│  Employee Absence       │   │  BAC Absence Registration│
│  (Temporary Table)      │   │  Setup (Table 85000)     │
└─────────────────────────┘   └──────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────────┐
│              Base BC Tables                             │
│  - Employee                                             │
│  - Employee Absence                                     │
│  - Dimension / Dimension Value                          │
│  - Default Dimension                                    │
│  - Responsibility Center                                │
│  - User Setup                                           │
└─────────────────────────────────────────────────────────┘
```

## Data Model

### Custom Tables

#### BAC Absence Registration Setup (Table 85000)

**Purpose:** Stores configuration settings for the app

| Field No. | Field Name | Type | Description |
|-----------|------------|------|-------------|
| 10 | Primary Key | Code[10] | Singleton record identifier |
| 20 | Earliest Future Absence Reg. | DateFormula | Controls future absence visibility limit |
| 30 | Employee Group Dimension | Code[10] | Dimension code for employee grouping |
| 40 | Employee Group Name | Text[100] | FlowField - Display name of dimension |

**Keys:**
- Primary Key (Clustered)

**Relationships:**
- Employee Group Dimension → Dimension.Code (TableRelation)
- Employee Group Name → Dimension.Name (CalcFormula)

#### BAC Role Center Selection (Table 85001)

**Purpose:** Tracks which role centers include the absence overview

| Field No. | Field Name | Type | Description |
|-----------|------------|------|-------------|
| 1 | Object ID | Integer | Page object ID of role center |
| 2 | Selected | Boolean | Whether role center is active |

**Keys:**
- Object ID (Clustered)

## Page Architecture

### BAC Absence Overview (Page 85003)

**Type:** ListPart  
**Source:** Employee Absence (Temporary)  
**Permissions:** Read-only (InsertAllowed=false, DeleteAllowed=false)

#### Page Variables

| Variable | Type | Purpose |
|----------|------|---------|
| FromDate | Date | Starting date for absence filtering |
| EmployeeName | Text[100] | Display name for employee |
| ShowFutureAbsence | Option | Controls future absence visibility (None/Limited/All) |
| EmployeeGroupFilter | Text | Current employee group filter value |
| AbsRegSetup | Record | Reference to setup table |

#### Key Procedures

##### Initialize()
```al
local procedure Initialize()
```
**Purpose:** Main data loading and filtering logic

**Logic Flow:**
1. Calculate earliest future absence registration date from setup
2. Clear temporary table
3. Load all Employee Absence records into temporary table
4. Normalize To Date (set to From Date if blank)
5. Apply date range filter (>= FromDate)
6. Apply future absence filter based on ShowFutureAbsence option
7. Apply employee group filter if specified
8. Insert matching records into temporary table for display

**Performance Considerations:**
- Uses temporary table to avoid repeated database queries
- Filters applied in memory after initial load
- Triggered on page open and filter changes

##### EmployeeIsMemberOfDimension()
```al
local procedure EmployeeIsMemberOfDimension(
    inEmployeeCode: Code[20]; 
    inEmployeeGroupDimensionCode: code[10]
): Boolean
```
**Purpose:** Checks if employee belongs to specified dimension value

**Logic:**
- Queries Default Dimension table
- Filters by Employee table, employee number, and dimension code
- Returns true if matching dimension assignment exists

##### GetEmployeeGroupFilterFromRespCenter()
```al
local procedure GetEmployeeGroupFilterFromRespCenter(
    inRespCenterCode: Code[10]; 
    inEmployeeGroupDimension: Code[10]
) ReturnCode: Code[10]
```
**Purpose:** Retrieves employee group filter from responsibility center

**Logic:**
- Queries Default Dimension table for Responsibility Center
- Returns dimension value code if found
- Used for automatic filtering based on user setup

#### Triggers

##### OnOpenPage
**Execution:** When page is opened

**Logic:**
1. Check User Setup for responsibility center filters (Sales, Purchase, Service)
2. Get setup record
3. Retrieve employee group filter from responsibility center
4. Calculate employee group name
5. Set FromDate to WorkDate
6. Call Initialize() to load data

##### OnAfterGetRecord
**Execution:** For each record displayed

**Logic:**
1. Get Employee record by number
2. Retrieve and store full name
3. Display in EmployeeName field

#### Filter Logic

##### Date Filtering
```
Filter: "To Date" >= FromDate
Additional: Consider "From Date" based on ShowFutureAbsence option
```

##### Future Absence Options

| Option | Logic |
|--------|-------|
| None | `From Date <= FromDate` |
| Limited | `From Date <= EarliestFutureAbsReg` (calculated from setup) |
| All | No additional from date restriction |

##### Employee Group Filtering
- Applied after date filtering
- Uses EmployeeIsMemberOfDimension() for validation
- Checks Default Dimension for Employee table

## Installation Logic

### BAC Install Absence Overview (Codeunit 85000)

**Subtype:** Install  
**Trigger:** OnInstallAppPerCompany

#### Installation Process

```al
trigger OnInstallAppPerCompany()
```

**Actions:**
1. Check if setup record exists
2. If not exists:
   - Initialize new record
   - Set Earliest Future Absence Reg. to '<1W>' (1 week)
   - Insert record

**Design Notes:**
- Ensures setup table always has a record
- Prevents errors on first page open
- Per-company installation for multi-company environments

## Integration Points

### User Setup Integration

**Tables Used:**
- User Setup

**Fields Referenced:**
- Sales Resp. Ctr. Filter
- Purchase Resp. Ctr. Filter  
- Service Resp. Ctr. Filter

**Integration Flow:**
1. On page open, retrieve User Setup for current user
2. Check for responsibility center in priority order (Sales → Purchase → Service)
3. Use first found responsibility center
4. Map responsibility center to employee group dimension value
5. Apply as default filter

### Dimension Framework Integration

**Tables Used:**
- Dimension
- Dimension Value
- Default Dimension

**Usage:**
1. **Setup:** Link to Dimension table for employee group selection
2. **Filtering:** Use Dimension Value for employee group filter lookup
3. **Assignment:** Check Default Dimension for employee-to-group mapping
4. **Responsibility Centers:** Query Default Dimension for RC-to-group mapping

**Supported Table IDs:**
- Database::Employee (5200)
- Database::"Responsibility Center" (5714)

### Employee Absence Integration

**Source Table:** Employee Absence (Standard BC)

**Fields Used:**
- Employee No.
- From Date
- To Date
- Cause of Absence Code
- Description
- Comment

**Data Processing:**
1. Read all records from Employee Absence
2. Create temporary copies
3. Normalize To Date values
4. Apply business logic filters
5. Display in overview

## Page Extensions

### Pattern for Role Center Extensions

Each role center extension follows this pattern:

```al
pageextension 850XX "BAC [RoleCenterName]" extends "[Role Center Name]"
{
    layout
    {
        addlast(RoleCenter / content / area)
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                ApplicationArea = All;
            }
        }
    }
}
```

**Extended Role Centers:** 28 different role centers (see list in README.md)

## Security & Permissions

### Object Permissions Required

**Direct Object Access:**
- Read: Employee Absence
- Read: Employee
- Read/Write: BAC Absence Registration Setup (for setup page)
- Read: Dimension, Dimension Value, Default Dimension
- Read: Responsibility Center
- Read: User Setup

**Indirect Permissions:**
- Execute: Page "Absence Registration" (for Create New and view actions)
- Execute: Page "Dimension Value List" (for employee group lookup)

### Data Classification

**BAC Absence Registration Setup:**
- All fields: SystemMetadata

**BAC Role Center Selection:**
- All fields: SystemMetadata

**Employee Absence (Standard BC):**
- Inherits BC standard classification

## Performance Considerations

### Optimization Strategies

1. **Temporary Table Usage**
   - Loads data once per filter change
   - In-memory filtering after initial load
   - Reduces database round-trips

2. **Filter Order**
   - Date filter applied first (most restrictive)
   - Future absence option applied second
   - Employee group filter applied last

3. **FlowFields**
   - Employee Group Name uses CalcFormula
   - Calculated on demand, not stored

4. **Record Counting**
   - Uses IsEmpty() instead of Count() where possible
   - More efficient for existence checks

### Scalability Limits

**Expected Performance:**
- Small-Medium Companies (< 500 employees): Excellent
- Large Companies (500-2000 employees): Good
- Very Large Companies (> 2000 employees): Consider additional filtering

**Recommendations for Large Datasets:**
- Always use Employee Group Filter
- Use "None" or "Limited" future absence options
- Consider custom date range limits

## Error Handling

### Validation Errors

**From Date Validation:**
- Any valid date accepted (past or future)
- Triggers data refresh on change

**Employee Group Filter Validation:**
- Validates against Dimension Value table
- Dimension code from setup must exist
- Shows error if invalid dimension value entered

**Setup Record:**
- Created automatically if missing (OnOpenPage)
- Prevents errors from missing configuration

### User Experience

**Empty Results:**
- Page shows empty if no matching absences
- No explicit "no records" message
- Filters remain visible for adjustment

**Missing Configuration:**
- Employee Group Dimension optional
- Filter disabled if not configured
- App remains functional without dimension setup

## Extension Points

### Customization Options

1. **Additional Filters**
   - Modify Initialize() procedure
   - Add filter variables and UI controls
   - Apply filters in data loading logic

2. **Additional Fields**
   - Extend repeater with Employee fields
   - Add calculated fields in OnAfterGetRecord
   - Join additional tables as needed

3. **Custom Actions**
   - Add new actions to Processing area
   - Run reports on filtered data
   - Export functionality

4. **Layout Modifications**
   - Rearrange field order
   - Add styling/formatting
   - Group related fields

### Event Subscribers

**Potential Integration Events:**
- OnBeforeInitialize
- OnAfterInitialize  
- OnBeforeFilterEmployee
- OnAfterCalculateAbsence

*Note: Current version does not publish events*

## Testing Considerations

### Test Scenarios

1. **Installation**
   - Fresh install creates setup record
   - Default values properly set
   - Upgrade preserves existing setup

2. **Filtering**
   - Date navigation works correctly
   - Future absence options function as expected
   - Employee group filter applies correctly
   - Responsibility center mapping works

3. **Data Display**
   - All absence records appear
   - Employee names display correctly
   - Date ranges filter properly
   - Empty results handled gracefully

4. **Permissions**
   - Users without Employee permission cannot open
   - Read-only enforcement works
   - Setup page accessible to admins only

### Test Data Requirements

- Multiple employees with absences
- Various date ranges (past, current, future)
- Dimension setup with employee assignments
- Responsibility centers with dimension values
- User setup with responsibility center assignments

## Development Guidelines

### Code Standards

- **Naming Convention:** BAC prefix for all custom objects
- **Language Features:** NoImplicitWith enforced
- **Runtime Version:** 15.0
- **AL Formatting:** Standard AL formatter rules

### Version Control

**Repository Structure:**
```
/Codeunits
/Pages
/Page Extensions
/Tables
/Layouts
/JavaScripts
/Translations
/Documentation
/Images
```

### Build & Deployment

**Required Files:**
- app.json (manifest)
- All .al source files
- Logo.png in Images/
- Translation files in Translations/

**Build Process:**
1. Compile AL code
2. Package into .app file
3. Test in sandbox environment
4. Deploy to production

---

**Document Version:** 1.0  
**Last Updated:** November 9, 2025  
**Author:** Technical Documentation
