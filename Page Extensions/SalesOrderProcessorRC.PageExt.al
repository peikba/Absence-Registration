pageextension 85000 "Sales Order Processor RC" extends "Order Processor Role Center"
{
    layout
    {
        addafter(Control1901851508)
        {
            part(AbsenceOverview; "BAC Absence Overview")
            {
                ApplicationArea = ALL;
            }
        }
    }
}