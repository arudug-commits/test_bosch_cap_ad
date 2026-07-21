const cds = require('@sap/cds')

module.exports = class MyService extends cds.ApplicationService { init() {



  this.on ('hello', async (req) => {
    console.log('On hello', req.data.name)
    return `Hello ${req.data.name}`
  })

  return super.init()
}}
