codeunit 85000 "BAC Install Absence Overview"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        AbsenceRegSetup: Record "BAC Absence Registration Setup";
    begin
        if not AbsenceRegSetup.Get() then begin
            AbsenceRegSetup.Init();
            Evaluate(AbsenceRegSetup."Earliest Future Absence Reg.", '<1W>');
            AbsenceRegSetup.Insert();
        end;
    end;
}