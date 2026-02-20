-- Convert a Python-dict text column into jsonb inline (no custom function/extension),
-- then keep the rest of the query logic the same by reading from data_jsonb.
WITH stations_tallyevent_parsed AS (
    SELECT
        te.*,
        (
            regexp_replace(
                regexp_replace(
                    regexp_replace(
                        replace(te.data, '''', '"'),
                        '([:\[,][[:space:]]*)None([[:space:]]*[,}\]])',
                        '\1null\2',
                        'g'
                    ),
                    '([:\[,][[:space:]]*)True([[:space:]]*[,}\]])',
                    '\1true\2',
                    'g'
                ),
                '([:\[,][[:space:]]*)False([[:space:]]*[,}\]])',
                '\1false\2',
                'g'
            )
        )::jsonb AS data_jsonb
    FROM stations_tallyevent te
)
SELECT
--  exportgrading.id AS test1,
    event_date,
    event_id,
    tally_id AS pk,
    landing_date,
    depot_name AS depot_name,
    CASE WHEN docket_number IS NULL THEN 'From Adhoc Grading'
         ELSE docket_number END AS docket_number,
    CASE WHEN permit_holder IS NULL THEN 'From Adhoc Grading'
         ELSE permit_holder END AS permit_holder,
    specie,
    CASE WHEN updated_grade = grade_code THEN '' ELSE updated_grade END AS updated_grade,
    grade,
    bin_type,
    bin_number,
    cra,
    original_depot,
    bin_owner,
    updated_at,
    actual_tank,
    ROUND(
        CASE
            WHEN new_removal_type = '-' THEN exportgrading.actual_netweight::NUMERIC
            WHEN old_weight ~ '^[0-9\.]+$' THEN old_weight::NUMERIC
            ELSE COALESCE(new_new_weight, '0')::NUMERIC
        END,
        2
    ) AS old_weight,
    ROUND(
        (
            CASE
                WHEN new_weight ~ '^[0-9\.]+$' THEN new_weight
                ELSE new_new_weight
            END
        )::NUMERIC,
        2
    ) AS new_weight,
    ROUND(
        (
            CASE
                WHEN new_weight ~ '^[0-9\.]+$' THEN new_weight
                ELSE new_new_weight
            END
        )::NUMERIC - (
            CASE
                WHEN old_weight ~ '^[0-9\.]+$' THEN old_weight
                ELSE COALESCE(new_new_weight, '0')
            END
        )::NUMERIC,
        2
    ) AS adjusted_weight,
    CASE
        WHEN COALESCE(old_weight, '0')::NUMERIC > COALESCE(NULLIF(new_weight, 'null'), '0')::NUMERIC THEN 'Remove'
        WHEN new_removal_type = '-' THEN 'Grade Adjustment'
        ELSE 'Add'
    END AS adjustment_type,
    CASE
        WHEN (COALESCE(old_weight, '0'))::NUMERIC > (
            CASE
                WHEN new_weight = 'null' THEN 0
                ELSE (COALESCE(new_weight, '0'))::NUMERIC
            END
        ) THEN new_removal_type
        ELSE ''
    END AS removal_type,
    CASE WHEN new_removal_type = 'Downgrade' THEN downgrade_reason ELSE '' END AS downgrade_reason,
    CASE
        WHEN (
            CASE
                WHEN (COALESCE(old_weight, '0'))::NUMERIC > (
                    CASE
                        WHEN new_weight = 'null' THEN 0
                        ELSE (COALESCE(new_weight, '0'))::NUMERIC
                    END
                ) THEN new_removal_type
                ELSE ''
            END
        ) = 'Sale' THEN buyer
        ELSE ''
    END AS buyer
FROM (
    -- Bin weight adjustment
    SELECT
        id AS event_id,
        TO_CHAR(
            created AT TIME ZONE (SELECT data#>>'{timezone}' FROM stations_setting),
            'YYYY-MM-DD HH24:MI'
        ) AS event_date,
        CASE
            WHEN station_id = '92732e80-2f70-4d9f-843c-b6133933edbd' OR station_id = '87878a3b-1372-436a-bb5a-798e9aa3e6a6' THEN 'Wellington'
            WHEN station_id = '10c83a81-8f2c-4320-9b56-107a1f3b358b' OR station_id = '4fc3b2b7-cc29-4e3f-b22e-c5ddb3a6001d' THEN 'Auckland'
            WHEN station_id = '41cfcc7e-de00-459a-ae77-ff92cbb69ea4' OR station_id = 'f5ea07f8-b23b-4db1-b681-699cf563bbb3' THEN 'Napier'
            WHEN station_id = '7deffede-90ad-4fca-8129-75b29f553f8e' OR station_id = '204a5f54-b3d6-4e83-b4ea-5ba52f75ae14' THEN 'Owenga'
            WHEN station_id = 'e57b1b39-fa93-4d12-8103-d7cd26b9e951' OR station_id = 'f408740f-5758-4755-acdf-4b82324179f4' THEN 'Waitangi'
            WHEN station_id = '8565266c-05fb-4e8c-a2dc-090ee48128f9' OR station_id = '41d7c229-b01b-4d06-bf25-328157a9d68d' THEN 'Totara North'
            WHEN station_id = '732d4948-a9be-459d-836e-b2278a18005a' OR station_id = '774c346f-86c3-4e14-a26a-7cd5460897c2' THEN 'Tauranga'
            WHEN station_id = '8560807b-47a4-4775-be62-87d0eb84012a' OR station_id = '87939ddd-e921-47bc-9367-3f8d24edb470' THEN 'Gisborne'
            ELSE NULL
        END AS updated_at,
        COALESCE(tally_id, tally_pk) AS tally_id,
        TO_CHAR(
            created AT TIME ZONE (SELECT data#>>'{timezone}' FROM stations_setting),
            'YYYY-MM-DD'
        )::DATE AS created,
        CASE
            WHEN REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 1), '"', '') = 'Add'
                THEN REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 3), '"', '')
            ELSE REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 4), '"', '')
        END AS new_new_weight,
        CASE
            WHEN (data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'old_value')::TEXT IS NULL
                THEN (data_jsonb -> 'type_changes' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'old_value')::TEXT
            ELSE (data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'old_value')::TEXT
        END AS old_weight,
        CASE
            WHEN (data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'new_value')::TEXT IS NULL
                THEN (data_jsonb -> 'type_changes' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'new_value')::TEXT
            ELSE (data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''actualNetWeight_kg'']' -> 'new_value')::TEXT
        END AS new_weight,
        CASE
            WHEN REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 1), '"', '') = 'Add'
                THEN ''
            ELSE split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 2)
        END AS new_removal_type,
        REPLACE((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '"', '') AS new_removal_type_jsonb,
        split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'old_value')::TEXT, '-#-', 2) AS old_removal_type,
        REPLACE((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'old_value')::TEXT, '"', '') AS old_removal_type_jsonb,
        CASE
            WHEN REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 1), '"', '') = 'Add'
                THEN REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 4), '"', '')
            ELSE REPLACE(split_part((data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value')::TEXT, '-#-', 5), '"', '')
        END AS updated_grade
    FROM stations_tallyevent_parsed
    WHERE event = 'update'
      AND data_jsonb -> 'values_changed' -> 'root[''exportgrading''][''updates'']' -> 'new_value' IS NOT NULL
      AND station_id IN (
          '87878a3b-1372-436a-bb5a-798e9aa3e6a6',
          '4fc3b2b7-cc29-4e3f-b22e-c5ddb3a6001d',
          'f5ea07f8-b23b-4db1-b681-699cf563bbb3',
          '204a5f54-b3d6-4e83-b4ea-5ba52f75ae14',
          'f408740f-5758-4755-acdf-4b82324179f4',
          '41d7c229-b01b-4d06-bf25-328157a9d68d',
          '774c346f-86c3-4e14-a26a-7cd5460897c2',
          '87939ddd-e921-47bc-9367-3f8d24edb470'
      )
) exportgrading;
