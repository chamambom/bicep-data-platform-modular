@description('Name of the Log Analytics Workspace.')
param logAnalyticsName string

@description('Specifies the service tier of the workspace: Free, Standalone, PerNode, Per-GB.')
@allowed([
  'Free'
  'Standalone'
  'PerNode'
  'PerGB2018'
])
param sku string = 'PerGB2018'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Specifies the workspace data retention in days. -1 means Unlimited retention for the Unlimited Sku. 730 days is the maximum allowed for all other Skus.')
param retentionInDays int = 90

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
    features: {
      searchVersion: 1
      legacy: 0
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
