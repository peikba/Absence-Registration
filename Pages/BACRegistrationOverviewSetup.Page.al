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
                field("Default Message Text"; Rec."Default Message Text")
                {
                    Caption = 'Default Message Text';
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Enter the Default Document Text to be shown on the Role Center - %1 in the text will insert the company name';
                }
                field("Default Message URL"; Rec."Default Message URL")
                {
                    Caption = 'Default Message URL';
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Enter the URL to be used on the Role Center when clicking on the headline';
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

}