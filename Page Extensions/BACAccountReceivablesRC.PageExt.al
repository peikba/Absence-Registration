pageextension 85035 "BAC Account Receivables RC" extends "Account Receivables"
{
    layout
    {
        addbefore("User Task Activities")
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                Visible=false;
                ApplicationArea = ALL;
            }
        }
    }
}