using { sapit.bootcamp.fashion as db } from '../db/schema';

service AdminService {

  entity Products as projection on db.Products;
  entity Orders as projection on db.Orders;
  entity Customers as projection on db.Customers;
  entity Inventory as projection on db.Inventory;

  
  entity Categories as projection on db.Categories;

  
  entity OrderStatus as projection on db.OrderStatus;

  
  entity InventoryManagers as projection on db.InventoryManagers;
}