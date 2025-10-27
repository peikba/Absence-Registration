pageextension 85030 "BAC Business Manager RC" extends "Business Manager Role Center"
{
    layout
    {
        addbefore("User Tasks Activities")
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=true;
                ApplicationArea = ALL;
            }
        }
    }
}