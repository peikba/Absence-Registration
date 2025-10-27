table 85001 "BAC Role Center Selection"
{
    Caption = 'Role Center Selection';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = SystemMetadata;
        }
        field(2; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Object ID")
        {
            Clustered = true;
        }
    }
}