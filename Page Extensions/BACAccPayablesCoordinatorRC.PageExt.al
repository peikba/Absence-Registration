pageextension 85012 "BAC Acc. Payables Coordinator" extends "Acc. Payables Coordinator RC"
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