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
param DataStorage string
param LogsStorage string
param devVirtualNetworkName string
param prodVirtualNetworkName string
param DatasubnetName string
param snowflakesubnetName string
param LogsubnetName string
param DataprivateEndpointName string
param LogsprivateEndpointName string
param DataprivateLinkServiceConnName string
param LogsprivateLinkServiceConnName string
param snowflakePrivateEndpointName string
param snowflakeprivateLinkServiceConnName string
param snowflakePrivateLinkServiceId string
param storageSKU string


module stg './modules/storage.bicep' = if (deployStorage) {
  name: 'storageDeploy'
  params: {
    containerA: containerA
    containerB: containerB
    containerC: containerC
    location: location
    storageSKU:storageSKU
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
    devVirtualNetworkName: devVirtualNetworkName
    DatasubnetName: DatasubnetName
    LogsubnetName: LogsubnetName
    DatastorageID: stg.outputs.storageAccountIds[0].ids
    LogsstorageID: stg.outputs.storageAccountIds[1].ids
    location: location
  }
}

module snowFlakeprivateEndpoint './modules/privateEndpointSnowflake.bicep' = if (deployprivateEndpointSnowflake) {
  name: 'snowlakePrivateEndpointDeploy'
  params: {
    snowflakePrivateEndpointName: snowflakePrivateEndpointName  
    snowflakeprivateLinkServiceConnName: snowflakeprivateLinkServiceConnName
    prodVirtualNetworkName: prodVirtualNetworkName
    snowflakesubnetName: snowflakesubnetName
    location: location
    snowflakePrivateLinkServiceId: snowflakePrivateLinkServiceId
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
