# bl-phreeqc

A MATLAB Buckley-Leverett simulator coupled to the Geochemical Package PHREEQC
******************************************************************************

This simulator is capable of calculating Buckley-Leverett oil-water flow in a 1D reservoir under influence of geochemical interactions.

The interactions taken into account are: CO2 buffering, calcite dissolution,
and cation exchange.


INSTALLATION
************

To be able to use the simulator's geochemical capabilities the geochemical package PHREEQC must be installed on the user's computer. Especially the IPHREEQC COM objects are of importance. Mind that on a 64-bit machine both the 32- and 64-bit version of the COM object need to be installed.

The simulator itself is run from MATLAB.

USAGE
*****

1. Start MATLAB and open input_parameters
2. Define all input parameters. Calculate stable grid cell sizes and time steps. See 'Simulation of Geochemical Processes during Low Salinity Water Flooding by Coupling Multiphase Buckley-Leverett Flow to the Geochemical Package PHREEQC' by W.J. de Bruin. Plots needed for this calculation can be plotted via the textual user interface after the relative permeability model has been supplied.
3. Run start.m
4. After the simulation the results can be plotted via a textual user interface in MATLAB.

AUTHOR
******

Wouter J. de Bruin

LICENSE
*******

MIT License

Copyright (c) 2016 Wouter J. de Bruin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
