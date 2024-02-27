using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployprivateEndpointSnowflake = false
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-uat-logs-la'
param location = 'australiaeast'
param containerA = 'data'
param containerB = 'sensitivedata'
param containerC = 'logs'
param DataStorage = 'mdpuatdatasa'
param LogsStorage = 'mdpuatlogsa'
param storageSKU = 'Standard_LRS'
param devVirtualNetworkName = 'mdp-uat-vnetint-vnet'
param prodVirtualNetworkName = 'mdp-prd-vnetint-vnet'
param DatasubnetName = 'mdp-uat-data-subnet'
param LogsubnetName = 'mdp-uat-log-subnet'
param DataprivateEndpointName = 'mdp-uat-data-sa-pe'
param LogsprivateEndpointName = 'mdp-uat-log-sa-pe'
param DataprivateLinkServiceConnName = 'mdp-uat-data-sa-pe-conn'
param LogsprivateLinkServiceConnName = 'mdp-uat-log-sa-pe-conn'
param snowflakePrivateEndpointName = 'mdp-prd-snowflake-pls'
param snowflakeprivateLinkServiceConnName = 'mdp-prd-snowflake-pls-conn'
param snowflakesubnetName = 'mdp-prd-snowflake-subnet'
param snowflakePrivateLinkServiceId = ''
