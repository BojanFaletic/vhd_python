#!/usr/bin/python3.8

import pyxsi
import random

# VHDL uses 1ps timestep by default. This results in a 100 MHz clock.
HALF_PERIOD = 5000

def sum_model(a,b):
    return a+b

def test_counting():
    xsi = pyxsi.XSI("xsim.dir/widget/xsimk.so")
    xsi.trace_all()

    a_old, b_old = 0,0
    for n in range(2**8):
        xsi.set_port_value("clk", "1")
        xsi.run(HALF_PERIOD)
        xsi.set_port_value("clk", "0")
        xsi.run(HALF_PERIOD)

        xsi.set_port_value("a", f"{n:08b}")
        xsi.set_port_value("b", f"{n:08b}")

        a = xsi.get_port_value("a")
        b = xsi.get_port_value("b")
        sum = xsi.get_port_value("sum")

        # replace X with 0
        to_int = lambda x: eval(f"0b{x.replace('X','0')}")

        assert to_int(sum) == sum_model(a_old, b_old)

        a_old,b_old = to_int(a), to_int(b)


if __name__ == "__main__":
    import pytest
    import sys

    pytest.main(sys.argv)
