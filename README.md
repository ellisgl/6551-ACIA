# 6551-ACIA
Verilog MOS 6551 Implementation. This is not a implentation of the MOS 65C51N, which has the infamous "Transmitter Data Register Empty" status register bug. So, no having to use delays, you can just check the statuses, which will make communications a lot faster. 

Since I creatively borrowed this code from https://github.com/hoglet67/65c02_errata, I made one major change. The buad rate generation is flexiable now, so using a 1.928571 Mhz (instead of 1 Mhz or a 1.8432Mhz clock) won't be a problem.

## Testbench
```BASH
iverilog -o tb_ACIA.vvp tb/tb_ACIA.v rtl/acia.v rtl/acia_rx.v rtl/acia_tx.v rtl/acia_brgen.v 
Vvp tb_ACIA.vvp
```
