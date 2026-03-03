using BillingService as service from '../../srv/billing-service';
annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : customer.email,
                Label : '{i18n>CustomerEmail}',
            },
            {
                $Type : 'UI.DataField',
                Value : customer.name,
                Label : 'name',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            Label : '{i18n>OrderDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
            Label : '{i18n>BillingEmp}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>CustomerName}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>OrderValue}',
            Value : totalAmount,
        },
    ],
    UI.SelectionFields : [
        status_code,
    ],
    UI.ConnectedFields #connected : {
        $Type : 'UI.ConnectedFieldsType',
        Template : '{customer_email}Customer Name{customer_name}',
        Data : {
            $Type : 'Core.Dictionary',
            customer_email : {
                $Type : 'UI.DataField',
                Value : customer.email,
            },
            customer_name : {
                $Type : 'UI.DataField',
                Value : customer.name,
            },
        },
    },
);

annotate service.Orders with {
    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    }
};

annotate service.Orders with {
    status @(
        Common.Label : 'status_code',
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'OrderStatus',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'name',
                },
            ],
        },
        )
};

annotate service.OrderStatus with {
    name @(
        Common.Text : code,
        )};

annotate service.Customers with {
    email @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : email,
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : name,
)};

