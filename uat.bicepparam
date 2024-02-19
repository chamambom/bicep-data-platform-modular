using './main.bicep'

param project = ''
param env = ''
param location = ''
param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployDataFactory = false
param deploySql = false
param deployDatabricks = false
param deployKeyVault = false

