param webAppName string = 'app-helloweb'
param resourceGroupName string = 'rgDemoHelloWeb' 
param location string = 'westeurope'
param sku string = 'S1'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module wa 'webapp.bicep' = {
  name: webAppName
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    webAppName: webAppName
    sku: sku
  }
  dependsOn: [rg]
}
