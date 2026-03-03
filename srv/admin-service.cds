using { sapit.bootcamp.fashion as db } from '../db/schema';

service AdminService {


  entity Inventory as projection on db.Inventory;

  entity Categories as projection on db.Categories;

  entity Brands as projection on db.Brands;

  entity OrderStatus as projection on db.OrderStatus;

  entity InventoryManagers as projection on db.InventoryManagers;
}