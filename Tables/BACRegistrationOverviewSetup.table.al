table 85000 "BAC Absence Registration Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Absence Registration Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Earliest Future Absence Reg."; DateFormula)
        {
            Caption = 'Earliest Future Absence Registration';
            ToolTip = 'How far into the future should absence registration start be included';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

}