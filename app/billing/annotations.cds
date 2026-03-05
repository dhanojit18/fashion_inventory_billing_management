using BillingService as service from '../../srv/billing-service';
using from '../../db/schema';

annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Order Date ',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Total Amount',
                Value : totalAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Order Status',
                Value : status_code,
                Criticality : status.criticality,
                CriticalityRepresentation : #WithIcon,
            },
            {
                $Type : 'UI.DataField',
                Value : Customeremail,
                Label : 'Customer Email',
            },
            {
                $Type : 'UI.DataField',
                Value : BillingAddress,
                Label : 'BillingAddress',
            },
            {
                $Type : 'UI.DataField',
                Value : RequestedDeliveryDate,
                Label : 'RequestedDeliveryDate',
            },
            {
                $Type : 'UI.DataField',
                Value : ShippingAddress,
                Label : 'ShippingAddress',
            },
            {
                $Type : 'UI.DataField',
                Value : OrderNumber,
                Label : 'OrderNumber',
            },
            {
                $Type : 'UI.DataField',
                Value : OrderType,
                Label : 'OrderType',
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
            Value : OrderNumber,
            Label : 'OrderNumber',
        },
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
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : BillingAddress,
            Label : 'BillingAddress',
        },
        {
            $Type : 'UI.DataField',
            Value : OrderType,
            Label : 'OrderType',
        },
        {
            $Type : 'UI.DataField',
            Value : Customeremail,
            Label : 'Customeremail',
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : RequestedDeliveryDate,
            Label : 'RequestedDeliveryDate',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Order Details',
        TypeNamePlural : 'Order Details',
        TypeImageUrl : 'sap-icon://customer-order-entry',
        Description : {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        Title : {
            $Type : 'UI.DataField',
            Value :  'Order Details',
        },
        
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BillingService.confirmOrder',
            Label : 'Confirm Order',
             ![@UI.Hidden] : { $edmJson :  {$Or : [
            { $Eq : [ { $Path : 'IsActiveEntity' }, false ] },
            { $Eq : [ { $Path : 'status_code' }, 'Confirmed' ] }
          ] }}
    },
    ],
    UI.UpdateHidden: { $edmJson : { $Eq : [ { $Path : 'status_code' }, 'Confirmed' ] } },
     UI.DeleteHidden: { $edmJson : { $Eq : [ { $Path : 'status_code' }, 'Confirmed' ] } },
   
);



annotate service.OrderItems with @(
    UI.LineItem #Items : [
        
        {
            $Type : 'UI.DataField',
            Value : sku_skuCode,
            Label : 'SKU Code',
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : 'Price',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Quantity ',
        }
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
annotate service.Orders with {
    status @(
        UI.MultiLineText : true,
        Common.FieldControl : #ReadOnly,
        )
};

annotate service.Orders with {
    totalAmount @Common.FieldControl : #ReadOnly
};
annotate service.OrderItems with @Common.SideEffects: {
    SourceProperties  : ['in/items_quantity'],
    TargetProperties  : ['in/totalAmount']
};


annotate service.Orders with {
    OrderType @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Orders',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OrderType,
                    ValueListProperty : 'OrderType',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #Mandatory,
        Common.Label : 'Order Type',
)};

annotate service.Orders with {
    BillingAddress @Common.FieldControl : #Mandatory
};

annotate service.Orders with {
    ShippingAddress @Common.FieldControl : #Optional
};

annotate service.Orders with {
    OrderNumber @(
        Common.FieldControl : #Mandatory,
        Common.Label : 'Order Number',
        )
};

annotate service.Orders with @(
  Common.SideEffects #confirmOrder : {
    TargetProperties : [
      status_code,
      totalAmount
    ],
    TargetEntities : [
      Orders
    ]
  }
);
annotate service.Orders with {
    RequestedDeliveryDate @(
        Common.Label : 'Requested Delivery Date',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Orders',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : RequestedDeliveryDate,
                    ValueListProperty : 'RequestedDeliveryDate',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

