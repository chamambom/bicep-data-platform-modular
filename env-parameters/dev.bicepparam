using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = false
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-dev-logs-la'
param location = 'australiaeast'
param containerA = 'data'
param containerB = 'sensitivedata'
param containerC = 'wewew'
param containerD = 'wewewewewewewwew'
param storageA = 'mdpdevdatasa'
param storageB = 'mdpdevlogsa'
param virtualNetworkName = 'mdp-dev-vnetint-vnet'
param DataprivateEndpointName = 'mdp-dev-data-sa-pe'
param LogsprivateEndpointName = 'mdp-dev-log-sa-pe'
param DataprivateLinkServiceConnName = 'mdp-dev-data-sa-pe-conn'
param LogsprivateLinkServiceConnName = 'mdp-dev-log-sa-pe-conn'
