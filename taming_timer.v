module taming_timer(
	input clk_in, // 10Mhz clk in, 100ns clk
	input clk_correct, // Taming Signal
	input [31:0]epoch_set_dat,
	input epoch_set,
	input reset,
	output reg[31:0]epoch,
	output reg[23:0]ns_cnt,
	output reg lock
);

//reg [23:0]ns_cnt;
parameter MAX_SEC = 110;
parameter MIN_SEC = 90;
parameter DELTA = 20;
parameter HALF_DELTA = 10;

always @(posedge clk_in or posedge clk_correct or posedge reset)
if (reset) begin
	epoch <= 32'b0;
	ns_cnt <= 24'b0;
	lock <=  1'b0;
end else if(clk_correct) begin 
	if (ns_cnt > MIN_SEC && ns_cnt < MAX_SEC) begin 
		ns_cnt <= 0;
		lock <= 1;
		epoch <= epoch + 32'b1;
	end else if (ns_cnt < DELTA) begin
		epoch <= epoch;
		lock <= 1;
	end else begin 
		epoch <= epoch + 10;
		lock <= 0;
		ns_cnt <=  ns_cnt + HALF_DELTA; 
	end	
end else if (clk_in) begin
	ns_cnt <= ns_cnt + 1;
	if(ns_cnt >= MAX_SEC && lock == 0) begin 
		lock <= 1'b0;
		ns_cnt <= HALF_DELTA ;
		epoch <= epoch + 1;
	end 

end 


endmodule

module taming_timer_testbench;
	
	parameter delay = 500;
	parameter second = 64'd100000;
	reg clk_in;
	reg tame_corection;
	reg reset;
	wire [31:0]epoch_out;
	wire lock_out;
	wire [23:0]ns_out;
	taming_timer DUT(
	clk_in,
	tame_corection,
	32'b0,
	0,
	reset,
	epoch_out,
	ns_out,
	lock_out
	);
	
	initial begin 
		reset = 1;
		#(2000)reset = 0;
		clk_in = 0;
		tame_corection = 0;
	end
	
	always 
		#(delay)clk_in = ~clk_in; 
		
	always begin
		#(second)tame_corection = ~tame_corection;
		#(100) tame_corection = ~tame_corection;
	end
endmodule	