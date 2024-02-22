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

@description('How long should data be retained? (in days)')
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
