pageextension 85016 "BAC Purchasing Agent RC" extends "Purchasing Agent Role Center"
{
    layout
    {
        addbefore("User Tasks Activities")
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}