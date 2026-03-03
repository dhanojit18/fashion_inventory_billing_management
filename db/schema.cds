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


entity SKUs {
  product    : Association to one Products;
  inventory  : Association to one Inventory;

  size       : String(10);
  color      : String(30);
  key skuCode    : String(50);

  price      : Decimal(10,2);
  stock      : Integer;
}



entity Customers : cuid, managed {
  name   : String(150);
  email  : String(150);

  orders : Association to many Orders
           on orders.customer = $self;
}



entity Orders : cuid, managed {
  customer    : Association to one Customers;
  orderDate   : DateTime;
  totalAmount : Decimal(10,2);
  status      : Association to one OrderStatus;

  items       : Composition of many OrderItems
                on items.order = $self;
}

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
  pending   = 'P';
  confirmed = 'C';
  delivered = 'D';
  returned  = 'R';
};