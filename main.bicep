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
param containerC string
param containerD string
param storageA string
param storageB string
param virtualNetworkName string
param DataprivateEndpointName string
param LogsprivateEndpointName string
param DataprivateLinkServiceConnName string
param LogsprivateLinkServiceConnName string

module stg './modules/storage.bicep' = if (deployStorage) {
  name: 'storageDeploy'
  params: {
    containerA: containerA
    containerB: containerB
    containerC: containerC
    containerD: containerD
    location: location
    storageA: storageA
    storageB: storageB
  }
}

module privateEndpoint './modules/privateEndpoint.bicep' = if (deployPrivateEndpoint) {
  name: 'privateEndpointDeploy'
  params: {
    DataprivateEndpointName: DataprivateEndpointName
    LogsprivateEndpointName: LogsprivateEndpointName
    DataprivateLinkServiceConnName: DataprivateLinkServiceConnName
    LogsprivateLinkServiceConnName: LogsprivateLinkServiceConnName
    virtualNetworkName: virtualNetworkName
    // DatastorageID: stg.outputs.names[0]
    DatastorageID: stg.outputs.storageAccountIds[0].ids
    LogsstorageID: stg.outputs.storageAccountIds[1].ids
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
