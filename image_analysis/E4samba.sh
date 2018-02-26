#!/bin/bash

input_parameters=~/alxscripts/E4C57_input_parameters_template.headfile
optional_slurm_reservation=
SAMBA_startup ${input_parameters} ${optional_slurm_reservation}

# End of script