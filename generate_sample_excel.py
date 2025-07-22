import pandas as pd
import numpy as np

N = 30  # Number of rows for each sheet

# Helper to generate unique values
unique = lambda prefix, n: [f"{prefix}{i+1}" for i in range(n)]

standard_hub = pd.DataFrame({
    'Hub_Identifier': unique('HUB', N),
    'Target_Hub_table_physical_name': unique('hub_table', N),
    'Business_Key_Physical_Name': unique('bk', N),
    'Group_Name': unique('Group', N),
    'Target_Role_Primary_Key_Physical_Name': unique('role_pk', N),
    'Source_Table_Identifier': unique('SRC', N),
    'Is_Primary_Source': np.random.choice([0, 1], N),
    'Target_Column_Sort_Order': np.arange(1, N+1),
    'Source_Column_Physical_Name': unique('src_col', N)
})

standard_satellite = pd.DataFrame({
    'Satellite_Identifier': unique('SAT', N),
    'Target_Satellite_Table_Physical_Name': unique('sat_table', N),
    'Parent_Identifier': unique('HUB', N),
    'Parent_Primary_Key_Physical_Name': unique('bk', N),
    'Group_Name': unique('Group', N),
    'Source_Table_Identifier': unique('SRC', N),
    'Target_Column_Physical_Name': unique('sat_col', N),
    'Target_Column_Sort_Order': np.arange(1, N+1),
    'hs.Target_Column_Physical_Name': unique('hs_tcol', N)
})

source_data = pd.DataFrame({
    'Source_System': np.random.choice(['CRM', 'ERP', 'Billing', 'Support'], N),
    'Source_Object': unique('Object', N),
    'Source_Schema_Physical_Name': unique('schema', N),
    'Source_Table_Physical_Name': unique('table', N),
    'Record_Source_Column': unique('record_source', N),
    'Load_Date_Column': unique('load_date', N),
    'Source_table_identifier': unique('SRC', N)
})

pit = pd.DataFrame({
    'Pit_Identifier': unique('PIT', N),
    'Pit_Physical_Table_Name': unique('pit_table', N),
    'Tracked_Entity': unique('HUB', N),
    'Snapshot_Model_Name': unique('snap', N),
    'Snapshot_Trigger_Column': unique('trigger_col', N),
    'Dimension_Key_Name': unique('dim_key', N),
    'Satellite_Identifiers': unique('SAT', N)
})

standard_link = pd.DataFrame({
    'Link_Identifier': unique('LINK', N),
    'Target_Link_table_physical_name': unique('link_table', N),
    'Source_Table_Identifier': unique('SRC', N),
    'Group_Name': unique('Group', N),
    'Target_Primary_Key_Physical_Name': unique('link_pk', N),
    'Business_Key_Physical_Name': unique('link_bk', N),
    'Target_column_physical_name': unique('TargetCol', N),
    'Prejoin_Target_Column_Alias': unique('prejoin_alias', N),
    'Source_column_physical_name': unique('src_col', N)
})

non_historized_link = pd.DataFrame({
    'NH_Link_Identifier': unique('NHL', N),
    'Target_Link_table_physical_name': unique('nh_link_table', N),
    'Source_Table_Identifier': unique('SRC', N),
    'Group_Name': unique('Group', N),
    'Target_Primary_Key_Physical_Name': unique('nh_link_pk', N),
    'Business_Key_Physical_Name': unique('nh_link_bk', N),
    'Hub_primary_key_physical_name': unique('hub_pk', N),
    'Record_Tracking_Satellite': np.random.choice([0, 1], N),
    'Prejoin_Target_Column_Alias': unique('prejoin_alias', N),
    'Source_column_physical_name': unique('src_col', N),
    'l.Record_Tracking_Satellite': np.random.choice([0, 1], N)
})

multiactive_satellite = pd.DataFrame({
    'MA_Satellite_Identifier': unique('MAS', N),
    'Target_Satellite_Table_Physical_Name': unique('ma_sat_table', N),
    'Parent_Identifier': unique('HUB', N),
    'Parent_Primary_Key_Physical_Name': unique('bk', N),
    'Group_Name': unique('Group', N),
    'Source_Table_Identifier': unique('SRC', N),
    'MultiActive_Column': unique('ma_col', N),
    'hs.Target_Column_Physical_Name': unique('hs_tcol', N)
})

non_historized_satellite = pd.DataFrame({
    'NH_Satellite_Identifier': unique('NHS', N),
    'Target_Satellite_Table_Physical_Name': unique('nh_sat_table', N),
    'Parent_Identifier': unique('HUB', N),
    'Parent_Primary_Key_Physical_Name': unique('bk', N),
    'Group_Name': unique('Group', N),
    'Source_Table_Identifier': unique('SRC', N),
    'Target_Column_Physical_Name': unique('nh_sat_col', N),
    'hs.Target_Column_Physical_Name': unique('hs_tcol', N)
})

with pd.ExcelWriter('metadata_ddl/Excel/sample_metadata_v3.xlsx') as writer:
    standard_hub.to_excel(writer, sheet_name='standard_hub', index=False)
    standard_satellite.to_excel(writer, sheet_name='standard_satellite', index=False)
    source_data.to_excel(writer, sheet_name='source_data', index=False)
    pit.to_excel(writer, sheet_name='pit', index=False)
    standard_link.to_excel(writer, sheet_name='standard_link', index=False)
    non_historized_link.to_excel(writer, sheet_name='non_historized_link', index=False)
    multiactive_satellite.to_excel(writer, sheet_name='multiactive_satellite', index=False)
    non_historized_satellite.to_excel(writer, sheet_name='non_historized_satellite', index=False)

print('Sample Excel metadata file generated: metadata_ddl/Excel/sample_metadata_v3.xlsx') 