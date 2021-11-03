CREATE DATABASE LakeInventory
      COLLATE Latin1_General_100_BIN2_UTF8;

CREATE SCHEMA inventory;

CREATE EXTERNAL DATA SOURCE blob_inventory WITH (
    LOCATION = 'https://asadatalakebric04.dfs.core.windows.net/inventory/'
);