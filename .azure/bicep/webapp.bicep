param location string = 'westeurope'
param webAppName string = 'app-helloweb'
param appServicePlanName string = 'plan-helloweb'
param sku string = 'S1'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'app'
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  kind: 'app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}

resource deploymentSlot 'Microsoft.Web/sites/slots@2020-06-01' = {
  parent: appService
  name: 'staging'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|7.0'
    }
  }
}
