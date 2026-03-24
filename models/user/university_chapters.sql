select
    chapter_id,
    chapter_name,
    city,
    state,
    st_geogpoint(longitude, latitude) as spatial_point,
    ingestion_time,
    current_timestamp() as curated_at
from {{ ref('stg_du_university_chapters') }}