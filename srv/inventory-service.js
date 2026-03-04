const cds = require('@sap/cds')

module.exports = class InventoryService extends cds.ApplicationService { init() {

  const { Inventory, SKUs, Products, Brands, Categories } = cds.entities('InventoryService')

  this.before (['CREATE', 'UPDATE'], Inventory, async (req) => {
    console.log('Before CREATE/UPDATE Inventory', req.data)
  })
  this.after ('READ', Inventory, async (inventory, req) => {
    console.log('After READ Inventory', inventory)
  })
  this.before (['CREATE', 'UPDATE'], SKUs, async (req) => {
    console.log('Before CREATE/UPDATE SKUs', req.data)
  })
  this.after ('READ', SKUs, async (sKUs, req) => {
    console.log('After READ SKUs', sKUs)
  })
  this.before (['CREATE', 'UPDATE'], Products, async (req) => {
    console.log('Before CREATE/UPDATE Products', req.data)
  })
  this.after ('READ', Products, async (products, req) => {
    console.log('After READ Products', products)
  })
  this.before (['CREATE', 'UPDATE'], Brands, async (req) => {
    console.log('Before CREATE/UPDATE Brands', req.data)
  })
  this.after ('READ', Brands, async (brands, req) => {
    console.log('After READ Brands', brands)
  })
  this.before (['CREATE', 'UPDATE'], Categories, async (req) => {
    console.log('Before CREATE/UPDATE Categories', req.data)
  })
  this.after ('READ', Categories, async (categories, req) => {
    console.log('After READ Categories', categories)
  })


  return super.init()
}}
