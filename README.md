This repository provides the analysis code used to quantify orientation-driven radial growth asymmetry in trees and to assess its spatial patterns, temporal trends, and growth consequences across Northern Hemisphere forests.
The workflow accompanies the manuscript:

Warming amplifies orientation-driven asymmetry and slows forest growth and implements the Tree Growth Asymmetry Index (TGAI) based on tree-ring measurements from equator-facing and pole-facing stem sectors.
The `sitede` file contains information descriptions of the 71 sites that were ultimately selected.
The file ‘N_S_Treering_results_select.csv’ contains tree cores with a north-south orientation selected from the International Tree-Ring Data Bank (ITRDB).
The notebook implements the following steps:
Main workflow (Main_TAGI.ipynb)

1.Spatial and hydroclimatic analyses
Relationships between TGAI and hydroclimatic variables (e.g., precipitation, aridity, soil moisture)
Identification of climate-dependent envelopes of growth asymmetry

2.Temporal trend analyses
Long-term trends in TGAI over the past century
Comparison of trends across climatic zones
Non-parametric trend tests and slope estimation

3.Growth consequence analyses
Relationships between TGAI and basal area increment (BAI)
Site-level and regional regression analyses
Figure and table generation
