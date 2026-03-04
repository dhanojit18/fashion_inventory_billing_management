using BillingService as service from '../../srv/billing-service';
using from '../../db/schema';

annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Date ',
                Value : orderDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Total ',
                Value : totalAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status ',
                Value : status_code,
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
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items ',
            ID : 'Items',
            Target : 'items/@UI.LineItem#Items',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Total Amount ',
            Value : totalAmount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status ',
            Value : status_code,
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Date ',
            Value : orderDate,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BillingService.confirmOrder',
            Label : 'confirmOrder',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Order Details',
        TypeNamePlural : 'Order Details',
        Title : {
            $Type : 'UI.DataField',
            Value : orderDate,
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

annotate service.OrderItems with @(
    UI.LineItem #Items : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : 'Price ',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Quantity ',
        },
        {
            $Type : 'UI.DataField',
            Value : sku_skuCode,
            Label : 'SKU Code ',
        },
    ]
);

annotate service.OrderItems with {
    sku @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'SKUs',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : sku_skuCode,
                    ValueListProperty : 'skuCode',
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    ValueListProperty : 'price',
                    LocalDataProperty : price,
                },
            ],
            Label : 'SKU Code',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.SKUs with @Common.SideEffects: {
    SourceProperties  : ['in/skuCode'],
    TargetProperties  : ['in/price']
};