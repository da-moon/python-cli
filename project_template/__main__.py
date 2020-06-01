#!/usr/bin/env python3

import logging
import sys
import argparse
# pylint: disable=import-error
# to do remove import-error
from project_template.basic_subcommand.main import configure_parser as subcommand_parser
from project_template.util.cli import *
from project_template._version import *
from project_template.util.log import *
LOGGER = logging.getLogger(__name__)
logging.addLevelName(logging.DEBUG - 5, 'TRACE')
addLoggingLevel('TRACE', logging.DEBUG - 5)


def run_project_template():

    log_levels = ['TRACE', 'DEBUG', 'INFO']
    parser = argparse.ArgumentParser(
        description='a template for python cli and datascience projects.')
    parser.add_argument(
        "-l",
        "--log",
        dest="logLevel",
        type=MakeCaseAgnostic(log_levels),
        choices=log_levels,
        help="Set the logging level (default Empty)")
    sub_parsers = parser.add_subparsers(
        title='Sub Commands',
        description='Available Subcommands',
        help='Choose subcommand to execute')
    # adding subcommand parsers
    # INFO add subcommand parsers HERE
    subcommand_parser(sub_parsers)
    # parsers added
    args = vars(parser.parse_args())
    if args:
        logLevel = args['logLevel']
        if logLevel:
            logging.basicConfig(
                format='%(asctime)s [%(threadName)-12.12s] [%(levelname)-8.8s]  %(message)s',
                stream=sys.stdout,
                level=getattr(logging, logLevel)
            )
    else:
        parser.print_usage()


if __name__ == '__main__':
    run_project_template()
