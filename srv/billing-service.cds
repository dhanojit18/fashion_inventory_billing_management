using { sapit.bootcamp.fashion as db } from '../db/schema';

service BillingService {


  @odata.draft.enabled
  entity Orders as projection on db.Orders actions{
   @Common.SideEffects:{
    TargetProperties:['in/Orders','in/status_code']
   }
    action confirmOrder();
  };


  @Common.SideEffects : 
      {
          SourceProperties: ['quantity'],  
          TargetProperties :['order/totalAmount'],
      }
  entity OrderItems as projection on db.OrderItems;


  entity SKUs as projection on db.SKUs;
}