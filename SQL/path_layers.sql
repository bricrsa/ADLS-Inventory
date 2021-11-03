--find path delimiters
select top 100
    [Name]
    , left([Name], CHARINDEX('/', [Name], 1) - 1) AS Container
    , left([Name],len([Name]) - charindex('/',reverse([Name]),1) + 1) [dir_path]
    , len(left([Name],len([Name]) - charindex('/',reverse([Name]),1) + 1)) dir_len
    , CHARINDEX('/', [Name],1) first_one
    , case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end second_one
    , case when (case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end = 0) then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1) end third_one
    , case when (case when (case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end = 0) then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1) end) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1)+1) end fourth_one
    , case when (case when (case when (case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end = 0) then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1) end) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1)+1) end) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1)+1)+1) end fifth_one
FROM  
    OPENROWSET(
        BULK '/*/*/*/*/*/*.parquet',
        DATA_SOURCE = 'blob_inventory',
        FORMAT='PARQUET'
    )  d

--different layers of path
--ludicrous sql level 100
--case statement to stop charindex looping back around 
--open to suggestions on alternatives!!!
select top 100
    [Name]
    , left([Name], CHARINDEX('/', [Name], 1) - 1) AS Container
    , left([Name],len([Name]) - charindex('/',reverse([Name]),1) + 1) [full_dir_path]
    , SUBSTRING([Name], 1, case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end) layer_1_path
    , SUBSTRING([Name], 1, case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end) layer_2_path
    , SUBSTRING([Name], 1, case when (case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end = 0) then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1) end) layer_3_path
    , SUBSTRING([Name], 1, case when (case when (case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end = 0) then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1) end) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1)+1) end) layer_4_path
    , SUBSTRING([Name], 1, case when (case when (case when (case when CHARINDEX('/', [Name],1) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1) end = 0) then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1) end) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1)+1) end) = 0 then 0 else CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],CHARINDEX('/', [Name],1)+1)+1)+1)+1) end) layer_5_path

FROM  
    OPENROWSET(
        BULK '/*/*/*/*/*/*.parquet',
        DATA_SOURCE = 'blob_inventory',
        FORMAT='PARQUET'
    )  d

