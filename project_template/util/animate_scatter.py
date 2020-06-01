#!/usr/bin/env python3

import matplotlib.pyplot as plt
import time

import numpy as np
import matplotlib
matplotlib.use('TkAgg')
# matplotlib.use('agg')


class AnimateScatter():
    """creates an animated scatter plot which can be updated"""

    def __init__(self, xmin, xmax, ymin, ymax, positions, colors, func, resolution, sleep_time):
        plt.ion()
        self.xmin = xmin
        self.xmax = xmax
        self.ymin = ymin
        self.ymax = ymax

        self._figure, self._axes = plt.subplots()

        self._colors = colors
        self._func = func
        self.sleep_time = sleep_time

        # arange : return evenly spaced values within a given interval.
        # we would use resolution to eliminate whitespace
        self.x = np.arange(self.xmin, self.xmax+resolution, resolution)
        self.y = np.arange(self.ymin, self.ymax+resolution, resolution)
        # Meshgrid : takes 1-D arrays representing the coordinates of a grid.
        # and returns coordinate matrices from coordinate vectors.
        func_x, func_y = np.meshgrid(self.x, self.y, sparse=True)
        self.z = self._func(func_x, func_y)
        self.update(positions)

    def update(self, positions):
        self._axes.clear()
        self._axes.axis([self.xmin, self.xmax, self.ymin, self.ymax])
        # drawing background
        self._axes.contourf(self.x, self.y, self.z)
        self._axes.scatter(
            positions[:, 0], positions[:, 1], s=15, c=self._colors)
        # updating canvas
        self._figure.canvas.draw()
        self._figure.canvas.flush_events()
        time.sleep(self.sleep_time)


def configure_parser(sub_parser):
    """
    Get the argument parser for plotting
    """
    sub_parser.add_argument(
        '--plot',
        default=False,
        action='store_true',
        dest='plot',
        help='enable plotting output(default false)'
    )
    sub_parser.add_argument(
        '--resolution',
        type=float,
        default=0.25,
        dest='resolution',
        help='resolution of the grid.Default : 0.25'
    )
    sub_parser.add_argument(
        '--sleep-time',
        type=float,
        default=0.1,
        dest='sleep_time',
        help='animation sleep time.Default : 0.1'
    )
