using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployprivateEndpointSnowflake = false
param deployLogAnalytics = true
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-dev-logs-la'
param location = 'australiaeast'
param containerA = 'data'
param containerB = 'sensitivedata'
param containerC = 'logs'
param containerD = 'testcontainer'
param DataStorage = 'mdpdevdatasa'
param LogsStorage = 'mdpdevlogsa'
param virtualNetworkName = 'mdp-dev-vnetint-vnet'
param DatasubnetName = 'mdp-dev-data-subnet'
param LogsubnetName = 'mdp-dev-log-subnet'
param DataprivateEndpointName = 'mdp-dev-data-sa-pe'
param LogsprivateEndpointName = 'mdp-dev-log-sa-pe'
param DataprivateLinkServiceConnName = 'mdp-dev-data-sa-pe-conn'
param LogsprivateLinkServiceConnName = 'mdp-dev-log-sa-pe-conn'
param snowflakePrivateEndpointName = 'mdp-prd-snowflake-pls'
param snowflakeprivateLinkServiceConnName = 'mdp-prd-snowflake-pls-conn'
param snowflakesubnetName = 'mdp-prd-snowflake-subnet'
param snowflakePrivateLinkServiceId = 'sdfsf.sdfsfdsfsd'
