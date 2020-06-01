#!/usr/bin/env python3

import logging
from ..util.cli import *
from .main_class import MainClass
from project_template.util.log import *
from project_template.util.cli import MakeCaseAgnostic

LOGGER = logging.getLogger(__name__)

options = ["Foo", "Bar", "Baz"]


def _run_subcommand_algorithm(args):
    LOGGER.debug('Start subcommand with parameters="%s"', args)

    boolean_arg = args.get('boolean_flag', False)
    array_arg = args.get('array_flag')
    integer_arg = args.get('integer_flag')
    float_arg = args.get('float_flag')

    subcommand = MainClass(array_arg, integer_arg, float_arg, boolean_arg)
    subcommand.run()


def configure_parser(sub_parsers):
    """
    Get the argument parser for the subcommand
    """
    parser = sub_parsers.add_parser(
        'subcommand',
        description='a sample subcommand',
        help='the subcommand can act as a template for your own subcommand')
    parser.add_argument(
        '-a',
        '--append-array',
        action='append',
        # makes the cli case agnotic to the value passed by the user
        type=MakeCaseAgnostic(options),
        choices=options,
        dest='array_flag',
        help='choose an option to appand to array.'
    )
    parser.add_argument(
        '-b',
        '--boolean',
        default=False,
        action='store_true',
        dest='boolean_flag',
        help='sample boolean flag (default false)'
    )

    parser.add_argument(
        '-i',
        '--integer',
        type=int,
        default=1,
        dest='integer_flag',
        help='sample integer flag, default: 1',
    )
    parser.add_argument(
        '-f',
        '--float',
        type=float,
        default=0.5,
        dest='float_flag',
        help='sample float flag default: 0.5',
    )
    parser.set_defaults(func=_run_subcommand_algorithm)
