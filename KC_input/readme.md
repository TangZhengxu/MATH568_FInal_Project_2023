# Input from PNs to 2D KC matrix

```odor_PN_t.mat``` is 110 odor responses simulated in 23 PNs during 2500 time steps from Kennedy model. Each time step is 0.5 ms. The dimention of this matrix is 110\*23\*2500.

```PN_KC_connect.m``` is a helper function to connect PN to KC either randomly or following a spatial distribution, to be documented.

```load_KC_input.m``` is a demo code to load PN responses and provide input to a 45\*45 2D KC matrix. 