pageextension 85028 "BAC CEO and President RC" extends "CEO and President Role Center"
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