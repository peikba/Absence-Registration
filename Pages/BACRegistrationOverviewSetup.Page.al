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
                    Caption = 'Earliest Future Absence Registration';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
        area(FactBoxes)
        {
            part(Logo; "BAC AL Logo FactBox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RoleCentersSelections)
            {
                Caption = 'RoleCenters Page Selections';
                ToolTip = 'Define which Select RoleCenters pages should be included';
                Promoted = true;
                PromotedCategory = Process;
                Image = List;
                RunObject = page "BAC Select RoleCenters";
                ApplicationArea = All;
            }
            action("About Absence Registration")
            {
                Caption = 'About Absence Registration';
                RunObject = page "BAC About Absence Registration";
                Image = AboutNav;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

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