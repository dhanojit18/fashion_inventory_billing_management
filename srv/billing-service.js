const cds = require("@sap/cds");

module.exports = cds.service.impl(function () {
  const { Orders, SKUs } = this.entities;

  // Bound action: Orders.confirmOrder()
  this.on("confirmOrder", Orders, async (req) => {
    const tx = cds.transaction(req);

    const orderID = req.params?.[0]?.ID;
    if (!orderID) req.error(400, "Order ID missing");

    // Read order + items + SKU (skuCode, stock)
    const order = await tx.run(
      SELECT.one.from(Orders, orderID).columns((o) => {
        o.ID,
          o.totalAmount,
          o.status_code, // FK for association Orders.status -> OrderStatus
          o.items((i) => {
            i.quantity,
              i.price,
              i.sku((s) => {
                s.skuCode, s.stock;
              });
          });
      })
    );

    if (!order) req.error(404, "Order not found");

    // optional: prevent confirming twice
    if (order.status_code === "C") return true;

    let total = 0;

    for (const item of order.items || []) {
      const skuCode = item?.sku?.skuCode;
      const qty = Number(item?.quantity || 0);
      const price = Number(item?.price || 0);

      if (!skuCode) req.error(400, "Order item SKU missing");
      if (!Number.isFinite(qty) || qty <= 0) req.error(400, `Invalid quantity for SKU ${skuCode}`);

      // Re-read SKU to avoid stale expanded data
      const sku = await tx.run(
        SELECT.one.from(SKUs).columns("skuCode", "stock").where({ skuCode })
      );
      if (!sku) req.error(404, `SKU not found: ${skuCode}`);

      if ((sku.stock ?? 0) < qty) {
        req.error(400, `Insufficient stock for SKU ${skuCode}`);
      }

      // Deduct stock
      await tx.run(
        UPDATE(SKUs)
          .set({ stock: sku.stock - qty })
          .where({ skuCode })
      );

      total += qty * price;
    }

    // Confirm the order + update total (optional but usually desired)
    await tx.run(
      UPDATE(Orders)
        .set({
          totalAmount: total,
          status_code: "C", // OrderStatusCode.confirmed = 'C'
        })
        .where({ ID: orderID })
    );

    return true;
  });
});