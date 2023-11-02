M300 P807 S1245 ; we're done, chirp

{if max_layer_z < max_print_height}G1 Z{z_offset+min(max_layer_z+2, max_print_height)} F600 ; Move print head up{endif}

G1 X5 Y{print_bed_max[1]*0.8} F{travel_speed*60} ; present print

{if max_layer_z < max_print_height-10}G1 Z{z_offset+min(max_layer_z+40, max_print_height-10)} F600 ; Move print head further up{endif}

M140 S0 ; turn off heatbed
M104 S0 ; turn off temperature
M107 ; turn off fan
M84 X Y E ; disable motors