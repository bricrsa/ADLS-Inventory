# ADLS-Inventory
Using blob inventory feature to understand what is on the data lake

## Introduction
Data Lakes are a key part of modern analytics architectures. They are integration points for many systems, with large numbers of pipelines writing to and reading from the lake.
Modern data governance tools (such as Azure Purview) can help you understand the overall lineage and content of your data lake. However, it has been complex and time consuming to understand details of the files and directories on the lake. Ideally we would want to be able to detail the number and size of files and directories in the lake, so that we can monitor that the physical layout of our lake is operating as designed, as well as understanding growth rates for planning and budgeting purposes.
The Azure Storage team have recently release a new feature called Blob Inventory that can be used to create inventories of storage accounts as a managed service. This article will explore the feature and highlight some useful code to help consume the output from the inventory

## Creating an inventory
Inventory Outputs are created at storage account level by creating a rule. These rules run daily and can be set on a daily or weekly schedule. If the rules does not complete within 48 hours of starting, it will be cancelled. On large or complex data lakes, it may be useful to use the subset rules to reduce the size of the particular rule run. You can do this by specifying a container name, or a subset of a container.


# Understanding storage locations in use by legacy Azure Databricks notebooks

## Introduction

In scenarios where Azure Databricks legacy (using passthrough auth) notebooks are accessing ADLS Gen 2 locations, it can be complex to understand which users are accessing which locations. This can complicate migration to Unity Catalog.  

In order to understand the usage pattern, ADLS Gen 2 diagnostics settings can be used to understand the link between users and related data.

Two primary options exist to capture and store this data for this scenario.
- Send the data to a Log Analytics workspace,
- Send the data to a storage account.

In this repo, data is sent to Log Analytics and an example KQL query is highlighted.  

Example [KQL Query](/kql/audit_databricks_passthru_access.kql), highlighting Databricks Runtime, user and location.  

Turn on diagnostic setting:  
In the storage account, with HNS enabled  
![Top level](/images/adls-diag-settings-top.png)  
![next level](/images/adls-diag-settings-next.png)  
Minimum required for access logging  
![detail level](/images/adls-diag-settings-detail.png)  
Don't forget to hit save. Be mindful of Log Analytics costs, as on larger storage accounts this data can add up fast.