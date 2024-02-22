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
param DataStorage string
param LogsStorage string
param virtualNetworkName string
param DataprivateEndpointName string
param LogsprivateEndpointName string
param DataprivateLinkServiceConnName string
param LogsprivateLinkServiceConnName string
param privateLinkServiceName string

module stg './modules/storage.bicep' = if (deployStorage) {
  name: 'storageDeploy'
  params: {
    containerA: containerA
    containerB: containerB
    containerC: containerC
    containerD: containerD
    location: location
    DataStorage: DataStorage
    LogsStorage: LogsStorage
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
    DatastorageID: stg.outputs.storageAccountIds[0].ids
    LogsstorageID: stg.outputs.storageAccountIds[1].ids
    location: location
  }
}

module privateLinkService './modules/privateLinkService.bicep' = {
  name: 'privateLinkService'
  params: {
    loadBalancerName: loadBalancer.outputs.name
    privateEndpointName: privateLinkServicePrivateEndpointName
    privatelinkServiceName: privateLinkServiceName
    virtualNetworkName: clientVirtualNetwork.outputs.virtualNetworkName
    subnetName: clientVirtualNetwork.outputs.frontendSubnetName
    location: location
    tags: tags
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
