#!/usr/bin/env python3

from project_template.util.log import *
import random as random
import logging
import time
LOGGER = logging.getLogger(__name__)


class MainClass():
    def __init__(self, array_arg, integer_arg, float_arg, boolean_arg=False):
        """
        this acts as entrypoint for the main class that acts as 'backend' for
        operations the calling subcommand needs.
        In fact, one can think of the corresponding subcommand as a 'demo' of 
        some sort for this class.
        Keyword arguments:  
        `array_arg`                     -- an array argument for the constructor
        `integer_arg`                   -- an integer argument for the constructor
        `float_arg`                     -- a  float argument for the constructor
        `boolean_arg`                   -- a  boolean argument for the constructor
        """
        self._array = array_arg
        self._integer = integer_arg
        self._float = float_arg
        self._boolean = boolean_arg

    def run(self):
        LOGGER.info("running basic subcommand 'run' argument")
