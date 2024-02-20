@description('Name of the Log Analytics Workspace.')
param logAnalyticsName string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('How long should data be retained? (in days)')
param retentionInDays int = 90

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
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
