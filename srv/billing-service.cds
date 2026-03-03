using { sapit.bootcamp.fashion as db } from '../db/schema';

service BillingService {


  @odata.draft.enabled
  entity Orders as projection on db.Orders;
  action removeOrder(orderID: Integer) returns Boolean ;
  entity Customers as projection on db.Customers;

  entity SKUs as projection on db.SKUs;
}