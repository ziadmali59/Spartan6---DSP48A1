
add wave -position insertpoint sim:/DSP_Top/*
force -freeze sim:/DSP_Top/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/DSP_Top/RSTA 1 0
force -freeze sim:/DSP_Top/RSTB 1 0
force -freeze sim:/DSP_Top/RSTM 1 0
force -freeze sim:/DSP_Top/RSTP 1 0
force -freeze sim:/DSP_Top/RSTC 1 0
force -freeze sim:/DSP_Top/RSTD 1 0
force -freeze sim:/DSP_Top/RSTCARRYIN 1 0
force -freeze sim:/DSP_Top/RSTOPMODE 1 0
force -freeze sim:/DSP_Top/CEA 1 0
force -freeze sim:/DSP_Top/CEB 1 0
force -freeze sim:/DSP_Top/CEC 1 0
force -freeze sim:/DSP_Top/CED 1 0
force -freeze sim:/DSP_Top/CEM 1 0
force -freeze sim:/DSP_Top/CEP 1 0
force -freeze sim:/DSP_Top/CECARRYIN 1 0
force -freeze sim:/DSP_Top/CEOPMODE 1 0
run

force -freeze sim:/DSP_Top/RSTA 0 0
force -freeze sim:/DSP_Top/RSTB 0 0
force -freeze sim:/DSP_Top/RSTM 0 0
force -freeze sim:/DSP_Top/RSTP 0 0
force -freeze sim:/DSP_Top/RSTC 0 0
force -freeze sim:/DSP_Top/RSTD 0 0
force -freeze sim:/DSP_Top/RSTCARRYIN 0 0
force -freeze sim:/DSP_Top/RSTOPMODE 0 0
run
force -freeze sim:/DSP_Top/BCIN 'h3 0
force -freeze sim:/DSP_Top/D 'h5 0
force -freeze sim:/DSP_Top/A 'h2 0
force -freeze sim:/DSP_Top/B 'h4 0

force -freeze sim:/DSP_Top/opmode 0 0
force -freeze sim:/DSP_Top/CARRYIN 1 0;
force -freeze sim:/DSP_Top/BCIN 'h3 0
force -freeze sim:/DSP_Top/PCIN 10 0 
run
force -freeze sim:/DSP_Top/opmode 00000101 0
run
force -freeze sim:/DSP_Top/opmode 0010_1101 0
run

force -freeze sim:/DSP_Top/opmode 0011_1101 0
run
force -freeze sim:/DSP_Top/opmode 0011_0001 0
force -freeze sim:/DSP_Top/CARRYIN 0 0;
run


force -freeze sim:/DSP_Top/opmode 0101_0101 0
run
force -freeze sim:/DSP_Top/opmode 0 0
run


force -freeze sim:/DSP_Top/opmode 1101_0101 0
run
force -freeze sim:/DSP_Top/opmode 1111_0101 0
run



force -freeze sim:/DSP_Top/opmode 0111_0101 0
run
force -freeze sim:/DSP_Top/opmode 0010_0010 0
run


force -freeze sim:/DSP_Top/opmode 0010_0011 0
run
force -freeze sim:/DSP_Top/opmode 0010_0100 0
run





force -freeze sim:/DSP_Top/opmode 0010_1001 0
run
force -freeze sim:/DSP_Top/opmode 0010_1010 0
run


force -freeze sim:/DSP_Top/opmode 0010_1111 0
run