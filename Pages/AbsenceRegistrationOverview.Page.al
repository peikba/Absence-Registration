page 85000 "BAC Absence Overview"
{
    Caption = 'Absence Overview';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Absence";
    SourceTableTemporary = true;

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

                    trigger OnValidate()
                    begin
                        Initialize();
                        CurrPage.Update();
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
    begin
        FromDate := WorkDate();
        Initialize();
    end;

    local procedure Initialize()
    var
        TempEmployeeAbsence: Record "Employee Absence" temporary;
        EmployeeAbsence: Record "Employee Absence";
    begin
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
                Rec := TempEmployeeAbsence;
                Rec.insert();
            until TempEmployeeAbsence.Next() = 0;
        end;
    end;

}