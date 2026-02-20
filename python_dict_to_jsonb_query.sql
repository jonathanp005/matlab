-- Adaptation helpers for queries where `data` is saved as a Python dict string
-- (single quotes + None/True/False) instead of native jsonb.
--
-- Usage:
--   1) Create the helper function once.
--   2) Replace all `(data -> ...)` paths with `(d.data_json -> ...)`.

CREATE OR REPLACE FUNCTION public.python_dict_text_to_jsonb(py_text text)
RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
RETURNS NULL ON NULL INPUT
AS $$
DECLARE
    normalized text;
BEGIN
    -- Convert Python-literal dict text into valid JSON text.
    normalized := replace(py_text, '''', '"');
    normalized := regexp_replace(normalized, '\mNone\M', 'null', 'g');
    normalized := regexp_replace(normalized, '\mTrue\M', 'true', 'g');
    normalized := regexp_replace(normalized, '\mFalse\M', 'false', 'g');

    RETURN normalized::jsonb;
EXCEPTION
    WHEN others THEN
        -- Return NULL for malformed payloads instead of failing the whole query.
        RETURN NULL;
END;
$$;

-- Example rewrite of the stations_tallyevent part of your query:
SELECT
    id AS event_id,
    TO_CHAR(created AT TIME ZONE (SELECT data#>>'{timezone}' FROM stations_setting), 'YYYY-MM-DD HH24:MI') AS event_date,
    CASE
        WHEN station_id IN ('92732e80-2f70-4d9f-843c-b6133933edbd', '87878a3b-1372-436a-bb5a-798e9aa3e6a6') THEN 'Wellington'
        WHEN station_id IN ('10c83a81-8f2c-4320-9b56-107a1f3b358b', '4fc3b2b7-cc29-4e3f-b22e-c5ddb3a6001d') THEN 'Auckland'
        WHEN station_id IN ('41cfcc7e-de00-459a-ae77-ff92cbb69ea4', 'f5ea07f8-b23b-4db1-b681-699cf563bbb3') THEN 'Napier'
        WHEN station_id IN ('7deffede-90ad-4fca-8129-75b29f553f8e', '204a5f54-b3d6-4e83-b4ea-5ba52f75ae14') THEN 'Owenga'
        WHEN station_id IN ('e57b1b39-fa93-4d12-8103-d7cd26b9e951', 'f408740f-5758-4755-acdf-4b82324179f4') THEN 'Waitangi'
        WHEN station_id IN ('8565266c-05fb-4e8c-a2dc-090ee48128f9', '41d7c229-b01b-4d06-bf25-328157a9d68d') THEN 'Totara North'
        WHEN station_id IN ('732d4948-a9be-459d-836e-b2278a18005a', '774c346f-86c3-4e14-a26a-7cd5460897c2') THEN 'Tauranga'
        WHEN station_id IN ('8560807b-47a4-4775-be62-87d0eb84012a', '87939ddd-e921-47bc-9367-3f8d24edb470') THEN 'Gisborne'
        ELSE NULL
    END AS updated_at,
    COALESCE(tally_id, tally_pk) AS tally_id,
    to_char(created AT TIME ZONE (SELECT data#>>'{timezone}' FROM stations_setting), 'YYYY-MM-DD')::date AS created,
    CASE
        WHEN REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 1), '"', '') = 'Add'
            THEN REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 3), '"', '')
        ELSE REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 4), '"', '')
    END AS new_new_weight,
    CASE
        WHEN (d.data_json -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'old_value')::text IS NULL
            THEN (d.data_json -> 'type_changes' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'old_value')::text
        ELSE (d.data_json -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'old_value')::text
    END AS old_weight,
    CASE
        WHEN (d.data_json -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'new_value')::text IS NULL
            THEN (d.data_json -> 'type_changes' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'new_value')::text
        ELSE (d.data_json -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'new_value')::text
    END AS new_weight,
    CASE
        WHEN REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 1), '"', '') = 'Add'
            THEN ''
        ELSE split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 2)
    END AS new_removal_type,
    REPLACE((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '"', '') AS new_removal_type_jsonb,
    split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'old_value')::text, '-#-', 2) AS old_removal_type,
    REPLACE((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'old_value')::text, '"', '') AS old_removal_type_jsonb,
    CASE
        WHEN REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 1), '"', '') = 'Add'
            THEN REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 4), '"', '')
        ELSE REPLACE(split_part((d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::text, '-#-', 5), '"', '')
    END AS updated_grade
FROM stations_tallyevent
CROSS JOIN LATERAL (
    SELECT public.python_dict_text_to_jsonb(stations_tallyevent.data::text) AS data_json
) AS d
WHERE event = 'update'
  AND d.data_json -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value' IS NOT NULL
  AND station_id IN (
      '87878a3b-1372-436a-bb5a-798e9aa3e6a6', '4fc3b2b7-cc29-4e3f-b22e-c5ddb3a6001d',
      'f5ea07f8-b23b-4db1-b681-699cf563bbb3', '204a5f54-b3d6-4e83-b4ea-5ba52f75ae14',
      'f408740f-5758-4755-acdf-4b82324179f4', '41d7c229-b01b-4d06-bf25-328157a9d68d',
      '774c346f-86c3-4e14-a26a-7cd5460897c2', '87939ddd-e921-47bc-9367-3f8d24edb470'
  );
