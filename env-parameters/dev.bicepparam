using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-dev-logs-la'
param location = 'australiaeast'
param containerA = 'data'
param containerB = 'sensitivedata'
param storageA = 'mdpdevdatasa'
param storageB = 'mdpdevdatasa'
param virtualNetworkName = 'mdp-dev-vnetint-vnet'
param privateEndpointName = 'mdp-dev-data-sa-pe'
param privateLinkServiceConnName = 'mdp-dev-data-sa-pe-conn'
