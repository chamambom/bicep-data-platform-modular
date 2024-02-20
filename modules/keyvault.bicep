param location string

var name = 'kvfenz'

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: name
  location: location

  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enabledForTemplateDeployment: true
    enableRbacAuthorization: true
  }
}
