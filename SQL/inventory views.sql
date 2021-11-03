--CSV files
create view inventory.inventory_data_csv
as
select
    *
    , d.filepath(5) as RuleName
    , cast(concat(d.filepath(1),'-',d.filepath(2),'-', d.filepath(3)) as date)as RunDate
    , cast(concat(d.filepath(1),'-',d.filepath(2),'-', d.filepath(3),' ', replace(d.filepath(4),'-',':')) as datetime)as RunDateTime
FROM  
    OPENROWSET(
        BULK '/*/*/*/*/*/*.csv',
        DATA_SOURCE = 'blob_inventory',
        FORMAT = 'csv' ,
        parser_version='2.0',
        header_row=true
    )  
with
(
    [Name]	varchar(500),
    [Creation-Time]	varchar(50),
    [Last-Modified]	varchar(50),
    [Content-Length] bigint,
    [AccessTier] varchar(50),
    [Owner] varchar(200),
    [Group] varchar(200),
    [Permissions] varchar(200),
    [Acl] varchar(200),
    [Metadata] varchar(200),
    [LastAccessTime] varchar(50)
)  as d


--parquet files
create view inventory.inventory_data_parquet
as
select
    *
    , d.filepath(5) as RuleName
    , cast(concat(d.filepath(1),'-',d.filepath(2),'-', d.filepath(3)) as date)as RunDate
    , cast(concat(d.filepath(1),'-',d.filepath(2),'-', d.filepath(3),' ', replace(d.filepath(4),'-',':')) as datetime)as RunDateTime
FROM  
    OPENROWSET(
        BULK '/*/*/*/*/*/*.parquet',
        DATA_SOURCE = 'blob_inventory',
        FORMAT='PARQUET'
    )  d

--directory and container 
create view inventory.inventory_data_dirs
as
select
    *
    ,left([Name], CHARINDEX('/', [Name], 1) - 1) AS Container
    , left([Name],len([Name]) - charindex('/',reverse([Name]),1) + 1) [dir_path]
    , d.filepath(5) as RuleName
    , cast(concat(d.filepath(1),'-',d.filepath(2),'-', d.filepath(3)) as date)as RunDate
    , cast(concat(d.filepath(1),'-',d.filepath(2),'-', d.filepath(3),' ', replace(d.filepath(4),'-',':')) as datetime)as RunDateTime
FROM  
    OPENROWSET(
        BULK '/*/*/*/*/*/*.parquet',
        DATA_SOURCE = 'blob_inventory',
        FORMAT='PARQUET'
    )  d
