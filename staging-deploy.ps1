$resourceGroup = 'rg-dev-mdp-01'
az deployment group create -f ./main.bicep  -g $resourceGroup -p .\dev.bicepparam






