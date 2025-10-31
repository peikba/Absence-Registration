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
            ToolTip = 'How far into the future should absence registration start be included using the ''Limited'' option';
            DataClassification = SystemMetadata;
        }
        field(30; "Employee Group Dimension"; Code[10])
        {
            Caption = 'Employee Group Dimension';
            ToolTip = 'The Dimension functioning as a Employee Group selector for the overview';
            DataClassification = SystemMetadata;
            TableRelation = Dimension;
        }
        field(40; "Employee Group Name"; Text[100])
        {
            Caption = 'Employee Group Name';
            ToolTip = 'The Employee Group name for the overview';
            FieldClass = FlowField;
            CalcFormula = lookup(Dimension.Name where(Code = field("Employee Group Dimension")));
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