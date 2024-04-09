targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string

// module deployed at subscription level
module newRG 'rg.bicep' = {
  name: resourceGroupName
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
}

// Create an Azure Container App running NGINX
module containerApp 'container-app.bicep' = {
  name: 'containerApp'
  scope: resourceGroup(resourceGroupName)
  params: {
    containerAppName: 'mycontainerapp'
    location: resourceGroupLocation
  }
}

output containerAppFQDN string = containerApp.outputs.containerAppUrl
