param location string
// param resourceGroup string
param deployStorage bool
param deployPrivateEndpoint bool
param deployprivateEndpointSnowflake bool
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
param DatasubnetName string
param LogsubnetName string
param DataprivateEndpointName string
param LogsprivateEndpointName string
param DataprivateLinkServiceConnName string
param LogsprivateLinkServiceConnName string
param privateEndpointSnowflakeName string




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
    workspaceId: logAnalytics.outputs.logAnalyticsWorkspaceId
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
    DatasubnetName: DatasubnetName
    LogsubnetName: LogsubnetName
    DatastorageID: stg.outputs.storageAccountIds[0].ids
    LogsstorageID: stg.outputs.storageAccountIds[1].ids
    location: location
  }
}

module privateLinkService './modules/privateEndpointSnowflake.bicep' = if (deployprivateEndpointSnowflake) {
  name: 'privateLinkService'
  params: {
    snowflakePrivateEndpointName: snowflakeprivateEndpointName  
    snowflakeprivateLinkServiceConnName: snowflakeprivateLinkServiceConnName
    virtualNetworkName: virtualNetworkName
    DatasubnetName: DatasubnetName
    ResourceID: stg.outputs.storageAccountIds[0].ids
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
