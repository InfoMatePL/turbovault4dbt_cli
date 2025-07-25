import sys
import os
import argparse
from turbovault4dbt_cli.backend.excel import Excel
from turbovault4dbt_cli.backend.config.config import MetadataInputConfig
from turbovault4dbt_cli.backend.graph_utils import build_dependency_graph, select_nodes

def print2FeedbackConsole(message):
    print(message)

def main():
    parser = argparse.ArgumentParser(description="TurboVault4dbt CLI with graph selectors")
    parser.add_argument('--file', required=True, help='Path to Excel metadata file')
    parser.add_argument('-s', '--select', nargs='*', help='Selector(s) for graph nodes (e.g. +A B+ @C)')
    args = parser.parse_args()

    excel_path = args.file
    if not os.path.isfile(excel_path):
        print(f"File not found: {excel_path}")
        sys.exit(1)

    # Read config.ini for Excel config
    config_data = MetadataInputConfig().data['config']
    excel_config = dict(config_data['Excel'])
    # Override excel_path with CLI argument
    excel_config['excel_path'] = excel_path

    # Build dependency graph
    G = build_dependency_graph(excel_path)

    # Select nodes
    if args.select:
        selected_nodes = select_nodes(G, args.select)
    else:
        selected_nodes = set(G.nodes)

    print("Selected nodes for processing:")
    for node in sorted(selected_nodes):
        print(f"  {node}")

    # Filter sources/entities to only those selected
    sources_to_process = [n for n in selected_nodes if G.nodes[n].get('type') in {'hub','link','satellite','ma_satellite','nh_satellite','pit'}]

    if not sources_to_process:
        print("No valid sources/entities selected for code generation.")
        sys.exit(0)

    # Run code generation for selected sources/entities
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
        Sources=sources_to_process
    )
    excel_processor.run()

if __name__ == '__main__':
    main()