param location string
// param resourceGroup string
param deployStorage bool
param deployPrivateEndpoint bool
param deployLogAnalytics bool
param deployDataFactory bool
param deployKeyVault bool
param logAnalyticsName string
param containerA string
param containerB string
param storageAccountName string
param virtualNetworkName string
param privateEndpointName string
param privateLinkServiceConnName string

module stg './modules/storage.bicep' = if (deployStorage) {
  name: 'storageDeploy'
  params: {
    containerA: containerA
    containerB: containerB
    location: location
    storageAccountName: storageAccountName
  }
}

module privateEndpoint './modules/privateEndpoint.bicep' = if (deployPrivateEndpoint) {
  name: 'privateEndpointDeploy'
  params: {
    privateEndpointName: privateEndpointName
    privateLinkServiceConnName: privateLinkServiceConnName
    virtualNetworkName: virtualNetworkName
    storageID: stg.outputs.sid
    location: location
  }
}

module adf './modules/datafactory.bicep' = if (deployDataFactory) {
  name: 'factoryDeploy'
  params: {
    location: location
  }
}

module keyvault './modules/keyvault.bicep' = if (deployKeyVault) {
  name: 'keyvaultDeploy'
  params: {
    location: location
  }
}

module logAnalytics './modules/loganalytics.bicep' = if (deployLogAnalytics) {
  name: 'LogAnalyticsDeploy'
  params: {
    location: location
    logAnalyticsName: logAnalyticsName
    retentionInDays: 90
  }
}
