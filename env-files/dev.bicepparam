using '../main.bicep'

param project = 'fenz'
param env = 'dev'
param location = 'australiaeast'
param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployDataFactory = false
param deploySql = false
param deployDatabricks = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-dev-logs-la'
