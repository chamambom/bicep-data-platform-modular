using '../main.bicep'

param deployStorage = true
param deployPrivateEndpoint = true
param deployLogAnalytics = true
param deployprivateEndpointSnowflake = false
param deployDataFactory = false
param deployKeyVault = false
param logAnalyticsName = 'mdp-stage-logs-la'
param location = 'australiaeast'
param containerA = 'data'
param containerB = 'sensitivedata'
param containerC = 'logs'
param containerD = 'testcontainer'
param DataStorage = 'mdpstagedatasa'
param LogsStorage = 'mdpstagelogsa'
param devVirtualNetworkName = 'mdp-stage-vnetint-vnet'
param prodVirtualNetworkName = 'mdp-prd-vnetint-vnet'
param DatasubnetName = 'mdp-stage-data-subnet'
param LogsubnetName = 'mdp-stage-log-subnet'
param DataprivateEndpointName = 'mdp-stage-data-sa-pe'
param LogsprivateEndpointName = 'mdp-stage-log-sa-pe'
param DataprivateLinkServiceConnName = 'mdp-stage-data-sa-pe-conn'
param LogsprivateLinkServiceConnName = 'mdp-stage-log-sa-pe-conn'
param snowflakePrivateEndpointName = 'mdp-prd-snowflake-pls'
param snowflakeprivateLinkServiceConnName = 'mdp-prd-snowflake-pls-conn'
param snowflakesubnetName = 'mdp-prd-snowflake-subnet'
param snowflakePrivateLinkServiceId = ''
