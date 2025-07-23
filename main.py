import sys
import os
from backend.excel import Excel
from backend.config.config import MetadataInputConfig

def print2FeedbackConsole(message):
    print(message)

def main():
    if len(sys.argv) != 2:
        print("Usage: python main.py <path_to_excel_file>")
        sys.exit(1)
    excel_path = sys.argv[1]
    if not os.path.isfile(excel_path):
        print(f"File not found: {excel_path}")
        sys.exit(1)
    # Read config.ini for Excel config
    config_data = MetadataInputConfig().data['config']
    excel_config = dict(config_data['Excel'])
    # Override excel_path with CLI argument
    excel_config['excel_path'] = excel_path
    excel_processor = Excel(turboVaultconfigs=excel_config, print2FeedbackConsole=print2FeedbackConsole)
    excel_processor.read()
    excel_processor.setTODO(
        SourceYML=True,  # Enable sources.yml generation
        Tasks=[
            'Stage', 'Standard Hub', 'Standard Satellite', 'Standard Link',
            'Non-Historized Link', 'Point-in-Time', 'Non-Historized Satellite',
            'Multi-Active Satellite', 'Record Tracking Satellite'
        ],
        DBDocs=False,
        Properties=False,
        Sources=excel_processor.data_structure.get('source_list', [])
    )
    excel_processor.run()

if __name__ == '__main__':
    main()