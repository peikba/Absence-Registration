page 85001 "BAC Select RoleCenters"
{
    Caption = 'Included RoleCenters';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AllObjWithCaption;
    SourceTableView = where("Object Type" = const(Page), "Object Subtype" = filter('RoleCenter'));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Object ID"; Rec."Object ID")
                {

                }
                field("Object Name"; Rec."Object Name")
                {

                }
                field(RoleCenterSelected; RoleCenterSelected)
                {
                    Visible = false;
                    trigger OnValidate()
                    var
                        RCSelection: Record "BAC Role Center Selection";
                    begin
                        if RCSelection.Get(Rec."Object ID") then begin
                            RCSelection.Selected := RoleCenterSelected;
                            RCSelection.Modify();
                        end else begin
                            RCSelection.Init();
                            RCSelection."Object ID" := Rec."Object ID";
                            RCSelection.Insert();
                        end;
                    end;

                }
            }
        }
        area(Factboxes)
        {

        }
    }
    trigger OnOpenPage()
    var
        RoleCenterFilter: Text;
    begin
        RoleCenterFilter := '8900|';
        RoleCenterFilter += '8901|';
        RoleCenterFilter += '8904|';
        RoleCenterFilter += '8905|';
        RoleCenterFilter += '9000|';
        RoleCenterFilter += '9001|';
        RoleCenterFilter += '9002|';
        RoleCenterFilter += '9003|';
        RoleCenterFilter += '9006|';
        RoleCenterFilter += '9007|';
        RoleCenterFilter += '9008|';
        RoleCenterFilter += '9009|';
        RoleCenterFilter += '9010|';
        RoleCenterFilter += '9011|';
        RoleCenterFilter += '9012|';
        RoleCenterFilter += '9013|';
        RoleCenterFilter += '9014|';
        RoleCenterFilter += '9015|';
        RoleCenterFilter += '9016|';
        RoleCenterFilter += '9017|';
        RoleCenterFilter += '9018|';
        RoleCenterFilter += '9019|';
        RoleCenterFilter += '9020|';
        RoleCenterFilter += '9022|';
        RoleCenterFilter += '9023|';
        RoleCenterFilter += '9026|';
        RoleCenterFilter += '9027|';
        RoleCenterFilter += '9028|';
        RoleCenterFilter += '9077';
        Rec.SetFilter("Object ID", RoleCenterFilter);
    end;

    trigger OnAfterGetRecord()
    var
        RCSelection: Record "BAC Role Center Selection";
    begin
        if RCSelection.Get(Rec."Object ID") then
            RoleCenterSelected := RCSelection.Selected
        else
            clear(RoleCenterSelected);
    end;

    var
        RoleCenterSelected: Boolean;
}