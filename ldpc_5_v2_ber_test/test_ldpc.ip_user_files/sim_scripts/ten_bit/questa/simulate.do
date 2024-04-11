onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ten_bit_opt

do {wave.do}

view wave
view structure
view signals

do {ten_bit.udo}

run -all

quit -force
