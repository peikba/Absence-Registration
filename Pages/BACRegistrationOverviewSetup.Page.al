page 85000 "BAC Absence Registration Setup"
{
    Caption = 'Absence Registration Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BAC Absence Registration Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Earliest Future Absence Reg."; Rec."Earliest Future Absence Reg.")
                {
                }
                field("Department Dimension"; Rec."Department Dimension")
                {
                }
            }
        }
        area(FactBoxes)
        {
            part(Logo; "BAC AL Logo FactBox")
            {
            }
            part(About; "BAC About Absence Registration")
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RoleCentersSelections)
            {
                Caption = 'RoleCenters Page Overview';
                ToolTip = 'See which RoleCenters pages are included';
                Promoted = true;
                PromotedCategory = Process;
                Image = List;
                RunObject = page "BAC Select RoleCenters";
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            REc.Insert();
        end;

    end;

}