onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/dut/clk
add wave -noupdate /testbench/dut/reset
add wave -noupdate -group DP -radix hexadecimal -radixshowbase 0 /testbench/dut/DataAdr
add wave -noupdate -group DP /testbench/dut/WriteData
add wave -noupdate -group DP /testbench/dut/MemWrite
add wave -noupdate -group DP -radix unsigned -radixshowbase 0 /testbench/dut/PC
add wave -noupdate -group DP -childformat {{{/testbench/dut/arm/dp/rf/rf[14]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[13]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[12]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[11]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[10]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[9]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[8]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[7]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[6]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[5]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[4]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[3]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[2]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[1]} -radix decimal} {{/testbench/dut/arm/dp/rf/rf[0]} -radix decimal}} -subitemconfig {{/testbench/dut/arm/dp/rf/rf[14]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[13]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[12]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[11]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[10]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[9]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[8]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[7]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[6]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[5]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[4]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[3]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[2]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[1]} {-height 17 -radix decimal} {/testbench/dut/arm/dp/rf/rf[0]} {-height 17 -radix decimal}} /testbench/dut/arm/dp/rf/rf
add wave -noupdate -group DP /testbench/dut/arm/dp/Instr
add wave -noupdate -group DP /testbench/dut/arm/dp/RegWrite
add wave -noupdate -group DP /testbench/dut/arm/c/cl/flagreg1/q
add wave -noupdate -group DP /testbench/dut/arm/c/cl/flagreg0/q
add wave -noupdate -group DP /testbench/dut/arm/c/cl/flagreg0/en
add wave -noupdate -group DP /testbench/dut/arm/c/dec/Branch
add wave -noupdate -group DP /testbench/dut/arm/c/dec/PCS
add wave -noupdate -group DP /testbench/dut/arm/c/PCSrc
add wave -noupdate /testbench/dut/arm/dp/alu/ALUControl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {147 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {128 ns} {275 ns}
