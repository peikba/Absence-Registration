pageextension 85020 "BAC Shop Supervisor Mfg RC" extends "Shop Supervisor Mfg Foundation"
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