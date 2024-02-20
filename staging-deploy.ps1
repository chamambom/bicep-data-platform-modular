$resourceGroup = 'rg-stage-mdp-01'
az deployment group create -f ./main.bicep  -g $resourceGroup -p .\staging.bicepparam






