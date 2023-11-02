; M117 commands will update an LCD screen attached to your printer, uncomment them if you have one
; Only meant to work for the Elegoo Neptune 3 Max.

; Starting gcode, sing a little song:
M300 P202 S784
M300 P101 S784
M300 P101 S784
M300 P403 S622
M300 P202 S831
M300 P101 S831
M300 P101 S831
M300 P202 S932
M300 P101 S932
M300 P101 S932
M300 P807 S1245

; Initial Setup and Warmup:
; M117 Initializing ; update LCD if we have one
M413 S0 ; disable Power Loss recovery - Experiment with enabling?
G90 ; use absolute coordinates
M83 ; use relative mode for extruder

; Reset speed and extrusion rate values. changes to 
; these could persist between prints otherwise:
M200 D0 ; disable volumetric extrusion
M220 S100 ; reset speed
M221 S100 ; reset extrusion rate

; Set initial warmup temps:
; M117 Nozzle Preheat ; update LCD if we have one
M104 S160 ; set initial nozzle temp low to prevent ooze
M140 S[first_layer_bed_temperature] ; set final bed temp
G4 S10 ; allow partial nozzle warmup
G28 ; return to home on all axis 
; G29 ; run ABL mesh (???)
M420 S1 ; load bed mesh

; Done with initial setup and warmup commands, report progress:
M300 S100 P100; chirp

; Present bed and wait for it to get closer to final temp:
; M117 Heating Bed ; update LCD if we have one
G0 Z25 F240 ; get the nozzle safely away from bed
G0 Y400 F3000 ; move bed forward for access while waiting for temps
M190 S{first_layer_bed_temperature[0] - 5} ; wait till -5 target bed temp
M140 S[first_layer_bed_temperature] ; resume bed temp heating

; About to take the bed back to finish heating:
M300 S100 P100 ; chirp

; Finishing heating nozzle and prepare to prime:
; M117 Finishing Preheat ; update LCD if we have one
M104 S[first_layer_temperature] ; set final nozzle temp
G0 X265 Y-1 F3000 ; move nozzle above buildplate tab
G0 Z15 F240 ; lower nozzle closer to build plate
M109 S[first_layer_temperature] ; wait for final nozzle temp

; Done with heating and prep, about to prime nozzle:
M300 S100 P100 ; chirp

; Prepare to print prime line:
; M117 Printing prime line ; update LCD if we have one
G0 Z0.15 F240 ; lower to final height
M900 K0 ; disable Linear Advance for prime line
G92 E0.0 ; reset extrusion distance

; Begin printing prime line: 
G1 E2 F1000 ; de-retract and push ooze for one second
G1 X245 E6 F1000 ; fat 20mm intro line @ 0.30
G1 X205 E3.2 F1000 ; thin +40mm intro line @ 0.08
G1 X165 E6 F1000 ; fat +40mm intro line @ 0.15
G1 E-0.8 F3000 ; retract to avoid stringing
G1 X165.5 E0 F1000 ; -0.5mm wipe action to avoid string
G1 X155 E0 F1000 ; +10mm intro line @ 0.00
G1 E0.6 F1500 ; de-retract
G92 E0.0 ; reset extrusion distance

; Done priming, ready to print!
; M117 Starting Print ; update LCD if we have one
M300 S100 P100 ; chirp
M300 S100 P100 ; chirp
M300 S100 P100 ; chirp
