onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+wr_fifo -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.wr_fifo xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {wr_fifo.udo}

run -all

endsim

quit -force
