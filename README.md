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
