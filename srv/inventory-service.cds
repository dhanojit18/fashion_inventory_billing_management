using { sapit.bootcamp.fashion as db } from '../db/schema';

service InventoryService {

  @odata.draft.enabled
  entity Inventory as projection on db.Inventory;

  entity Products as projection on db.Products;

  entity Categories as projection on db.Categories;
}