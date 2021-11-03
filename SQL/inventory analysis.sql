select
    RunDate
    , left([Name],len([Name]) - charindex('/',reverse([Name]),1) + 1) [dir_path]
    , sum([Content-Length]) TotalSize
    , COUNT_BIG(Name) BlobCount
from 
    inventory.inventory_data_parquet
where 
    [Content-Length] != 0
group by 
    RunDate
    ,left([Name],len([Name]) - charindex('/',reverse([Name]),1) + 1)