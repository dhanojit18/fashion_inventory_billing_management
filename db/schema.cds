namespace sapit.bootcamp.fashion;

using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';


entity Inventory : cuid, managed {
  name      : String(100);
  location  : String(150);

  managers  : Composition of many InventoryManagers
              on managers.inventory = $self;

  skus      : Composition of many SKUs
              on skus.inventory = $self;
}

entity InventoryManagers : cuid {
  userId    : String(100);
  inventory : Association to one Inventory;
}



entity Products : cuid, managed {
  productName : String(150);
  description : String(500);
  brand       : Association to one Brands;
  category    : Association to one Categories;
  season      : Season;
  gender      : Gender;
  basePrice   : Decimal(10,2);

  skus        : Association to many SKUs
                on skus.product = $self;
}

entity Brands : cuid, managed {
  name : String(100);
}

entity Categories : cuid, managed {
  name : String(100);
}

@Analytics.AnalyticalContext
@Analytics.query: true
@Aggregation.ApplySupported  : {
    $Type : 'Aggregation.ApplySupportedType',
    
}
@Aggregation.LeveledHierarchy  : [
    
]
entity SKUs {
  product    : Association to one Products;
  inventory  : Association to one Inventory;

  size       : String(10);
  color      : String(30);
  key skuCode    : String(50);
 @Analytics.measure: true
  price      : Decimal(10,2);
   @Analytics.measure: true
  stock      : Integer;
}







entity Orders : cuid, managed {
  Customername   : String(150);
  Customeremail  : String(150);
OrderNumber            : String(30);   // Business Order Number

  OrderType              : OrderType;     
  RequestedDeliveryDate  : Date;
BillingAddress         : String(300);
  ShippingAddress        : String(300);
 

 status : Association to one OrderStatus default 'Pending';

 totalAmount : Decimal(10,2) default 0;

  items       : Composition of many OrderItems
                on items.order = $self;
}
type OrderType : String enum {
  Standard = 'STANDARD';
  Rush     = 'RUSH';
  Return   = 'RETURN';
  Credit   = 'CREDIT';
};
entity OrderItems : cuid {
  order    : Association to one Orders;
  sku      : Association to one SKUs;
  quantity : Integer;
  price    : Decimal(10,2);
}



entity OrderStatus : CodeList {
  key code    : OrderStatusCode;
  criticality : Integer;
}



type Season : String enum {
  spring = 'SP';
  summer = 'SU';
  autumn = 'AU';
  winter = 'WI';
};

type Gender : String enum {
  men   = 'MEN';
  women = 'WOM';
  kids  = 'KID';
  unisex = 'UNI';
};

type OrderStatusCode : String enum {
    Pending = 'Pending';
  Confirmed = 'Confirmed';
};