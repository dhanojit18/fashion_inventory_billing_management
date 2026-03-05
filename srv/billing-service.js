const cds = require("@sap/cds");

module.exports = cds.service.impl(function () {

  const { Orders, OrderItems, SKUs } = this.entities;

  // Recalculate total whenever items change
this.before('CREATE', 'Orders', async (req) => {
  console.log("This si called");
  const aData = req.data?.items;
  let initialAmt = 0;
  for(let i =0; i < aData.length; i++){
    let iRes = (aData[i].price * aData[i].quantity);
    if(!isNaN(iRes)){
      initialAmt = initialAmt + iRes;
     }
    
  }
  req.data.totalAmount = initialAmt;
})
this.on("confirmOrder", Orders, async (req) => {

  const orderID = req.params?.[0]?.ID;

  const order = await SELECT.one
    .from(Orders, orderID)
    .columns(o => {
      o.status_code,
      o.items(i => {
        i.quantity,
        i.sku(s => {
          s.skuCode,
          s.stock
        })
      })
    });

  if (!order) req.error(404, "Order not found");

  if (order.status_code === "Confirmed")
    req.error("Order already confirmed");

  for (const item of order.items) {

    const skuCode = item.sku?.skuCode;
    const qty = item.quantity;

    if (!skuCode)
      req.error(400, "Order item SKU missing");

    const sku = await SELECT.one
      .from(SKUs)
      .where({ skuCode });

    if (!sku)
      req.error(404, `SKU not found: ${skuCode}`);

    if (sku.stock < qty)
      req.error(400, `Insufficient stock for SKU ${skuCode}`);

    await UPDATE(SKUs)
      .set({ stock: sku.stock - qty })
      .where({ skuCode });

  }

  await UPDATE(Orders)
    .set({ status_code: "Confirmed" })
    .where({ ID: orderID });
 
  return true;
});

});