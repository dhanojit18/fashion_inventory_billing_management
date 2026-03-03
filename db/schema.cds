namespace sapit.bootcamp.fashion;

using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';


entity Inventory : cuid, managed {
  inventoryName : String(100);
  location      : String(150);

  managers : Composition of many InventoryManagers
             on managers.inventory = $self;

  products : Composition of many Products
             on products.inventory = $self;
}



entity InventoryManagers : cuid {
  userId    : String(100);  
  inventory : Association to one Inventory;
}



entity Products : cuid, managed {
  name        : String(150);
  description : String(500);
  price       : Decimal(10,2);
  stock       : Integer;
  size        : String(10);
  status      : ProductStatus;

  inventory   : Association to one Inventory;

  categories  : Composition of many ProductToCategory
                on categories.product = $self;
}



entity Categories : cuid, managed {
  name : String(100);

  products : Composition of many ProductToCategory
             on products.category = $self;
}

entity ProductToCategory : cuid {
  key product  : Association to one Products;
  key category : Association to one Categories;
}



entity Customers : cuid, managed {
  name    : String(150);
  email   : String(150);

  orders  : Association to many Orders
            on orders.customer = $self;
}



entity Orders : cuid, managed {
  customer    : Association to one Customers;
  totalAmount : Decimal(10,2);
  status      : Association to one OrderStatus;

  items       : Composition of many OrderItems
                on items.order = $self;
}

entity OrderItems : cuid {
  order    : Association to one Orders;
  product  : Association to one Products;
  quantity : Integer;
  price    : Decimal(10,2);
}



entity OrderStatus : CodeList {
  key code    : OrderStatusCode;
  criticality : Integer;
}


type ProductStatus : String enum {
  active   = 'ACT';
  inactive = 'INA';
};

type OrderStatusCode : String enum {
  pending   = 'P';
  delivered = 'D';
  returned  = 'R';
};