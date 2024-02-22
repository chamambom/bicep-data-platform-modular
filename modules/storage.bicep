param location string
param containerA string
param containerB string
param containerC string
param containerD string
param DataStorage string
param LogStorage string

param storageNames array = [
  DataStorage
  LogStorage
]
param DataStorageContainers array = [
  containerA
  containerB
]

param LogStorageContainers array = [
  containerC
  containerD
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
    isHnsEnabled:true
  }
}]

//create blob service - Containers live inside of a blob service

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = [for i in range(0, length(storageNames)): {
  name: 'default'
  parent: storageAccounts[i]

  properties: {
        changeFeed: {
          enabled: false
        }
        restorePolicy: {
          enabled: false
        }
        containerDeleteRetentionPolicy: {
          enabled: true
          days: 7
        }
        cors: {
          corsRules: []
        }
        deleteRetentionPolicy: {
          allowPermanentDelete: false
          enabled: true
          days: 7
        }
        isVersioningEnabled: false
      }
}]

//create containers



// resource storageAcontainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for i in range(0, length(storageNames)): {
//   name: '${storageAcontainerNames[i]}'
//   parent: blobServices[i]
//   properties: {
//     publicAccess: 'Container'
//     metadata: {}
//   }
// }]

// resource storageBcontainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for i in range(0, length(storageNames)): {
//   name: '${storageBcontainerNames[i]}'
//   parent: blobServices[i]
//   properties: {
//     publicAccess: 'Container'
//     metadata: {}
//   }
// }]

resource storageAcontainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in DataStorageContainers: {
  name: '${storageAccounts[0].name}/default/${name}'
  dependsOn: [
    storageAccounts
    blobServices
  ]

}]


resource storageBcontainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in LogStorageContainers: {
  name: '${storageAccounts[1].name}/default/${name}'
  dependsOn: [
    storageAccounts
    blobServices
  ]
}]




//If its one Storage Account - output sid string = storageAccounts.id 

//If its 1 or more storage accounts IDs in an array
output storageAccountIds array = [for i in range(0, length(storageNames)): {
  ids: storageAccounts[i].id
}]
