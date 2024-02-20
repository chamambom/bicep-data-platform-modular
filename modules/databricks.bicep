var sub = subscription().subscriptionId
param prefix string
param location string

var name = 'dtbricks'
var mrg = 'rg-bricks'
var managedResourceGroupId = '/subscriptions/${sub}/resourceGroups/${mrg}'

resource databricks 'Microsoft.Databricks/workspaces@2018-04-01' = {
   name: name
   location: location
   properties: {
      managedResourceGroupId: managedResourceGroupId
   }
}
