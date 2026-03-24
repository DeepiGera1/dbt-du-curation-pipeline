--assert that all coordinates are valid
select *
from {{ ref('stg_du_university_chapters') }}
where longitude is not null
  and latitude is not null
  and (
    longitude not between -180 and 180
    or latitude not between -90 and 90
  )