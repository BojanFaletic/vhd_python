default: pyxsi.so

.PHONY: rtl test clean

XILINX_VIVADO := /tools/Vivado/2018.2

VPATH=xilinx

CXXFLAGS=-fPIC -std=c++17 -I/usr/include/python3.8 -I$(XILINX_VIVADO)/data/xsim/include -Ixilinx

%.o: %.cpp
	g++ $(CXXFLAGS) -c -o $@ $<

pyxsi.so: pybind.o xsi_loader.o
	g++ $(CXXFLAGS) -shared -o $@ $^ -ldl

rtl:
	xelab work.adder -prj rtl/widget.prj -debug all -dll -s widget

test: pyxsi.so
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(XILINX_VIVADO)/lib/lnx64.o python3.8 -m pytest python/test.py -s

clean:
	-rm *.o *.so
	-rm -rf xsim.dir python/__pycache__ *.jou *.log xelab.pb *.wdb
