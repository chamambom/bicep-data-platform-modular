param location string
param containerA string
param containerB string
param containerC string
param DataStorage string
param LogsStorage string
param storageSKU string

param storageNames array = [
  DataStorage
  LogsStorage
]
param DataStorageContainers array = [
  containerA
  containerB
]

param LogsStorageContainers array = [
  containerC
]


//Create storages
resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' = [for name in storageNames: {
  name: '${name}'
  location: location
  sku: {
    name: storageSKU  
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
    isHnsEnabled: name == storageNames[0] ? true : false
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

//Create Containers

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


resource storageBcontainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in LogsStorageContainers: {
  name: '${storageAccounts[1].name}/default/${name}'
  dependsOn: [
    storageAccounts
    blobServices
  ]
}]


param workspaceId string
// param storageInfo object

resource storageAccountsBlobDiagnostics 'microsoft.insights/diagnosticSettings@2021-05-01-preview' = [for i in range(0, length(storageNames)):{
  name: 'service'
  scope: blobServices[i]
  properties: {
    workspaceId: workspaceId
    metrics: [
      {
        category: 'Transaction'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    logs: [
      {
        categoryGroup: 'allLogs'
        enabled: true
      }    
    ]
  }
}]




//If its one Storage Account - output sid string = storageAccounts.id 

//If its 1 or more storage accounts IDs in an array
output storageAccountIds array = [for i in range(0, length(storageNames)): {
  ids: storageAccounts[i].id
}]
