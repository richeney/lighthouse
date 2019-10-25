# Azure Lighthouse demo sample

## Setup

These are configured for the objectIDs and tenantIDs in microsoft.com, so are unsuitable as they stand for partner demos. Download the files, fork the repo etc. so you can customise your descriptions, objectIDs, tenantID etc.

The demo-magic.sh ustomised script used for demoing CLI commands so that you don't mistype. Based off a version used at Ready last year in the AKS demos. Download to your Linux homedir and make executable.  Used by the other scripts.

## Templates

Both templates do the same in that they only create a Lighthouse definition ready for the customer to assign in the Service Providers portal blade.

Three assignments:

1. User Principal as Contributor
1. Security Group as Reader
1. Service Principal as Billing Reader

This is just to illustrate the authorisations as a list and throw in a few variants for built in role and security principals.

If you don't have a service principal then you can create one in the service provider context by loggin in and then running `az ad sp create-for-rbac --name http://billingreader --skip-assignment`. (The last switch skips the standard Contributor at subscription scope RBAC assignment.)

## Demoing

Works great with multiple virtual desktops, so you can visually slide between the service provider world and the customer world.

### Service Provider

As the Service Provider, you can log in under your context, show the Directory + Subscription filter.

Show the objectIDs in Users and in Groups.

For the service principal, go to App Registrations and then descend down to the service principal using the _Managed application in local directory_ link in the top section of the Overview. It is the Object ID for the service principal that you need, not the Application ID.  (The App ID links the service principal up into the App Object.)

Alternatively, run the `guids.sh` script to show the commands to pull out the relevant GUIDs using Azure CLI and JMESPATH queries.

### Customer

Log in as the customer. (I would use a separate profile in Microsoft Edge Chromium to keep things sane, and then use <https://shell.azure.com> and the portal.)

Add the definition. Either copy all of the files into the Cloud Shell (which supports drag and drop) and run the lighthouse.sh command.

Or just run this one to call on the hardcoded.json with no parameter file:

```bash
az deployment create --template-uri https://raw.githubusercontent.com/richeney/lighthouse/master/hardcoded.json
```

> Note that this wil be updated once we can add `--scope-type tenant` to deploy this to the Root Tenant Groupp.

Once deployed then show the Service Providers screen. View the definition, and assign to a subscription, resource group or multiple resource groups.

> You can do this in one hit in the template as per the [samples](https://github.com/Azure/Azure-Lighthouse-samples), but I like the customer experience in the portal.

### Service Provider

A good time to go through some decks until it settles down.

Show the My Customers blade and the delegations.

Open the Directory + Subscriptions filter and show the projections. Then view resource groups, all resources, virtual machines, or whatever resource view you want based on the delegated resources.

Show the IAM for an RG.  Only the authorisations will be visible - the service provider cannot see the customer's IAM. Mention that only build in roles can be used, and not if they have data actions.

Make a change, e.g. shutting down a test VM.

Discuss [PAL](https://aka.ms/partneradminlink) assignments for partner recognition for influenced ACR.

### Customer

View the Activity Log and see th transparency in the audit trail.

View the delegations.  Show how you can add another. Look at the Service Provider offers, and delete the whole delegation for the demo. Customer retains the ability to revoke access.

### Service Provider

Refresh the last view and the delegated resources should now have disappeared. Also gone from the filter.

Discuss roadmap such as Privileged Identity integration (e..g just in time, just enough access)