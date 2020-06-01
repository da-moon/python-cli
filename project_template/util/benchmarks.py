#!/usr/bin/env python3


import logging

LOGGER = logging.getLogger(__name__)
# BenchmarkContract functions taken from
# https://www.sfu.ca/~ssurjano/optimization.html
# https://en.wikipedia.org/wiki/Test_functions_for_optimization


class BenchmarkContract():
    def __init__(self, name, x_lb, x_ub, y_lb, y_ub):
        self._name = name
        self._x_ub = x_ub
        self._x_lb = x_lb
        self._y_ub = y_ub
        self._y_lb = y_lb

    def name(self):
        return self._name

    def x_boundary(self):
        return [self._x_lb, self._x_ub]

    def y_boundary(self):
        return [self._y_lb, self._y_ub]

    def boundaries(self):
        return [self.x_boundary(), self.y_boundary()]


class Schaffer(BenchmarkContract):
    # https://www.sfu.ca/~ssurjano/schaffer2.html
    def __init__(self):
        ub = 100.0
        lb = -100.0
        name = "schaffer"
        BenchmarkContract.__init__(self, name, lb, ub, lb, ub)

    @staticmethod
    def Run(X, Y):
        """minimum f(0,0)=0"""
        numer = np.square(np.sin(X**2 - Y**2)) - 0.5
        denom = np.square(1.0 + (0.001*(X**2 + Y**2)))
        return 0.5 + (numer*(1.0/denom))


class Eggholder(BenchmarkContract):
    # https://www.sfu.ca/~ssurjano/egg.html
    def __init__(self):
        ub = 512.0
        lb = -512.0
        name = "eggholder"
        BenchmarkContract.__init__(self, name, lb, ub, lb, ub)

    @staticmethod
    def Run(X, Y):
        """minimum f(512, 414.2319)=-959.6407"""
        y = Y+47.0
        a = (-1.0)*(y)*np.sin(np.sqrt(np.absolute((X/2.0) + y)))
        b = (-1.0)*X*np.sin(np.sqrt(np.absolute(X-y)))
        return a+b


class Booth(BenchmarkContract):
    # https://www.sfu.ca/~ssurjano/booth.html
    def __init__(self):
        ub = 10.0
        lb = -10.0
        name = "booth"
        BenchmarkContract.__init__(self, name, lb, ub, lb, ub)

    @staticmethod
    def Run(X, Y):
        """minimum f(1, 3)=0"""
        return ((X)+(2.0*Y)-7.0)**2+((2.0*X)+(Y)-5.0)**2


class Matyas(BenchmarkContract):
    # https://www.sfu.ca/~ssurjano/matya.html
    def __init__(self):
        ub = 10.0
        lb = -10.0
        name = "matyas"
        BenchmarkContract.__init__(self, name, lb, ub, lb, ub)

    @staticmethod
    def Run(X, Y):
        """minimum f(0, 0)=0"""
        return (0.26*(X**2+Y**2))-(0.48*X*Y)


class CrossInTray(BenchmarkContract):
    # https://www.sfu.ca/~ssurjano/crossit.html
    def __init__(self):
        ub = 10.0
        lb = -10.0
        name = "cross"
        BenchmarkContract.__init__(self, name, lb, ub, lb, ub)

    @staticmethod
    def Run(X, Y):
        """
        minimum -2.06261 at 
        f(1.34941, -1.34941)
        f(1.34941, 1.34941)
        f(-1.34941, 1.34941)
        f(-1.34941, -1.34941)
        """
        B = np.exp(np.absolute(100.0-(np.sqrt(X**2+Y**2)/np.pi)))
        A = np.absolute(np.sin(X)*np.sin(Y)*B)+1
        return -0.0001*(A**0.1)


class Levi(BenchmarkContract):
    # https://www.sfu.ca/~ssurjano/levy.html
    def __init__(self):
        ub = 10.0
        lb = -10.0
        name = "levi"
        BenchmarkContract.__init__(self, name, lb, ub, lb, ub)

    @staticmethod
    def Run(X, Y):
        """ minimum f(1,1)=0.0"""
        A = np.sin(3.0*np.pi*X)**2
        B = ((X-1)**2)*(1+np.sin(3.0*np.pi*Y)**2)
        C = ((Y-1)**2)*(1+np.sin(2.0*np.pi*Y)**2)
        return A + B + C


BENCH_FUNCTIONS = {
    "Schaffer": Schaffer(),
    "Eggholder": Eggholder(),
    "Booth": Booth(),
    "Matyas": Matyas(),
    "Cross": CrossInTray(),
    "Levi": Levi(),
}
