$resourceGroup = 'rg-uat-mdp-01'
az deployment group create -f ./main.bicep  -g $resourceGroup -p .\uat.bicepparam





