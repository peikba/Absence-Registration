pageextension 85032 "BAC Sales & Relationship RC" extends "Sales & Relationship Mgr. RC"
{
    layout
    {
        addlast(rolecenter)
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}