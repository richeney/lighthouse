## Create the service principal

WORK IN PROGRESS

```bash
az keyvault create --location uksouth --name keyvaultAzureCitadel --resource-group keyvault --enable-rbac-authorization --retention-days 7
kvid=$(az keyvault show --name keyvaultAzureCitadel --query id --output tsv)
az role assignment create --role "Key Vault Administrator" --scope $kvid --assignee richeney@azurecitadel.com
```



```bash
az ad sp create-for-rbac --name "Billing Reader" --skip-assignment --create-cert --cert billing-reader-cert --keyvault keyvaultAzureCitadel
servicePrincipalObjectId=$(az ad sp list --filter "displayname eq 'Billing Reader'" --query [0].objectId --output tsv)
```
