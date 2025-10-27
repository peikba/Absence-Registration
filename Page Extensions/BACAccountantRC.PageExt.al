pageextension 85033 "BAC Accountant RC" extends "Accountant Role Center"
{
    layout
    {
        addbefore("User Tasks Activities")
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = all;
            }
        }
    }
}