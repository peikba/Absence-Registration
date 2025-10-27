pageextension 85001 "BAC Finance Manager RC" extends "Finance Manager Role Center"
{
    layout
    {
        addfirst(RoleCenter)
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}