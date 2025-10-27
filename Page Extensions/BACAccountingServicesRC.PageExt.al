pageextension 85031 "BAC Accounting Services RC" extends "Accounting Services RC"
{
    layout
    {
        addafter(Control1)
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}