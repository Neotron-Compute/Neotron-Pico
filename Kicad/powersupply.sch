EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 11
Title "Neotron Common Hardware - Power Supply"
Date "2021-06-03"
Rev "[Uncontrolled]"
Comp "https://neotron-compute.github.io/"
Comment1 "Licenced as CC BY-SA"
Comment2 "Copyright (c) The Neotron Developers, 2021"
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 1975 1850 0    50   Italic 0
2.51mm (inner, 5.5mm outer\ndiameter) barrel jack.\nCentre +ve.
Text Notes 8525 4075 0    50   Italic 0
Most of our board runs on 3.3V. We expect\nto draw around 100 mA from this 1A linear\nregulator.\n\nNorm. power wasted: (5V - 3.3V) * 0.1A = 0.17W\nMax power wasted: (5V - 3.3V) * 1A = 1.7W\n\nThe LDO is 50 °C/W so at max power,\nit's 85 °C over ambient. Probably best\nto use a heatsink if you want to pull\nover about 250 mA. Or replace with a\n3-terminal switching PSU module.
Text Notes 4425 1550 0    50   Italic 0
Some of our board (e.g. USB) runs on 5V. We also need\nto supply 2A (4x500mA) to downstream USB devices.\nWe use a big 3A/5V DC-DC to supply this.
$Comp
L Regulator_Linear:AMS1117CD-3.3 U803
U 1 1 5FECE573
P 7525 3525
F 0 "U803" H 7525 3767 50  0000 C CNN
F 1 "TLV1117 3.3V 1A" H 7525 3676 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 7525 3725 50  0001 C CNN
F 3 "http://www.ti.com/general/docs/suppproductinfo.tsp?distId=10&gotoUrl=http%3A%2F%2Fwww.ti.com%2Flit%2Fgpn%2Ftlv1117lv" H 7625 3275 50  0001 C CNN
F 4 "0" H 7525 3525 50  0001 C CNN "DNP"
F 5 "296-28778-1-ND" H 7525 3525 50  0001 C CNN "Digikey"
F 6 "CPL-REG-LIN-3.3V-1A" H 7525 3525 50  0001 C CNN "MPN"
F 7 "CPL" H 7525 3525 50  0001 C CNN "Manufacturer"
F 8 "595-TLV1117LV33DCYR" H 7525 3525 50  0001 C CNN "Mouser"
F 9 "C6186" H 7525 3525 50  0001 C CNN "LCSC Part#"
	1    7525 3525
	1    0    0    -1  
$EndComp
$Comp
L Device:C C807
U 1 1 606E29CB
P 7875 3775
F 0 "C807" H 7993 3821 50  0000 L CNN
F 1 "1uF" H 7993 3730 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7913 3625 50  0001 C CNN
F 3 "~" H 7875 3775 50  0001 C CNN
F 4 "0" H 7875 3775 50  0001 C CNN "DNP"
F 5 "" H 7875 3775 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-X7R-0805-1UF-25V" H 7875 3775 50  0001 C CNN "MPN"
F 7 "CPL" H 7875 3775 50  0001 C CNN "Manufacturer"
F 8 "C28323" H 7875 3775 50  0001 C CNN "LCSC Part#"
	1    7875 3775
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0816
U 1 1 606E29CC
P 7875 4025
F 0 "#PWR0816" H 7875 3775 50  0001 C CNN
F 1 "GND" H 7880 3852 50  0000 C CNN
F 2 "" H 7875 4025 50  0001 C CNN
F 3 "" H 7875 4025 50  0001 C CNN
	1    7875 4025
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0815
U 1 1 606E29CD
P 7525 4025
F 0 "#PWR0815" H 7525 3775 50  0001 C CNN
F 1 "GND" H 7530 3852 50  0000 C CNN
F 2 "" H 7525 4025 50  0001 C CNN
F 3 "" H 7525 4025 50  0001 C CNN
	1    7525 4025
	1    0    0    -1  
$EndComp
$Comp
L Device:Polyfuse F801
U 1 1 606E29D1
P 2975 2125
F 0 "F801" V 2750 2125 50  0000 C CNN
F 1 "32V 2A PTC" V 2841 2125 50  0000 C CNN
F 2 "Fuse:Fuse_BelFuse_0ZRE0016FF_L9.9mm_W3.8mm" H 3025 1925 50  0001 L CNN
F 3 "https://belfuse.com/resources/datasheets/circuitprotection/ds-cp-0zrs-series.pdf" H 2975 2125 50  0001 C CNN
F 4 "0" H 2975 2125 50  0001 C CNN "DNP"
F 5 "507-0ZRS0200FF1E-ND" H 2975 2125 50  0001 C CNN "Digikey"
F 6 "0ZRS0200FF1E" H 2975 2125 50  0001 C CNN "MPN"
F 7 "Bel Fuse" H 2975 2125 50  0001 C CNN "Manufacturer"
F 8 "530-0ZRS0200FF1E" H 2975 2125 50  0001 C CNN "Mouser"
F 9 "~" H 2975 2125 50  0001 C CNN "LCSC Part#"
	1    2975 2125
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0804
U 1 1 5FED7E13
P 2775 2625
F 0 "#PWR0804" H 2775 2375 50  0001 C CNN
F 1 "GND" H 2780 2452 50  0000 C CNN
F 2 "" H 2775 2625 50  0001 C CNN
F 3 "" H 2775 2625 50  0001 C CNN
	1    2775 2625
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:MAX1615xUK U802
U 1 1 606E29D4
P 4725 3975
F 0 "U802" H 4725 4342 50  0000 C CNN
F 1 "MAX1615" H 4725 4251 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 4725 3725 50  0001 C CNN
F 3 "https://datasheets.maximintegrated.com/en/ds/MAX1615-MAX1616.pdf" H 4725 3725 50  0001 C CNN
F 4 "0" H 4725 3975 50  0001 C CNN "DNP"
F 5 "MAX1615EUK+TCT-ND" H 4725 3975 50  0001 C CNN "Digikey"
F 6 "MAX1615EUK+T" H 4725 3975 50  0001 C CNN "MPN"
F 7 "Maxim" H 4725 3975 50  0001 C CNN "Manufacturer"
F 8 "700-MAX1615EUKT" H 4725 3975 50  0001 C CNN "Mouser"
F 9 "C52770" H 4725 3975 50  0001 C CNN "LCSC Part#"
	1    4725 3975
	1    0    0    -1  
$EndComp
Text Notes 4400 1800 0    50   Italic 0
36V max input\n3A max output
Text Notes 4425 3550 0    50   Italic 0
28V max input\n30mA max output
$Comp
L power:GND #PWR0811
U 1 1 606E29D6
P 5425 4650
F 0 "#PWR0811" H 5425 4400 50  0001 C CNN
F 1 "GND" H 5430 4477 50  0000 C CNN
F 2 "" H 5425 4650 50  0001 C CNN
F 3 "" H 5425 4650 50  0001 C CNN
	1    5425 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C803
U 1 1 5FEEC6C5
P 4000 4275
F 0 "C803" H 4118 4321 50  0000 L CNN
F 1 "100nF" H 4118 4230 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 4038 4125 50  0001 C CNN
F 3 "~" H 4000 4275 50  0001 C CNN
F 4 "0" H 4000 4275 50  0001 C CNN "DNP"
F 5 "" H 4000 4275 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-X7R-0805-100NF-50V" H 4000 4275 50  0001 C CNN "MPN"
F 7 "CPL" H 4000 4275 50  0001 C CNN "Manufacturer"
F 8 "C49678" H 4000 4275 50  0001 C CNN "LCSC Part#"
F 9 "50V" H 4000 4275 50  0001 C CNN "Voltage"
	1    4000 4275
	1    0    0    -1  
$EndComp
Connection ~ 4725 4525
Wire Wire Line
	5425 4650 5425 4525
$Comp
L power:+5V #PWR0812
U 1 1 606E29D8
P 6175 2025
F 0 "#PWR0812" H 6175 1875 50  0001 C CNN
F 1 "+5V" H 6190 2198 50  0000 C CNN
F 2 "" H 6175 2025 50  0001 C CNN
F 3 "" H 6175 2025 50  0001 C CNN
	1    6175 2025
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0814
U 1 1 606E29CF
P 7175 4025
F 0 "#PWR0814" H 7175 3775 50  0001 C CNN
F 1 "GND" H 7180 3852 50  0000 C CNN
F 2 "" H 7175 4025 50  0001 C CNN
F 3 "" H 7175 4025 50  0001 C CNN
	1    7175 4025
	1    0    0    -1  
$EndComp
$Comp
L Device:C C806
U 1 1 606E29CE
P 7175 3775
F 0 "C806" H 7293 3821 50  0000 L CNN
F 1 "100nF" H 7293 3730 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7213 3625 50  0001 C CNN
F 3 "~" H 7175 3775 50  0001 C CNN
F 4 "0" H 7175 3775 50  0001 C CNN "DNP"
F 5 "" H 7175 3775 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-X7R-0805-100NF-50V" H 7175 3775 50  0001 C CNN "MPN"
F 7 "CPL" H 7175 3775 50  0001 C CNN "Manufacturer"
F 8 "" H 7175 3775 50  0001 C CNN "Mouser"
F 9 "C49678" H 7175 3775 50  0001 C CNN "LCSC Part#"
	1    7175 3775
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0809
U 1 1 606E29DA
P 5275 2700
F 0 "#PWR0809" H 5275 2450 50  0001 C CNN
F 1 "GND" H 5280 2527 50  0000 C CNN
F 2 "" H 5275 2700 50  0001 C CNN
F 3 "" H 5275 2700 50  0001 C CNN
	1    5275 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C804
U 1 1 606E29DB
P 5275 2375
F 0 "C804" H 5393 2421 50  0000 L CNN
F 1 "10uF" H 5393 2330 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5313 2225 50  0001 C CNN
F 3 "~" H 5275 2375 50  0001 C CNN
F 4 "0" H 5275 2375 50  0001 C CNN "DNP"
F 5 "" H 5275 2375 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-X5R-0805-10UF-16V" H 5275 2375 50  0001 C CNN "MPN"
F 7 "CPL" H 5275 2375 50  0001 C CNN "Manufacturer"
F 8 "C15850" H 5275 2375 50  0001 C CNN "LCSC Part#"
	1    5275 2375
	1    0    0    -1  
$EndComp
Text Notes 4050 4825 0    50   Italic 0
This small PSU runs our\nboard management controller.\nIt is set to 3.3V output.
Text Notes 1925 1350 0    100  Italic 20
Main Power Regulators
$Comp
L Device:L L801
U 1 1 606E29FD
P 3475 2125
F 0 "L801" V 3665 2125 50  0000 C CNN
F 1 "22uH 2A" V 3574 2125 50  0000 C CNN
F 2 "Inductor_THT:L_Radial_D9.5mm_P5.00mm_Fastron_07HVP" H 3475 2125 50  0001 C CNN
F 3 "https://www.murata-ps.com/pub/data/magnetics/kmp_1300r.pdf" H 3475 2125 50  0001 C CNN
F 4 "0" H 3475 2125 50  0001 C CNN "DNP"
F 5 "13R223C" V 3475 2125 50  0001 C CNN "MPN"
F 6 "Murata" V 3475 2125 50  0001 C CNN "Manufacturer"
F 7 "811-2042-ND" V 3475 2125 50  0001 C CNN "Digikey"
F 8 "" H 3475 2125 50  0001 C CNN "Mouser"
F 9 "~" H 3475 2125 50  0001 C CNN "LCSC Part#"
	1    3475 2125
	0    -1   -1   0   
$EndComp
$Comp
L Device:CP C801
U 1 1 60282A88
P 3225 2375
F 0 "C801" H 3325 2375 50  0000 L CNN
F 1 "100uF" H 3250 2275 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 3263 2225 50  0001 C CNN
F 3 "~" H 3225 2375 50  0001 C CNN
F 4 "0" H 3225 2375 50  0001 C CNN "DNP"
F 5 "" H 3225 2375 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-ALU-RAD-100UF-50V" H 3225 2375 50  0001 C CNN "MPN"
F 7 "CPL" H 3225 2375 50  0001 C CNN "Manufacturer"
F 8 "" H 3225 2375 50  0001 C CNN "Mouser"
F 9 "~" H 3225 2375 50  0001 C CNN "LCSC Part#"
F 10 "50V" H 3225 2375 50  0001 C CNN "Voltage"
	1    3225 2375
	-1   0    0    -1  
$EndComp
$Comp
L Device:CP C802
U 1 1 60283279
P 3725 2375
F 0 "C802" H 3825 2375 50  0000 L CNN
F 1 "100uF" H 3750 2275 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 3763 2225 50  0001 C CNN
F 3 "~" H 3725 2375 50  0001 C CNN
F 4 "0" H 3725 2375 50  0001 C CNN "DNP"
F 5 "" H 3725 2375 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-ALU-RAD-100UF-50V" H 3725 2375 50  0001 C CNN "MPN"
F 7 "CPL" H 3725 2375 50  0001 C CNN "Manufacturer"
F 8 "" H 3725 2375 50  0001 C CNN "Mouser"
F 9 "~" H 3725 2375 50  0001 C CNN "LCSC Part#"
F 10 "50V" H 3725 2375 50  0001 C CNN "Voltage"
	1    3725 2375
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0805
U 1 1 60283676
P 3225 2625
F 0 "#PWR0805" H 3225 2375 50  0001 C CNN
F 1 "GND" H 3230 2452 50  0000 C CNN
F 2 "" H 3225 2625 50  0001 C CNN
F 3 "" H 3225 2625 50  0001 C CNN
	1    3225 2625
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VP #PWR0810
U 1 1 5FF9B1CD
P 5425 3875
F 0 "#PWR0810" H 5575 3825 50  0001 C CNN
F 1 "+3.3VP" H 5440 4048 50  0000 C CNN
F 2 "" H 5425 3875 50  0001 C CNN
F 3 "" H 5425 3875 50  0001 C CNN
	1    5425 3875
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0808
U 1 1 606E29D3
P 4725 2700
F 0 "#PWR0808" H 4725 2450 50  0001 C CNN
F 1 "GND" H 4730 2527 50  0000 C CNN
F 2 "" H 4725 2700 50  0001 C CNN
F 3 "" H 4725 2700 50  0001 C CNN
	1    4725 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3625 2125 3725 2125
$Comp
L power:GND #PWR0806
U 1 1 6004335B
P 3725 2625
F 0 "#PWR0806" H 3725 2375 50  0001 C CNN
F 1 "GND" H 3730 2452 50  0000 C CNN
F 2 "" H 3725 2625 50  0001 C CNN
F 3 "" H 3725 2625 50  0001 C CNN
	1    3725 2625
	1    0    0    -1  
$EndComp
$Comp
L Connector:Jack-DC J801
U 1 1 606E29C8
P 2375 2225
F 0 "J801" H 2375 2525 50  0000 C CNN
F 1 "10nF" H 2375 2450 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-063AH_Horizontal" H 2425 2185 50  0001 C CNN
F 3 "~" H 2425 2185 50  0001 C CNN
F 4 "0" H 2375 2225 50  0001 C CNN "DNP"
F 5 "CP-063AH-ND" H 2375 2225 50  0001 C CNN "Digikey"
F 6 "PJ-063AH" H 2375 2225 50  0001 C CNN "MPN"
F 7 "CUI" H 2375 2225 50  0001 C CNN "Manufacturer"
F 8 "490-PJ-063AH" H 2375 2225 50  0001 C CNN "Mouser"
F 9 "~" H 2375 2225 50  0001 C CNN "LCSC Part#"
	1    2375 2225
	1    0    0    -1  
$EndComp
Wire Wire Line
	2675 2125 2825 2125
Wire Wire Line
	3125 2125 3225 2125
Wire Wire Line
	4375 2275 4100 2275
Wire Wire Line
	2675 2325 2775 2325
Wire Wire Line
	2775 2325 2775 2625
Wire Wire Line
	3225 2625 3225 2525
Wire Wire Line
	3225 2225 3225 2125
Connection ~ 3225 2125
Wire Wire Line
	3225 2125 3325 2125
Wire Wire Line
	3725 2625 3725 2525
Wire Wire Line
	3725 2225 3725 2125
Connection ~ 3725 2125
$Comp
L Neotron-Common-Hardware:K78(L)05-3AR3 U801
U 1 1 606E29D0
P 4725 1975
F 0 "U801" H 4725 2090 50  0000 C CNN
F 1 "DC-DC Module" H 4725 1999 50  0000 C CNN
F 2 "Neotron-Common-Hardware:K78xx-3AR3" H 4725 2225 50  0001 C CNN
F 3 "https://www.mornsun-power.com/html/pdf/K7805-3AR3.html" H 4725 1975 50  0001 C CNN
F 4 "Mornsun" H 4725 2325 50  0001 C CNN "Manufacturer"
F 5 "0" H 4725 1975 50  0001 C CNN "DNP"
F 6 "2725-K7805-3AR3-ND" H 4725 1975 50  0001 C CNN "Digikey"
F 7 "K7805-3AR3" H 4725 1975 50  0001 C CNN "MPN"
F 8 "~" H 4725 1975 50  0001 C CNN "LCSC Part#"
	1    4725 1975
	1    0    0    -1  
$EndComp
NoConn ~ 5075 2275
Wire Wire Line
	5075 2125 5275 2125
$Comp
L power:+3.3V #PWR0817
U 1 1 606E29C9
P 8075 3425
F 0 "#PWR0817" H 8075 3275 50  0001 C CNN
F 1 "+3.3V" H 8090 3598 50  0000 C CNN
F 2 "" H 8075 3425 50  0001 C CNN
F 3 "" H 8075 3425 50  0001 C CNN
	1    8075 3425
	1    0    0    -1  
$EndComp
Wire Wire Line
	8075 3425 8075 3525
Wire Wire Line
	8075 3525 7875 3525
Wire Wire Line
	5275 2700 5275 2525
Wire Wire Line
	5275 2225 5275 2125
Connection ~ 5275 2125
Wire Wire Line
	7525 4025 7525 3825
Wire Wire Line
	5275 2125 5850 2125
Wire Wire Line
	7175 3625 7175 3525
Wire Wire Line
	7175 3525 7225 3525
Wire Wire Line
	7175 4025 7175 3925
Wire Wire Line
	7875 4025 7875 3925
Wire Wire Line
	7875 3625 7875 3525
Connection ~ 7875 3525
Wire Wire Line
	7875 3525 7825 3525
Wire Wire Line
	4325 3875 4275 3875
Wire Wire Line
	4000 4525 4725 4525
Wire Wire Line
	4000 3875 4000 4125
Wire Wire Line
	4000 4425 4000 4525
Wire Wire Line
	4725 4275 4725 4525
Wire Wire Line
	4325 4075 4275 4075
Wire Wire Line
	4275 4075 4275 3875
Connection ~ 4275 3875
Wire Wire Line
	4275 3875 4000 3875
Wire Wire Line
	4725 4525 5225 4525
Wire Wire Line
	5125 4075 5225 4075
Wire Wire Line
	5225 4075 5225 4525
Connection ~ 5225 4525
Wire Wire Line
	5225 4525 5425 4525
Wire Wire Line
	5125 3875 5425 3875
Wire Wire Line
	4000 3875 4000 2125
Connection ~ 4000 3875
Connection ~ 4000 2125
$Comp
L Device:C C805
U 1 1 5FEE3B3C
P 5425 4275
F 0 "C805" H 5543 4321 50  0000 L CNN
F 1 "4.7uF" H 5543 4230 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5463 4125 50  0001 C CNN
F 3 "~" H 5425 4275 50  0001 C CNN
F 4 "0" H 5425 4275 50  0001 C CNN "DNP"
F 5 "" H 5425 4275 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-X5R-0805-4.7UF-25V" H 5425 4275 50  0001 C CNN "MPN"
F 7 "CPL" H 5425 4275 50  0001 C CNN "Manufacturer"
F 8 "C1779" H 5425 4275 50  0001 C CNN "LCSC Part#"
	1    5425 4275
	1    0    0    -1  
$EndComp
Wire Wire Line
	5425 3875 5425 4125
Wire Wire Line
	5425 4525 5425 4425
Connection ~ 5425 4525
Wire Wire Line
	6175 2025 6175 2125
$Comp
L power:+5V #PWR0813
U 1 1 60A3F499
P 6975 3425
F 0 "#PWR0813" H 6975 3275 50  0001 C CNN
F 1 "+5V" H 6990 3598 50  0000 C CNN
F 2 "" H 6975 3425 50  0001 C CNN
F 3 "" H 6975 3425 50  0001 C CNN
	1    6975 3425
	1    0    0    -1  
$EndComp
Wire Wire Line
	6975 3425 6975 3525
Wire Wire Line
	6975 3525 7175 3525
Connection ~ 7175 3525
Text HLabel 1325 5900 0    50   Input ~ 0
DC_ON
Text Notes 6575 2025 0    50   Italic 0
DC-DC Module is on when\nCtrl > 4.5V or open-circuit.\nIt is off when < 0.8V.
Wire Wire Line
	2575 6300 2575 6350
Wire Wire Line
	4725 2625 4725 2700
Connection ~ 5425 3875
Wire Wire Line
	2575 5750 2575 5925
Text Label 4375 2275 2    50   ~ 0
~SHDN
$Comp
L Transistor_BJT:BC546 Q801
U 1 1 607850D9
P 1925 5900
F 0 "Q801" H 2116 5946 50  0000 L CNN
F 1 "BC546" H 2116 5855 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2125 5825 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC550-D.pdf" H 1925 5900 50  0001 L CNN
F 4 "BC546CTACT-ND" H 1925 5900 50  0001 C CNN "Digikey"
F 5 "BC546CTA" H 1925 5900 50  0001 C CNN "MPN"
F 6 "ON Semiconductor" H 1925 5900 50  0001 C CNN "Manufacturer"
F 7 "0" H 1925 5900 50  0001 C CNN "DNP"
F 8 "~" H 1925 5900 50  0001 C CNN "LCSC Part#"
	1    1925 5900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0803
U 1 1 60786FC2
P 2575 6350
F 0 "#PWR0803" H 2575 6100 50  0001 C CNN
F 1 "GND" H 2580 6177 50  0000 C CNN
F 2 "" H 2575 6350 50  0001 C CNN
F 3 "" H 2575 6350 50  0001 C CNN
	1    2575 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2575 5925 2950 5925
Connection ~ 2575 5925
Wire Wire Line
	2575 5925 2575 6000
Text Label 2725 5925 0    50   ~ 0
~SHDN
Wire Wire Line
	1325 5900 1400 5900
Wire Wire Line
	1700 5900 1725 5900
Text Notes 1700 3550 0    100  Italic 0
DC Input rating:\n8V to 24V\n12V Nominal\nMax 2A
$Comp
L Transistor_BJT:BC556 Q802
U 1 1 60798177
P 2475 5550
F 0 "Q802" H 2666 5596 50  0000 L CNN
F 1 "BC556" H 2666 5505 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2675 5475 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC556BTA-D.pdf" H 2475 5550 50  0001 L CNN
F 4 "BC556BTF" H 2475 5550 50  0001 C CNN "MPN"
F 5 "BC556BTFCT-ND" H 2475 5550 50  0001 C CNN "Digikey"
F 6 "ON Semiconductor" H 2475 5550 50  0001 C CNN "Manufacturer"
F 7 "0" H 2475 5550 50  0001 C CNN "DNP"
F 8 "~" H 2475 5550 50  0001 C CNN "LCSC Part#"
	1    2475 5550
	1    0    0    1   
$EndComp
Wire Wire Line
	2275 5550 2025 5550
Wire Wire Line
	2025 5550 2025 5700
$Comp
L power:GND #PWR0801
U 1 1 6079CA8F
P 2025 6350
F 0 "#PWR0801" H 2025 6100 50  0001 C CNN
F 1 "GND" H 2030 6177 50  0000 C CNN
F 2 "" H 2025 6350 50  0001 C CNN
F 3 "" H 2025 6350 50  0001 C CNN
	1    2025 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2025 6100 2025 6350
Wire Wire Line
	2575 5350 2575 5050
Wire Wire Line
	2575 5050 2025 5050
Wire Wire Line
	2025 5050 2025 5150
Wire Wire Line
	2025 5450 2025 5550
Connection ~ 2575 5050
Wire Wire Line
	2575 5050 2575 4975
Connection ~ 2025 5550
$Comp
L Device:R R801
U 1 1 607A5326
P 1550 5900
F 0 "R801" V 1650 5900 50  0000 C CNN
F 1 "10k" V 1450 5900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 1480 5900 50  0001 C CNN
F 3 "~" H 1550 5900 50  0001 C CNN
F 4 "0" H 1550 5900 50  0001 C CNN "DNP"
F 5 "" H 1550 5900 50  0001 C CNN "Digikey"
F 6 "CPL-RES-0805-10K-0.125W" H 1550 5900 50  0001 C CNN "MPN"
F 7 "CPL" H 1550 5900 50  0001 C CNN "Manufacturer"
F 8 "C17414" H 1550 5900 50  0001 C CNN "LCSC Part#"
	1    1550 5900
	0    1    -1   0   
$EndComp
Text Notes 2800 6500 0    50   Italic 0
~SHDN~ must be low at power-up\nto avoid DC-DC enabling temporarily.\n\n~SHDN~ raised to +VDC when DC_ON\nis high enough to switch on Q801\n(above about 0.7V). 3.3V is plenty.
$Comp
L Device:R R802
U 1 1 607A18C2
P 2025 5300
F 0 "R802" H 2075 5350 50  0000 L CNN
F 1 "10k" H 2075 5275 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 1955 5300 50  0001 C CNN
F 3 "~" H 2025 5300 50  0001 C CNN
F 4 "0" H 2025 5300 50  0001 C CNN "DNP"
F 5 "" H 2025 5300 50  0001 C CNN "Digikey"
F 6 "CPL-RES-0805-10K-0.125W" H 2025 5300 50  0001 C CNN "MPN"
F 7 "CPL" H 2025 5300 50  0001 C CNN "Manufacturer"
F 8 "C17414" H 2025 5300 50  0001 C CNN "LCSC Part#"
	1    2025 5300
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R803
U 1 1 606E2A14
P 2575 6150
F 0 "R803" H 2625 6200 50  0000 L CNN
F 1 "10k" H 2625 6100 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 2505 6150 50  0001 C CNN
F 3 "~" H 2575 6150 50  0001 C CNN
F 4 "0" H 2575 6150 50  0001 C CNN "DNP"
F 5 "" H 2575 6150 50  0001 C CNN "Digikey"
F 6 "CPL-RES-0805-10K-0.125W" H 2575 6150 50  0001 C CNN "MPN"
F 7 "CPL" H 2575 6150 50  0001 C CNN "Manufacturer"
F 8 "C17414" H 2575 6150 50  0001 C CNN "LCSC Part#"
	1    2575 6150
	-1   0    0    -1  
$EndComp
$Comp
L power:VDC #PWR0807
U 1 1 606FD8EC
P 3850 2125
F 0 "#PWR0807" H 3850 2025 50  0001 C CNN
F 1 "VDC" H 3865 2298 50  0000 C CNN
F 2 "" H 3850 2125 50  0001 C CNN
F 3 "" H 3850 2125 50  0001 C CNN
	1    3850 2125
	1    0    0    -1  
$EndComp
Wire Wire Line
	3725 2125 3850 2125
Connection ~ 3850 2125
Wire Wire Line
	3850 2125 4000 2125
$Comp
L power:VDC #PWR0802
U 1 1 606FDFCB
P 2575 4975
F 0 "#PWR0802" H 2575 4875 50  0001 C CNN
F 1 "VDC" H 2590 5148 50  0000 C CNN
F 2 "" H 2575 4975 50  0001 C CNN
F 3 "" H 2575 4975 50  0001 C CNN
	1    2575 4975
	1    0    0    -1  
$EndComp
Wire Wire Line
	4175 2125 4375 2125
Wire Wire Line
	4000 2125 4175 2125
Connection ~ 4175 2125
$Comp
L power:PWR_FLAG #FLG0801
U 1 1 606FBD37
P 4175 2125
F 0 "#FLG0801" H 4175 2200 50  0001 C CNN
F 1 "PWR_FLAG" H 4175 2298 50  0000 C CNN
F 2 "" H 4175 2125 50  0001 C CNN
F 3 "~" H 4175 2125 50  0001 C CNN
	1    4175 2125
	1    0    0    -1  
$EndComp
$Comp
L Device:C C808
U 1 1 60E7E52A
P 5850 2375
F 0 "C808" H 5968 2421 50  0000 L CNN
F 1 "10uF" H 5968 2330 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5888 2225 50  0001 C CNN
F 3 "~" H 5850 2375 50  0001 C CNN
F 4 "0" H 5850 2375 50  0001 C CNN "DNP"
F 5 "" H 5850 2375 50  0001 C CNN "Digikey"
F 6 "CPL-CAP-X5R-0805-10UF-16V" H 5850 2375 50  0001 C CNN "MPN"
F 7 "CPL" H 5850 2375 50  0001 C CNN "Manufacturer"
F 8 "C15850" H 5850 2375 50  0001 C CNN "LCSC Part#"
	1    5850 2375
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 60E86C1C
P 5850 2700
F 0 "#PWR01" H 5850 2450 50  0001 C CNN
F 1 "GND" H 5855 2527 50  0000 C CNN
F 2 "" H 5850 2700 50  0001 C CNN
F 3 "" H 5850 2700 50  0001 C CNN
	1    5850 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 2700 5850 2525
Wire Wire Line
	5850 2225 5850 2125
Connection ~ 5850 2125
Wire Wire Line
	5850 2125 6175 2125
$EndSCHEMATC
