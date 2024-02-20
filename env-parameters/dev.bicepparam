using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-dev-logs-la'
param location = 'australiaeast'
