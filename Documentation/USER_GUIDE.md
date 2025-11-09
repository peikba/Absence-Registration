# User Guide - Absence Registration Overview

## Table of Contents
1. [Getting Started](#getting-started)
2. [Accessing the Absence Overview](#accessing-the-absence-overview)
3. [Understanding the Interface](#understanding-the-interface)
4. [Filtering Absences](#filtering-absences)
5. [Navigating Dates](#navigating-dates)
6. [Creating Absence Registrations](#creating-absence-registrations)
7. [Tips and Best Practices](#tips-and-best-practices)
8. [Troubleshooting](#troubleshooting)

---

## Getting Started

### What is the Absence Registration Overview?

The Absence Registration Overview helps you quickly see which employees are absent on any given day. Whether you're a manager checking team availability, HR tracking absences, or an administrator monitoring company-wide attendance, this tool provides instant visibility.

### First-Time Setup

Before using the overview, an administrator needs to configure the app:

1. Search for **"Absence Registration Setup"** in Business Central
2. Configure the following:
   - **Earliest Future Absence Reg.**: How far ahead to show future absences (default: 1 week)
   - **Employee Group Dimension**: Select a dimension for grouping employees (e.g., Department)

> **Note:** You can start using the overview without configuring the Employee Group Dimension, but you won't be able to filter by groups.

---

## Accessing the Absence Overview

### From Your Role Center

The Absence Overview automatically appears on your role center after the app is installed. It's typically displayed as a list in one of the content areas.

### Direct Access

1. Open the search (Alt + Q)
2. Type **"Absence Overview"**
3. Select the page from the results

---

## Understanding the Interface

### Filter Section

At the top of the overview, you'll find three filter controls:

| Filter | Purpose | Example |
|--------|---------|---------|
| **From Date** | Starting date for viewing absences | 01/15/2025 |
| **Show Future Absences** | Controls which future absences appear | None, Limited, or All |
| **Employee Group** | Filter by department or other grouping | Sales Department |

### Absence List

Below the filters, you'll see a list showing:

- **Employee No.** - The employee's identification number
- **Employee Name** - Full name of the employee
- **From Date** - When the absence starts
- **To Date** - When the absence ends
- **Cause of Absence Code** - Reason code (e.g., SICK, VACATION)
- **Description** - Full description of the absence reason
- **Comment** - Any additional notes about the absence

---

## Filtering Absences

### Setting the From Date

The **From Date** determines which absences you see. 

**To change the From Date:**
1. Click in the **From Date** field
2. Type a date or use the date picker
3. Press Enter

The list automatically updates to show absences from that date forward.

**Examples:**
- Set to today (01/15/2025) → See who is absent today and in the future
- Set to yesterday (01/14/2025) → See recent absences
- Set to next week (01/22/2025) → Plan ahead for upcoming absences

### Show Future Absences Options

This setting controls how far into the future you can see absences.

#### None
Shows only absences that started on or before the **From Date**.

**Use when:** You only want to see current absences, not planned future ones.

**Example:**
- From Date: 01/15/2025
- Shows: Absences that started on 01/15 or earlier
- Hides: Absences starting on 01/16 or later

#### Limited
Shows absences within a specific time window (defined in setup, typically 1 week).

**Use when:** You want to plan for the near future without being overwhelmed by distant absences.

**Example:**
- From Date: 01/15/2025
- Limit: 1 week
- Shows: Absences starting between 01/15 and 01/22
- Hides: Absences starting after 01/22

#### All
Shows all future absence registrations, regardless of start date.

**Use when:** You need complete visibility into all planned absences.

**Example:**
- From Date: 01/15/2025
- Shows: All absences from 01/15 forward, even those months away

### Filtering by Employee Group

If your administrator has configured an Employee Group Dimension, you can filter by groups.

**To filter by employee group:**
1. Click in the **Employee Group** field
2. Click the lookup button (three dots) or press F6
3. Select a dimension value (e.g., "SALES", "WAREHOUSE", "ADMIN")
4. The list updates to show only employees in that group

**To clear the filter:**
1. Click in the **Employee Group** field
2. Delete the value
3. Press Enter

> **Automatic Filtering:** If you have a Responsibility Center assigned in your user setup, the overview automatically filters to your group when you open it.

---

## Navigating Dates

### Using the Navigation Buttons

At the bottom of the page, you'll find navigation buttons:

#### Previous Button
- Moves the **From Date** back by one day
- Refreshes the list to show absences for the previous day

**Example:**
- Current From Date: 01/15/2025
- Click Previous
- New From Date: 01/14/2025

#### Next Button
- Moves the **From Date** forward by one day
- Refreshes the list to show absences for the next day

**Example:**
- Current From Date: 01/15/2025
- Click Next
- New From Date: 01/16/2025

### Quick Navigation Tips

**To jump to today:**
1. Click in the From Date field
2. Press Ctrl + Home (or type "t" and press Enter)

**To move one week ahead:**
1. Note current date (e.g., 01/15/2025)
2. Click Next button 7 times
3. Or type the date directly (01/22/2025)

**To see last week:**
1. Set From Date to 7 days ago
2. Use "None" or "Limited" to see what absences were active then

---

## Creating Absence Registrations

### Creating a New Absence

**From the Absence Overview:**
1. Click the **Create New** button
2. The Absence Registration page opens
3. Fill in the required fields:
   - **Employee No.** - Select the employee
   - **From Date** - Start date of absence
   - **To Date** - End date (optional - defaults to From Date)
   - **Cause of Absence Code** - Select reason (e.g., SICK, VACATION)
   - **Comment** - Add any additional notes
4. Click OK to save

The new absence will appear in the overview according to your current filters.

### Viewing All Absence Registrations

**To see the complete list:**
1. Click the **Absence Registrations** button
2. The full Absence Registration list page opens
3. Here you can:
   - View all absence records
   - Edit existing absences
   - Delete absences (if you have permission)
   - Create new absences

---

## Tips and Best Practices

### Daily Workflow

**For Managers:**
1. Open your role center each morning
2. Check the Absence Overview part
3. From Date is automatically set to today
4. Review who is absent today
5. Click Next to see tomorrow's planned absences
6. Plan work assignments accordingly

**For HR Administrators:**
1. Use "All" future absences setting
2. Review upcoming absences for patterns
3. Filter by employee group to check department coverage
4. Create absence records as employees request time off

### Planning Ahead

**Weekly Planning:**
- Set From Date to the start of next week
- Use "Limited" to see the full week
- Navigate day by day to check coverage

**Monthly View:**
- Set From Date to the first of the month
- Use "All" to see all absences that month
- Filter by employee group to review each department

### Efficient Filtering

**Quick Department Check:**
1. Use Employee Group filter for your department
2. The filter persists as you navigate dates
3. Change dates freely while keeping group filter active

**Clear All Filters:**
1. Set From Date to today
2. Clear Employee Group filter
3. Set Show Future Absences to your preference

### Keyboard Shortcuts

- **Alt + Q** - Open search to find Absence Overview
- **F6** - Open lookup for Employee Group filter
- **Ctrl + Home** - Jump to today in date fields
- **Enter** - Apply filter changes
- **Tab** - Move between filter fields

---

## Troubleshooting

### "I don't see any absences"

**Possible causes:**

1. **No absences registered**
   - Check if absence records exist in Absence Registrations
   - Create test absence to verify

2. **From Date is too far in the future**
   - Set From Date to today or earlier
   - Existing absences might be in the past

3. **Future Absence setting is too restrictive**
   - Change "Show Future Absences" to "All"
   - Check if absences appear

4. **Employee Group filter too narrow**
   - Clear the Employee Group filter
   - See if more absences appear

### "The Employee Group filter is empty"

**Solution:**
- The Employee Group Dimension hasn't been configured
- Contact your administrator to set this up in Absence Registration Setup

### "I can't create new absences"

**Possible causes:**

1. **Insufficient permissions**
   - You need write access to Employee Absence table
   - Contact your administrator

2. **Button not visible**
   - Scroll down to see the Actions area
   - Or use search to open Absence Registration directly

### "Absences are showing the wrong dates"

**Check:**
1. **From Date setting** - Ensure it's set to the date you want to view
2. **To Date in records** - Some absences might have blank To Dates (uses From Date)
3. **Show Future Absences** - Verify this setting matches your intent

### "The overview is not on my role center"

**Possible causes:**

1. **App not installed** - Contact administrator to install the app
2. **Role center not supported** - Check if your role center is in the supported list
3. **Need to refresh** - Sign out and sign back in to Business Central

### "Performance is slow"

**If you have many employees:**
1. Always use Employee Group filter to limit results
2. Use "None" or "Limited" instead of "All" for future absences
3. Contact administrator if performance doesn't improve

---

## Common Scenarios

### Scenario 1: "Who is out sick today?"

1. Ensure From Date is set to today
2. Use "None" for Show Future Absences
3. Look for absences with Cause Code "SICK"
4. Check employee names for your team

### Scenario 2: "Plan coverage for next week"

1. Set From Date to Monday of next week
2. Use "Limited" or "All" for Show Future Absences
3. Navigate day-by-day using Next button
4. Note employees absent each day
5. Assign coverage as needed

### Scenario 3: "Check if John Smith has any upcoming absences"

1. Click Absence Registrations button
2. Filter Employee No. for John Smith
3. Review From Date and To Date
4. Note Cause of Absence

### Scenario 4: "See all Sales Department absences"

1. Set Employee Group filter to "SALES"
2. Set From Date to today
3. Use "All" to see all future absences
4. Review complete list for the department

### Scenario 5: "Register an employee's absence"

1. Click Create New
2. Select Employee No.
3. Enter From Date (when absence starts)
4. Enter To Date (when they return - 1 day)
5. Select Cause of Absence Code
6. Add Comment if needed
7. Click OK

---

## Getting Help

- **Documentation:** https://blog.versionmanager.dk/absence-registration-overview/
- **GitHub Repository:** https://github.com/peikba/Absence-Registration
- **Support:** Contact Bech-Andersen Consult ApS or your Business Central administrator

---

**User Guide Version:** 1.0  
**Last Updated:** November 9, 2025  
**Compatible with:** Business Central 26.0
