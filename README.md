# Azure Lighthouse demo sample

## Overview

This repo contains some useful artefacts for spinning up your own demo environment for Azure Lighthouse.

## Pre-reqs

You will need two Azure subscriptions in two separate tenants, to act as your Managed Services Provider and your Azure Lighthouse Customer.

In the example commands I use:

* _Azure Citadel_ as the MSP
* _Lighthouse Customer_

Both are Visual Studio subscriptions.

## Lighthouse Customer preparation

1. Clone the repo

    In Cloud Shell (or similar).

    ```shell
    git clone https://github.com/richeney/lighthouse
    ```

1. Create example resource groups and resources

    ```shell
    cd lighthouse/demo_environment
    ```

    ```shell
    terraform init
    ```

    ```shell
    terraform apply --auto-approve
    ```

    This will create a few resource groups and a few resources. Note that you can always remove the environment later by using `terraform destroy` in the same directory.

1. Move back up to the main report directory

    ```shell
    cd ..
    ```

1. Customise the Azure Lighthouse definition template
    * Edit `lighthouse_definition.json`
    * Change the managedByTenantId to the MSP's tenantId
    * Configure the objectIds and cosmetic descriptions in the authorizations array

    > If you have the licences for Privileged Identity Management in your MSP tenancy then you can use the lighthouse_definition_with_pim.json definition instead.

    Note the limitations on built in RBAC roles and only those that work purely on the control plane. The objectIds can be for user principals, security groups or service principals.

    Also note the role to allow the MSP to delete delegations from their side.

    PIM durations can be set as well as auto-approved and approve by roles as per the example.

1. Create the Azure Lighthouse definition

    ```shell
    az deployment sub create --name lighthouse --template-file lighthouse_definition.json --location westeurope
    ```

    Note that wil ARM / Bicep / Terraform etc. you can create the definition and create the assignments, but this template only creates the definition in order to demonstrate the customer experience in the portal.

    Note also that marketplace published services are an option as opposed to creating a Lighthouse definition via infrastructure as code.

## Lighthouse Customer

1. Open the Azure portal
1. Search on Service Providers
1. Navigate to Service Provider Offers
1. Explore the definition
1. Delegate the subscription or a number of resource groups

The delegation will take 20-30 mins. You may need to log in and out of the portals to reflect changes.

Areas to note:

* The IAM is no longer polluted by guest or member users for the partners
* The Activity Log shows MSP activity through Lighthouse
* The customer is able to revoke access at any point
* Using Lighthouse does not limit any  use of the historical access types and they may be used in combination.

## Managed Service Provider

* Show tenancy and directory filter
* Discuss cross-tenant reporting, monitoring, policy and automation benefits
* Talk about onboarding experiences for customers, including EA v CSP v PAYG

## Resources

* [Lighthouse Registration Definition Schema](https://docs.microsoft.com/rest/api/managedservices/registration-definitions)
* [Sample template file](https://github.com/Azure/Azure-Lighthouse-samples/blob/master/templates/delegated-resource-management-eligible-authorizations/subscription/subscription-managing-tenant-approvers.json)
* [Sample parameters file](https://github.com/Azure/Azure-Lighthouse-samples/blob/master/templates/delegated-resource-management-eligible-authorizations/subscription/subscription-managing-tenant-approvers.parameters.json)
