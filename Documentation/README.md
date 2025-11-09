# Absence Registration Overview

**Version:** 26.0.0.2  
**Publisher:** Bech-Andersen Consult ApS  
**Platform:** Microsoft Dynamics 365 Business Central 26.0  
**License:** Open Source  
**GitHub Repository:** [Absence-Registration](https://github.com/peikba/Absence-Registration)

## Overview

The Absence Registration Overview app provides a comprehensive solution for tracking employee absences in Microsoft Dynamics 365 Business Central. It enables organizations to quickly see who is present and who is absent, with flexible filtering options based on date ranges, future absences, and employee groups.

## Key Features

- **Real-time Absence Overview** - View current and future employee absences in a single interface
- **Date Range Filtering** - Navigate between dates to see historical and upcoming absences
- **Future Absence Management** - Control visibility of future absences (None, Limited, or All)
- **Employee Group Filtering** - Filter absences by employee groups using dimension values
- **Responsibility Center Integration** - Automatic filtering based on user's responsibility center
- **Role Center Integration** - Adds absence overview to multiple Business Central role centers
- **Quick Navigation** - Previous/Next day buttons for easy date navigation
- **Direct Registration** - Create new absence registrations directly from the overview

## Installation

1. Install the app file: `Bech-Andersen Consult ApS_Absence Registration Overview_26.0.0.2.app`
2. The installation codeunit automatically creates the initial setup record with default values
3. Navigate to **Absence Registration Setup** to configure the app

## Configuration

### Setup Page

Access the setup page from the Administration category or search for "Absence Registration Setup".

#### Configuration Fields

| Field | Description | Default Value |
|-------|-------------|---------------|
| **Earliest Future Absence Reg.** | Date formula defining how far into the future to show absences when using "Limited" option | `<1W>` (1 week) |
| **Employee Group Dimension** | The dimension code used for grouping employees (e.g., Department, Location) | Not set |
| **Employee Group Name** | Display name of the selected dimension (calculated field) | Auto-calculated |

### Role Center Selection

The app extends multiple Business Central role centers to include the Absence Overview. You can view which role centers are included via the **RoleCenters Page Overview** action on the setup page.

#### Extended Role Centers

- Accountant
- Accounting Manager
- Accounting Services
- Account Receivables
- Accounts Payable Coordinator
- Accounts Receivables Administrator
- Administrator
- Bookkeeper
- Business Manager
- CEO and President
- Finance Manager
- Job Project Manager
- Job Resource Manager
- Machine Operator
- Production Planner
- Purchasing Agent
- Sales Manager
- Sales Order Processor
- Sales Relationship Manager
- Service Dispatcher
- Service Technician
- Shop Supervisor (Manufacturing Foundation)
- Shop Supervisor
- Small Business Owner
- Team Member
- Warehouse Basic
- Warehouse WMS
- Warehouse Worker WMS

## Usage

### Accessing the Absence Overview

1. Open your role center
2. The Absence Overview part is automatically added to your role center
3. Or search for "Absence Overview" to open it directly

### Filtering Options

#### From Date Filter
- Set the starting date for viewing absences
- Can be set to a past date to view historical absences
- Use **Previous** and **Next** buttons to navigate day-by-day

#### Show Future Absences Options

| Option | Description |
|--------|-------------|
| **None** | Only shows absences that started on or before the "From Date" |
| **Limited** | Shows absences within the timeframe defined in setup (e.g., 1 week) |
| **All** | Shows all future absence registrations regardless of start date |

#### Employee Group Filter
- Filter by dimension value to show absences for specific employee groups
- The dimension used is configured in the Absence Registration Setup
- Automatically populated from user's Responsibility Center if applicable
- Use lookup to select from available dimension values

### Viewing Absence Information

The overview displays the following information for each absence:

- **Employee No.** - Employee identification number
- **Employee Name** - Full name of the employee
- **From Date** - Start date of the absence
- **To Date** - End date of the absence (same as From Date if not specified)
- **Cause of Absence Code** - Code indicating the reason for absence
- **Description** - Description of the absence cause
- **Comment** - Additional comments about the absence

### Actions

#### Create New
Creates a new absence registration record. Opens the Absence Registration page in create mode.

#### Absence Registrations
Opens the complete list of all absence registrations for viewing and editing.

#### Previous / Next
Navigate backward or forward one day at a time to view absences for different dates.

## Technical Details

### Object Range
The app uses object IDs in the range **85000 - 85099**.

### Main Objects

#### Tables
- **85000 - BAC Absence Registration Setup** - Configuration table for the app
- **85001 - BAC Role Center Selection** - Tracks which role centers include the overview

#### Pages
- **85000 - BAC Absence Registration Setup** - Setup page for configuration
- **85002 - BAC About Absence Registration** - Information about the app
- **85003 - BAC Absence Overview** - Main overview page (ListPart)

#### Codeunits
- **85000 - BAC Install Absence Overview** - Installation codeunit with OnInstallAppPerCompany trigger

### Key Logic

#### Absence Calculation
The app uses a temporary table to process employee absences:
1. Loads all Employee Absence records
2. Normalizes "To Date" (sets it to "From Date" if blank)
3. Filters based on "From Date" and future absence settings
4. Applies employee group dimension filter if specified
5. Displays matching records in the overview

#### Responsibility Center Integration
On page open, the app checks the user's setup for:
- Sales Responsibility Center Filter
- Purchase Responsibility Center Filter
- Service Responsibility Center Filter

If a responsibility center is found, it automatically filters by the associated employee group dimension value.

#### Date Navigation
- Uses date arithmetic (`FromDate += 1` or `FromDate -= 1`) for next/previous day navigation
- Triggers page refresh after date changes

## Customization

### Adding Custom Filters
The page uses a temporary table as its source, making it easy to extend the filtering logic in the `Initialize()` procedure.

### Extending to Additional Role Centers
To add the overview to additional role centers:
1. Create a new page extension in the `Page Extensions/` folder
2. Add a part control referencing page 85003 "BAC Absence Overview"
3. Update the Role Center Selection table if needed

### Modifying the Overview Display
Edit the `AbsenceRegistrationOverview.Page.al` file to:
- Add additional fields from the Employee Absence table
- Include calculated fields
- Change the layout or styling
- Add custom actions

## Dependencies

- **Base Application:** Microsoft Dynamics 365 Business Central 26.0
- **Required Tables:** Employee, Employee Absence, Dimension, Dimension Value, Default Dimension, Responsibility Center, User Setup

## Translations

The app includes translation support with an XLIFF file:
- `Translations/Absence Registration Overview.g.xlf`

Additional languages can be added by creating new translation files.

## Support & Resources

- **Help Documentation:** https://blog.versionmanager.dk/absence-registration-overview/
- **EULA:** https://ba-consult.dk/downloads/warranty.txt
- **GitHub Repository:** https://github.com/peikba/Absence-Registration
- **Source Code:** Available for download (configured in app.json)

## Best Practices

1. **Configure Employee Group Dimension** - Set up the Employee Group Dimension in the setup to enable filtering by departments, locations, or other groupings
2. **Set Appropriate Future Absence Limit** - Adjust the "Earliest Future Absence Reg." to match your organization's planning horizon
3. **Use Responsibility Centers** - Link employee groups to responsibility centers for automatic filtering
4. **Regular Data Maintenance** - Ensure employee absence records are kept up-to-date for accurate overview
5. **User Training** - Train users on the different filtering options to maximize the app's utility

## Version History

### 26.0.0.2 (Current)
- Compatible with Business Central 26.0
- Runtime 15.0
- NoImplicitWith feature enabled
- Translation file support

## License

This is an open-source solution. Source code is available for download and can be included in symbol files for debugging purposes.

## Disclaimer

See the warranty disclaimer at: https://ba-consult.dk/downloads/warrenty.txt

---

**© 2025 Bech-Andersen Consult ApS**
