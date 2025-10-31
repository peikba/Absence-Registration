page 85003 "BAC Absence Overview"
{
    Caption = 'Absence Overview';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Absence";
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    SaveValues = true;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                    ToolTip = 'Calculate the absences from this date - can also be in the past';

                    trigger OnValidate()
                    begin
                        Initialize();
                        CurrPage.Update();
                    end;
                }
                field(ShowFutureAbsence; ShowFutureAbsence)
                {
                    Caption = 'Show Future Absences';
                    OptionCaption = 'None,Limited,All';
                    ToolTip = 'Enable calculation of absences that start after the from date - None = No future absence registrations - Limited =  withing the the "Earliest Future Absence Registration - All = All future Absence Registrations';

                    trigger OnValidate()
                    begin
                        Initialize();
                        CurrPage.Update(false);
                    end;
                }
                field(EmployeeGroupFilter; EmployeeGroupFilter)
                {
                    ShowCaption = true;
                    CaptionClass = AbsRegSetup."Employee Group Name";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AbsenceSetup: Record "BAC Absence Registration Setup";
                        DimensionValue: Record "Dimension Value";
                        DimensionValues: Page "Dimension Value List";
                    begin
                        AbsenceSetup.Get();
                        DimensionValue.SetRange("Dimension Code", AbsenceSetup."Employee Group Dimension");
                        DimensionValues.SetTableView(DimensionValue);
                        DimensionValues.LookupMode(true);
                        if DimensionValues.RunModal() = Action::OK then begin
                            DimensionValues.GetRecord(DimensionValue);
                            "EmployeeGroupFilter" := DimensionValue.Code;
                            Initialize();
                            CurrPage.Update(false);
                        end;
                    end;

                    trigger OnValidate()
                    var
                        AbsenceSetup: Record "BAC Absence Registration Setup";
                        DimensionValue: Record "Dimension Value";
                    begin
                        AbsenceSetup.Get();
                        if EmployeeGroupFilter <> '' then
                            DimensionValue.Get(AbsenceSetup."Employee Group Dimension", "EmployeeGroupFilter");
                        Initialize();
                    end;

                }
            }
            repeater(GroupName)
            {
                Editable = false;
                field("Employee No."; Rec."Employee No.")
                {

                }
                field(EmployeeName; EmployeeName)
                {

                }
                field("From Date"; Rec."From Date")
                {

                }
                field("To Date"; Rec."To Date")
                {

                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field(Comment; Rec.Comment)
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Previous)
            {
                InFooterBar = true;
                Image = PreviousSet;
                ApplicationArea = All;
                Scope = Repeater;
                trigger OnAction()
                begin
                    FromDate -= 1;
                    Initialize();
                    CurrPage.Update();
                end;
            }
            action(Next)
            {
                InFooterBar = true;
                Image = NextSet;
                ApplicationArea = All;
                Scope = Repeater;
                trigger OnAction()
                begin
                    FromDate += 1;
                    Initialize();
                    CurrPage.Update();
                end;
            }
            action("Create New")
            {
                Caption = 'Create New';
                Image = New;
                RunObject = page "Absence Registration";
                RunPageMode = Create;
                Scope = Repeater;
            }
            action("Absence Registrations")
            {
                Caption = 'Absence Registrations';
                Image = Line;
                RunObject = page "Absence Registration";
                RunPageMode = View;
                Scope = Repeater;
            }
        }
    }
    var
        FromDate: Date;
        EmployeeName: Text[100];
        ShowFutureAbsence: Option None,Limited,All;
        EmployeeGroupFilter: Text;

    trigger OnAfterGetRecord()
    var
        Employee: Record Employee;
    begin
        if Employee.Get(Rec."Employee No.") then
            EmployeeName := employee.FullName()
        else
            EmployeeName := '';
    end;


    trigger OnOpenPage()
    var
        RespCenter: Record "Responsibility Center";
        RespCenterCode: Code[10];
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        case true of
            (UserSetup."Sales Resp. Ctr. Filter" <> ''):
                RespCenterCode := UserSetup."Sales Resp. Ctr. Filter";
            (UserSetup."Purchase Resp. Ctr. Filter" <> ''):
                RespCenterCode := UserSetup."Purchase Resp. Ctr. Filter";
            (UserSetup."Service Resp. Ctr. Filter" <> ''):
                RespCenterCode := UserSetup."Service Resp. Ctr. Filter";
        end;
        AbsRegSetup.Get();
        EmployeeGroupFilter := GetEmployeeGroupFilterFromRespCenter(RespCenterCode, AbsRegSetup."Employee Group Dimension");
        AbsRegSetup.CalcFields("Employee Group Name");
        FromDate := WorkDate();
        Initialize();
    end;

    var
        AbsRegSetup: Record "BAC Absence Registration Setup";

    local procedure Initialize();
    var
        TempEmployeeAbsence: Record "Employee Absence" temporary;
        EmployeeAbsence: Record "Employee Absence";
        EarliestFutureAbsReg: Date;
    begin
        if format(AbsRegSetup."Earliest Future Absence Reg.") <> '' then
            EarliestFutureAbsReg := CalcDate(AbsRegSetup."Earliest Future Absence Reg.", WorkDate())
        else
            EarliestFutureAbsReg := DMY2Date(31, 12, 9999);
        Rec.DeleteAll();
        if EmployeeAbsence.FindSet() then begin
            repeat
                TempEmployeeAbsence := EmployeeAbsence;
                if TempEmployeeAbsence."To Date" = 0D then
                    TempEmployeeAbsence."To Date" := TempEmployeeAbsence."From Date";
                TempEmployeeAbsence.insert();
            until EmployeeAbsence.Next() = 0;
        end;

        TempEmployeeAbsence.SetFilter("To Date", '>=%1', FromDate);
        if TempEmployeeAbsence.FindSet() then begin
            repeat
                if (ShowFutureAbsence = ShowFutureAbsence::All) or
                   ((ShowFutureAbsence = ShowFutureAbsence::Limited) and (TempEmployeeAbsence."From Date" <= EarliestFutureAbsReg)) or
                   ((ShowFutureAbsence = ShowFutureAbsence::None) and (TempEmployeeAbsence."From Date" <= FromDate)) then begin
                    if (EmployeeGroupFilter = '') or ((EmployeeGroupFilter <> '') and EmployeeIsMemberOfDimension(TempEmployeeAbsence."Employee No.", EmployeeGroupFilter)) then begin
                        Rec := TempEmployeeAbsence;
                        Rec.insert();
                    end;
                end;
            until TempEmployeeAbsence.Next() = 0;
        end;
    end;

    local procedure EmployeeIsMemberOfDimension(inEmployeeCode: Code[20]; inEmployeeGroupDimensionCode: code[10]): Boolean
    var
        DefaultDim: Record "Default Dimension";
    begin
        DefaultDim.SetRange("Table ID", Database::Employee);
        DefaultDim.SetRange("No.", inEmployeeCode);
        DefaultDim.SetRange("Dimension Code", AbsRegSetup."Employee Group Dimension");
        DefaultDim.SetRange("Dimension Value Code", inEmployeeGroupDimensionCode);
        exit(not DefaultDim.IsEmpty());
    end;

    local procedure GetEmployeeGroupFilterFromRespCenter(inRespCenterCode: Code[10]; inEmployeeGroupDimension: Code[10]) ReturnCode: Code[10];
    var
        DefaultDim: Record "Default Dimension";
    begin
        DefaultDim.SetRange("Table ID", Database::"Responsibility Center");
        DefaultDim.SetRange("Dimension Code", inEmployeeGroupDimension);
        DefaultDim.SetRange("No.", inRespCenterCode);
        if DefaultDim.FindFirst() then
            ReturnCode := DefaultDim."Dimension Value Code";
    end;

}