$resourceGroup = 'rg-dev-mdp-01'


az deployment group create -f ./main.bicep  -g $resourceGroup -p .\dev.bicepparam


# az deployment sub create -n 'deployRG' -l uksouth -f .\main.bicep -p .\prod.bicepparam 





