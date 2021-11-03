# ADLS-Inventory
Using blob inventory feature to understand what is on the data lake


## Introduction
Data Lakes are a key part of modern analytics architectures. They are integration points for many systems, with large numbers of pipelines writing to and reading from the lake.
Modern data governance tools (such as Azure Purview) can help you understand the overall lineage and content of your data lake. However, it has been complex and time consuming to understand details of the files and directories on the lake. Ideally we would want to be able to detail the number and size of files and directories in the lake, so that we can monitor that the physical layout of our lake is operating as designed, as well as understanding growth rates for planning and budgeting purposes.
The Azure Storage team have recently release a new feature called Blob Inventory that can be used to create inventories of storage accounts as a managed service. This article will explore the feature and highlight some useful code to help consume the output from the inventory

## Creating an inventory
Inventory Outputs are created at storage account level by creating a rule. These rules run daily and can be set on a daily or weekly schedule. If the rules does not complete within 48 hours of starting, it will be cancelled. On large or complex data lakes, it may be useful to use the subset rules to reduce the size of the particular rule run. You can do this by specifying a container name, or a subset of a container.


