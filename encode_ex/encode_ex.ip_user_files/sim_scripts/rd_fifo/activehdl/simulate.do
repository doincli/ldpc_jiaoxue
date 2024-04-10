onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+rd_fifo -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.rd_fifo xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {rd_fifo.udo}

run -all

endsim

quit -force