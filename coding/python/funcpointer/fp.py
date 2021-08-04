#!/usr/bin/python

def repeat(function, params, times):
    for calls in range(times):
        function(*params)

def foo(a, b):
    print ('{} are {}'.format(a, b))

def fpp(a, b):
    print ('{} is {}'.format(a, b))

yui = [fpp, foo]
repeat(yui[0], ['roses', 'red'], 4)
repeat(yui[1], ['violets', 'blue'], 4)
