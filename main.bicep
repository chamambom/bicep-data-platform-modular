param location string
// param resourceGroup string
param deployStorage bool
param deployPrivateEndpoint bool
param deployLogAnalytics bool
param deployDataFactory bool
param deploySql bool
param deployDatabricks bool
param deployKeyVault bool
param logAnalyticsName string

module stg './modules/storage.bicep' = if (deployStorage) {
  name: 'storageDeploy'
  params: {
    // project: project
    // env: env
    location: location
    // prefix: 'sa'
  }
}

module privateEndpoint './modules/privateEndpoint.bicep' = if (deployPrivateEndpoint) {
  name: 'privateEndpointDeploy'
  params: {

    storageID: stg.outputs.sid
    // project: project
    // env: env
    location: location
    // prefix: 'sa'
  }
}

module adf './modules/datafactory.bicep' = if (deployDataFactory) {
  name: 'factoryDeploy'
  params: {
    project: project
    env: env
    location: location
    prefix: 'df'
  }
}

module sql './modules/sql.bicep' = if (deploySql) {
  name: 'sqlDeploy'
  params: {
    project: project
    env: env
    location: location
    dbprefix: 'sqldb'
    serverprefix: 'sqlsrv'
  }
}

module dbr './modules/databricks.bicep' = if (deployDatabricks) {
  name: 'databricksDeploy'
  params: {
    project: project
    env: env
    location: location
    prefix: 'dbr'

  }
}

module keyvault './modules/keyvault.bicep' = if (deployKeyVault) {
  name: 'keyvaultDeploy'
  params: {
    project: project
    env: env
    location: location
    prefix: 'kv'

  }
}

module logAnalytics './modules/loganalytics-main.bicep' = if (deployLogAnalytics) {
  name: 'LogAnalyticsDeploy'
  params: {
    location: location
    logAnalyticsName: logAnalyticsName
    retentionInDays: 90
  }
}
