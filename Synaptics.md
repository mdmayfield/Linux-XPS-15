# Default Synaptics driver

This actually seems to work better than mtrack for everything... except thumb detection. :-(

mattmayfield@mm-xps-15:~$ xinput list-props 12
Device 'DLL06E4:01 06CB:7A13 Touchpad':
	Device Enabled (142):	1
	Coordinate Transformation Matrix (144):	1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
	Device Accel Profile (265):	1
	Device Accel Constant Deceleration (266):	2.500000
	Device Accel Adaptive Deceleration (267):	1.000000
	Device Accel Velocity Scaling (268):	12.500000
	Synaptics Edges (269):	49, 1179, 50, 878
	Synaptics Finger (270):	25, 30, 0
	Synaptics Tap Time (271):	180
	Synaptics Tap Move (272):	67
	Synaptics Tap Durations (273):	180, 180, 100
	Synaptics ClickPad (274):	1
	Synaptics Middle Button Timeout (275):	0
	Synaptics Two-Finger Pressure (276):	282
	Synaptics Two-Finger Width (277):	7
	Synaptics Scrolling Distance (278):	30, 30
	Synaptics Edge Scrolling (279):	0, 0, 0
	Synaptics Two-Finger Scrolling (280):	1, 1
	Synaptics Move Speed (281):	1.000000, 1.750000, 0.129955, 0.000000
	Synaptics Off (282):	2
	Synaptics Locked Drags (283):	0
	Synaptics Locked Drags Timeout (284):	5000
	Synaptics Tap Action (285):	0, 3, 0, 1, 1, 3, 2
	Synaptics Click Action (286):	1, 3, 0
	Synaptics Circular Scrolling (287):	0
	Synaptics Circular Scrolling Distance (288):	0.100000
	Synaptics Circular Scrolling Trigger (289):	0
	Synaptics Circular Pad (290):	0
	Synaptics Palm Detection (291):	1
	Synaptics Palm Dimensions (292):	10, 200
	Synaptics Coasting Speed (293):	20.000000, 50.000000
	Synaptics Pressure Motion (294):	30, 160
	Synaptics Pressure Motion Factor (295):	1.000000, 1.000000
	Synaptics Resolution Detect (296):	1
	Synaptics Grab Event Device (297):	0
	Synaptics Gestures (298):	1
	Synaptics Capabilities (299):	1, 0, 0, 1, 1, 0, 0
	Synaptics Pad Resolution (300):	12, 12
	Synaptics Area (301):	70, 1168, 70, 858
	Synaptics Soft Button Areas (302):	614, 0, 760, 0, 0, 0, 0, 0
	Synaptics Noise Cancellation (303):	7, 7
	Device Product ID (260):	1739, 31251
	Device Node (261):	"/dev/input/event11"
mattmayfield@mm-xps-15:~$ xinput set-prop 12 269 0 1228 0 928
mattmayfield@mm-xps-15:~$ xinput set-prop 12 301 70 1158 70 400
mattmayfield@mm-xps-15:~$ xinput set-prop 12 301 70 1158 70 858
