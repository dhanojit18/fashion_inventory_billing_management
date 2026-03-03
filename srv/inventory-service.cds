using { sapit.bootcamp.fashion as db } from '../db/schema';

service InventoryService {

  @odata.draft.enabled
  entity Inventory as projection on db.Inventory;

  entity SKUs as projection on db.SKUs;

  entity Products as projection on db.Products;

  entity Categories as projection on db.Categories;

  entity Brands as projection on db.Brands;
}