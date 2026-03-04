const cds = require('@sap/cds')

module.exports = class AdminService extends cds.ApplicationService { init() {

  const { Inventory, InventoryManagers, Categories, Brands, OrderStatus } = cds.entities('AdminService')

  this.before (['CREATE', 'UPDATE'], Inventory, async (req) => {
    console.log('Before CREATE/UPDATE Inventory', req.data)
  })
  this.after ('READ', Inventory, async (inventory, req) => {
    console.log('After READ Inventory', inventory)
  })
  this.before (['CREATE', 'UPDATE'], InventoryManagers, async (req) => {
    console.log('Before CREATE/UPDATE InventoryManagers', req.data)
  })
  this.after ('READ', InventoryManagers, async (inventoryManagers, req) => {
    console.log('After READ InventoryManagers', inventoryManagers)
  })
  this.before (['CREATE', 'UPDATE'], Categories, async (req) => {
    console.log('Before CREATE/UPDATE Categories', req.data)
  })
  this.after ('READ', Categories, async (categories, req) => {
    console.log('After READ Categories', categories)
  })
  this.before (['CREATE', 'UPDATE'], Brands, async (req) => {
    console.log('Before CREATE/UPDATE Brands', req.data)
  })
  this.after ('READ', Brands, async (brands, req) => {
    console.log('After READ Brands', brands)
  })
  this.before (['CREATE', 'UPDATE'], OrderStatus, async (req) => {
    console.log('Before CREATE/UPDATE OrderStatus', req.data)
  })
  this.after ('READ', OrderStatus, async (orderStatus, req) => {
    console.log('After READ OrderStatus', orderStatus)
  })


  return super.init()
}}
