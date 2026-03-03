using { sapit.bootcamp.fashion as db } from '../db/schema';

service BillingService {


  @odata.draft.enabled
  entity Orders as projection on db.Orders;

  entity Customers as projection on db.Customers;
  entity OrderStatus as projection on db.OrderStatus;
}