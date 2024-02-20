param location string

var name = 'dtfactory'

resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}
