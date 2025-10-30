table 85000 "BAC Absence Registration Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Absence Registration Setup';

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(20; "Earliest Future Absence Reg."; DateFormula)
        {
            Caption = 'Earliest Future Absence Registration';
            ToolTip = 'How far into the future should absence registration start be included';
            DataClassification = SystemMetadata;
        }
        field(30; "Department Dimension"; Code[10])
        {
            Caption = 'Department Dimension';
            ToolTip = 'The Dimension functioning as a department selector for the overview';
            DataClassification = SystemMetadata;
            TableRelation = Dimension;
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