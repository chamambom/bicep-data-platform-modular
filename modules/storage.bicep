param storageAccountNameDataLake string
param storageAccountNameLogging string
param storageAccountNames array = [
  storageAccountNameDataLake
  storageAccountNameLogging
]
param location string
param containerA string
param containerB string
param containerNames array = [
  containerA
  containerB
]

resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2023-01-01' = [for name in storageAccountNames: {
  name: '${name}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}]

// resource storageAccountName_default 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = [for name in storageAccountNames: {
//   name: 'default'
//   parent: storageAccountName_resource
//   properties: {
//     changeFeed: {
//       enabled: false
//     }
//     restorePolicy: {
//       enabled: false
//     }
//     containerDeleteRetentionPolicy: {
//       enabled: true
//       days: 7
//     }
//     cors: {
//       corsRules: []
//     }
//     deleteRetentionPolicy: {
//       allowPermanentDelete: false
//       enabled: true
//       days: 7
//     }
//     isVersioningEnabled: false
//   }
// }]

// resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in containerNames: {
//   name: '${storageAccountName_resource.name}/default/${name}'
// }]

// output sid string = storageAccountName_resource.id
