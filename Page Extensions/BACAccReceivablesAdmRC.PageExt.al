pageextension 85013 "BAC Acc. Receivables Adm RC" extends "Acc. Receivables Adm. RC"
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