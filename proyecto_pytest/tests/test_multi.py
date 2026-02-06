import pytest

def multiplicar(a,b):
    """funcion que multiolica dos numeros"""
    return a*b

def test_multiplicar():
    assert multiplicar(2,2)==4
    assert multiplicar(1,1)==1
    assert(0,100)==0