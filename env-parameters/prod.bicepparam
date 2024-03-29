using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployprivateEndpointSnowflake = true
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-prd-logs-la'
param location = 'australiaeast'
param containerA = 'data'
param containerB = 'sensitivedata'
param containerC = 'logs'
param DataStorage = 'mdpprddatasa'
param LogsStorage = 'mdpprdlogsa'
param storageSKU = 'Standard_ZRS'
param devVirtualNetworkName = 'mdp-prd-vnetint-vnet'
param prodVirtualNetworkName = 'mdp-prd-vnetint-vnet'
param DatasubnetName = 'mdp-prd-data-subnet'
param LogsubnetName = 'mdp-prd-log-subnet'
param DataprivateEndpointName = 'mdp-prd-data-sa-pe'
param LogsprivateEndpointName = 'mdp-prd-log-sa-pe'
param DataprivateLinkServiceConnName = 'mdp-prd-data-sa-pe-conn'
param LogsprivateLinkServiceConnName = 'mdp-prd-log-sa-pe-conn'
param snowflakePrivateEndpointName = 'mdp-prd-snowflake-pls'
param snowflakeprivateLinkServiceConnName = 'mdp-prd-snowflake-pls-conn'
param snowflakesubnetName = 'mdp-prd-snowflake-subnet'
param snowflakePrivateLinkServiceId = ''
