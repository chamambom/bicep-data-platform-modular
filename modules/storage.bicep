param location string
param containerA string
param containerB string
param containerC string
param containerD string
param storageA string
param storageB string

param storageAcontainerNames array = [
  containerA
  containerB
]

param storageBcontainerNames array = [
  containerC
  containerD
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
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
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

//create containers

resource storageAcontainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for i in range(0, length(storageNames)): {
  name: '${storageAcontainerNames[i]}'
  parent: blobServices[i]
  properties: {
    publicAccess: 'Container'
    metadata: {}
  }
}]

resource storageBcontainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for i in range(0, length(storageNames)): {
  name: '${storageBcontainerNames[i]}'
  parent: blobServices[i]
  properties: {
    publicAccess: 'Container'
    metadata: {}
  }
}]

// output sid string = storageAccountName_resource.id

//storage accounts IDs.
output names array = [for i in range(0, length(storageNames)): {
  name: storageAccounts[i].id
}]
