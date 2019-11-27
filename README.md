**Maintain a FPGA project with Git is purely pain in ass**
**But I am still going to do it**

# Gps *PulsePerSec* Pulse Tamed Timer

## Usage
Basically, a taming_timing.v file contains the implement and benchmark of GTT, include it into your project and provide the
clk and input signal:

+ GPS PPS pulse shall be feed to clk correct,
+ A 10M input clock shall be feed to clk in.

If the PPS pulse actual comes at 1Hz(But normally it is not)
and clk is corrct:

+ the output time giving by epoch[31:0] port will increase as PPS comes.

+ The lock port will show if the internal counter is sync to PPS.

epoch set & reset port are not fully functioned right now, 
I'm still working on it

## Still Under Construction

<!--TODO->
