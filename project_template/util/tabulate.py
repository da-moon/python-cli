#!/usr/bin/env python3
import pandas as pd
from tabulate import tabulate

columns = ['X', 'Y', 'Fitness', 'Execution Time']


class Tabulate():
    '''
    Tabulate class is a wrapper around tabulate that is used to format
    algorithm iteration output in a nice tabular form. it also allows fo csv output
    the table is powered by pandas
    '''

    def __init__(self, index_name):
        self._results = pd.DataFrame(columns=columns)
        self._index_name = index_name
        self._results.index.names = [self._index_name]

    def add_record(self, id, execution_time, agent):
        agent_fitness = agent.get_fitness()
        x = agent.get_position()[0]
        y = agent.get_position()[1]

        temp = pd.DataFrame(
            {
                'X': x,
                'Y':  y,
                'Fitness':  agent_fitness,
                'Execution Time': execution_time
            }, index=[id]
        )
        temp.index.names = [self._index_name]
        self._results = temp.append(self._results)

    def get_table(self):
        return self._results.sort_index(axis=0)

    def pretty_print(self):
        return tabulate(self.get_table(), headers='keys', tablefmt='psql')

    def export_to_csv(self, path):
        self.get_table().to_csv(path, header=True, index=True)


def configure_parser(sub_parser):
    sub_parser.add_argument(
        '--csv-export',
        type=str,
        dest='csv_export',
        help='target file path to export every iteration top result.'
    )
