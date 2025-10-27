pageextension 85015 "BAC Sales Manager RC" extends "Sales Manager Role Center"
{
    layout
    {
        addbefore("User Tasks")
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}