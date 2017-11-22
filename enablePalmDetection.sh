#/bin/bash
echo DELL XPS 15 configs

xinput
xinput list-props 14
xinput set-prop 14 "Synaptics Palm Detection" 1
xinput set-prop 14 "Synaptics Palm Dimensions" 5, 5
xinput set-prop 14 "Synaptics Area" 70 1168 70 0
