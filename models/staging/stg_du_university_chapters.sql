select
    safe_cast(OBJECT_ID as int64) as object_id,
    trim(Chapter_ID) as chapter_id,
    trim(Chapter_name) as chapter_name,
    trim(City) as city,
    trim(State) as state,
    safe_cast(longitude as float64) as longitude,
    safe_cast(latitude as float64) as latitude,
    ingestion_time
from {{ source('du_operational', 'du_university_chapters') }}