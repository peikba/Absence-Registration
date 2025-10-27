pageextension 85034 "BAC Team Member RC" extends "Team Member Role Center"
{
    layout
    {
        addafter(Control11)
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}