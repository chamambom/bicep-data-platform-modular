@description('Specifies the name of the Azure Private Endpoint.')
param snowflakePrivateEndpointName string
@description('Specifies the name of the Azure Private Endpoint.')
param snowflakeprivateLinkServiceConnName string

param snoflakePrivateLinkServiceId string

@description('Specifies the name of the client virtual network.')
param virtualNetworkName string

@description('Specifies the name of the subnet used by the load balancer.')
param snowflakesubnetName string

@description('Specifies the location.')
param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name: virtualNetworkName
}

resource snowflakesubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  name: snowflakesubnetName
  parent: vnet
}


resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: snowflakePrivateEndpointName
  location: location
  properties: {
    subnet: {
      id: snowflakesubnet.id
    }
    privateLinkServiceConnections: [
      {
        name: snowflakeprivateLinkServiceConnName
        properties: {
          // privateLinkServiceId: storageAccountName_resource.id
          privateLinkServiceId:  snoflakePrivateLinkServiceId     
          privateLinkServiceConnectionState: {
            status: 'Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
  }
  dependsOn: [
    snowflakesubnet
  ]
}

