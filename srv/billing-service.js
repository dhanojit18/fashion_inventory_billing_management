const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

  const { Orders } = this.entities;

  this.before('CREATE', Orders, async (req) => {
    const tx = cds.transaction(req);

    let total = 0;

    for (const item of req.data.items || []) {

      const sku = await tx.read('sapit.bootcamp.fashion.SKUs')
        .where({ ID: item.sku_ID });

      if (!sku.length)
        req.error(404, 'SKU not found');

      if (sku[0].stock < item.quantity)
        req.error(400, `Insufficient stock for SKU ${sku[0].skuCode}`);

      total += item.quantity * item.price;
    }

    req.data.totalAmount = total;
  });

  this.after('CREATE', Orders, async (data, req) => {

    const tx = cds.transaction(req);
   

    for (const item of data.items || []) {

      await tx.run(
        UPDATE('sapit.bootcamp.fashion.SKUs')
          .set({ stock: { '-=': item.quantity } })
          .where({ ID: item.sku_ID })
      );
    }
  });

});