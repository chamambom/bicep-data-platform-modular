// param storageAccountName string = 'mdpdevdatasa'
param location string
param virtualNetworkName string
param privateEndpointName string
param privateLinkServiceConnName string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: virtualNetworkName
}

param storageID string

resource sablobpe 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: virtualNetwork.properties.subnets[0].id
    }
    privateLinkServiceConnections: [
      {
        name: privateLinkServiceConnName
        properties: {
          // privateLinkServiceId: storageAccountName_resource.id
          privateLinkServiceId: storageID
          groupIds: [
            'blob'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
  }
}

// resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: storageAccountName
//   location: location
//   tags: {
//     'Created By': 'Datacom Professional Services'
//     'Used For ': 'MDP Project'
//   }
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     dnsEndpointType: 'Standard'
//     defaultToOAuthAuthentication: false
//     publicNetworkAccess: 'Disabled'
//     allowCrossTenantReplication: false
//     minimumTlsVersion: 'TLS1_2'
//     allowBlobPublicAccess: false
//     allowSharedKeyAccess: true
//     networkAcls: {
//       bypass: 'AzureServices'
//       virtualNetworkRules: []
//       ipRules: []
//       defaultAction: 'Deny'
//     }
//     supportsHttpsTrafficOnly: true
//     encryption: {
//       requireInfrastructureEncryption: false
//       services: {
//         file: {
//           keyType: 'Account'
//           enabled: true
//         }
//         blob: {
//           keyType: 'Account'
//           enabled: true
//         }
//       }
//       keySource: 'Microsoft.Storage'
//     }
//     accessTier: 'Hot'
//   }
// }

// resource blobPrivDNS 'Microsoft.Network/privateDnsZones@2020-06-01' = {
//   name: 'privatelink.blob.${storagesuffix}'
//   location: 'global'
// }

// resource tablePrivDNS 'Microsoft.Network/privateDnsZones@2020-06-01' = {
//   name: 'privatelink.table.${storagesuffix}'
//   location: 'global'
// }

// resource queuePrivDNS 'Microsoft.Network/privateDnsZones@2020-06-01' = {
//   name: 'privatelink.queue.${storagesuffix}'
//   location: 'global'
// }

// resource filePrivDNS 'Microsoft.Network/privateDnsZones@2020-06-01' = {
//   name: 'privatelink.file.${storagesuffix}'
//   location: 'global'
// }

// resource storageAccountName_default 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
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

// resource privateEndpoints_DNS_blob 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
//   name: 'default'
//   parent: sablobpe
//   properties: {
//     privateDnsZoneConfigs: [
//       {
//         name: blobPrivDNS.name
//         properties: {
//           privateDnsZoneId: blobPrivDNS.id
//         }
//       }
//     ]
//   }
//   dependsOn: []
// }

// resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
//   name: spoke01Name
//   location: location
//   properties: {
//     addressSpace: {
//       addressPrefixes: [
//         '${spoke01IpPrefix}0.0/23'
//       ]
//     }
//     subnets: [
//       {
//         name: '${subnetNamePrefix}01'
//         properties: {
//           addressPrefix: '${spoke01IpPrefix}0.0/24'
//         }
//       }
//     ]
//   }
// }

// resource Microsoft_Storage_storageAccounts_fileServices_storageAccountName_default 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
//   parent: storageAccountName_resource
//   name: 'default'
//   properties: {
//     protocolSettings: {
//       smb: {}
//     }
//     cors: {
//       corsRules: []
//     }
//     shareDeleteRetentionPolicy: {
//       enabled: true
//       days: 7
//     }
//   }
// }

// resource saqueuepe 'Microsoft.Network/privateEndpoints@2023-05-01' = {
//   name: '${storageAccountName}-queuepe'
//   location: location
//   properties:{
//     subnet: {
//       id: virtualNetwork.properties.subnets[0].id
//     }
//     privateLinkServiceConnections: [
//     {
//       name: '${storageAccountName}-queuepe-conn'
//       properties: {
//         privateLinkServiceId: storageAccountName_resource.id
//         groupIds:[
//           'queue'
//         ]
//         privateLinkServiceConnectionState: {
//           status: 'Approved'
//           actionsRequired: 'None'
//         }
//       }
//     }
//     ]
//   }
// }

// resource privateEndpoints_DNS_queue 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
//   name: 'default'
//   parent: saqueuepe
//   properties: {
//     privateDnsZoneConfigs: [
//       {
//         name: queuePrivDNS.name
//         properties: {
//           privateDnsZoneId:  queuePrivDNS.id
//         }
//       }
//     ]
//   }
//   dependsOn: [
//   ]
// }

// resource satablepe 'Microsoft.Network/privateEndpoints@2023-05-01' = {
//   name: '${storageAccountName}-tablepe'
//   location: location
//   properties:{
//     subnet: {
//       id: virtualNetwork.properties.subnets[0].id
//     }
//     privateLinkServiceConnections: [
//     {
//       name: '${storageAccountName}-tablepe-conn'
//       properties: {
//         privateLinkServiceId: storageAccountName_resource.id
//         groupIds:[
//           'table'
//         ]
//         privateLinkServiceConnectionState: {
//           status: 'Approved'
//           actionsRequired: 'None'
//         }
//       }
//     }
//     ]
//   }
// }

// resource privateEndpoints_DNS_table 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
//   name: 'default'
//   parent: satablepe
//   properties: {
//     privateDnsZoneConfigs: [
//       {
//         name: tablePrivDNS.name
//         properties: {
//           privateDnsZoneId:  tablePrivDNS.id
//         }
//       }
//     ]
//   }
//   dependsOn: [
//   ]
// }

// resource safilepe 'Microsoft.Network/privateEndpoints@2023-05-01' = {
//   name: '${storageAccountName}-filepe'
//   location: location
//   properties:{
//     subnet: {
//       id: virtualNetwork.properties.subnets[0].id
//     }
//     privateLinkServiceConnections: [
//     {
//       name: '${storageAccountName}-filepe-conn'
//       properties: {
//         privateLinkServiceId: storageAccountName_resource.id
//         groupIds:[
//           'file'
//         ]
//         privateLinkServiceConnectionState: {
//           status: 'Approved'
//           actionsRequired: 'None'
//         }
//       }
//     }
//     ]
//   }
// }

// resource privateEndpoints_DNS_file 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
//   name: 'default'
//   parent: safilepe
//   properties: {
//     privateDnsZoneConfigs: [
//       {
//         name:  filePrivDNS.name
//         properties: {
//           privateDnsZoneId: filePrivDNS.id
//         }
//       }
//     ]
//   }
//   dependsOn: [
//   ]
// }

// resource storageQueue 'Microsoft.Storage/storageAccounts/queueServices@2023-01-01' = {
//   parent: storageAccountName_resource
//   name: 'default'
//   properties: {
//     cors: {
//       corsRules: []
//     }
//   }
// }

// resource storageTable 'Microsoft.Storage/storageAccounts/tableServices@2023-01-01' = {
//   parent: storageAccountName_resource
//   name: 'default'
//   properties: {
//     cors: {
//       corsRules: []
//     }
//   }
// }

// resource storageBlobWebJobsHosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
//   parent: storageAccountName_default
//   name: 'azure-webjobs-hosts'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
//   dependsOn: []
// }

// resource storageBlobWebJobsSecrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
//   parent: storageAccountName_default
//   name: 'azure-webjobs-secrets'
//   properties: {
//     immutableStorageWithVersioning: {
//       enabled: false
//     }
//     defaultEncryptionScope: '$account-encryption-key'
//     denyEncryptionScopeOverride: false
//     publicAccess: 'None'
//   }
//   dependsOn: []
// }
