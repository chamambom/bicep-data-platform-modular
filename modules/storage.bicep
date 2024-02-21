param location string
param containerA string
param containerB string
param storageA string
param storageB string
param containerNames array = [
  containerA
  containerB
]
param storageNames array = [
  storageA
  storageB
]

//Create storages
resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' = [for name in storageNames: {
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

//create blob service

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = [for i in range(0, length(storageNames)): {
  name: 'default'
  parent: storageAccounts[i]
}]

//create container

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for i in range(0, length(storageNames)): {
  name: '${containerNames}'
  parent: blobServices[i]
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}]

// resource blobContainers 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
//   parent: storageAccountName_resource
//   name: 'default'
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
// }

// resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in containerNames: {
//   name: '${storageAccountName_resource.name}/default/${name}'
// }]

// output sid string = storageAccountName_resource.id

//storage accounts IDs.
output names array = [for i in range(0, length(storageNames)): {
  name: storageAccounts[i].name
}]
