module my_clock(
	input clk,
	input stop,
	input sw,
	input starp,
	input clr,
	input alarm,
	input adjust_h,
	input adjust_m,
	input adjust_s,
	output [6:0]hour1,
	output [6:0]hour2,
	output [6:0]minute1,
	output [6:0]minute2,
	output [6:0]second1,
	output [6:0]second2,
	output bell
);

wire [4:0]hour;wire [5:0]minute;wire [5:0]second;
wire [4:0]hour_sw;wire [5:0]minute_sw;wire [5:0]second_sw;
wire [4:0]hour_al;wire [5:0]minute_al;wire [5:0]second_al;
wire [4:0]hour_display;wire [5:0]minute_display;wire [5:0]second_display;
//wire second_carry;wire minute_carry;wire hour_carry;
wire signal;

divider#(1) d(clk,signal);

//normal move or adjust time
move m(signal,stop,~adjust_h,~adjust_m,~adjust_s,hour,minute,second);

//second watch
second_watch s(sw,signal,starp,clr,hour_sw,minute_sw,second_sw);

//set_alarm
set_time st(alarm,signal,~adjust_h,~adjust_m,~adjust_s,hour_al,minute_al,second_al);

//decide whether alarm bell is ringing
is_equal ie(signal,hour,minute,hour_al,minute_al,bell);

//choose h.m.s to display
chos_display show(signal,sw,alarm,hour,minute,second,hour_sw,minute_sw,second_sw,hour_al,minute_al,second_al,
hour_display,minute_display,second_display);

trsltr t1(.number(hour_display % 10),.s(hour2));
trsltr t2(.number(hour_display / 10),.s(hour1));
trsltr t3(.number(minute_display % 10),.s(minute2));
trsltr t4(.number(minute_display / 10),.s(minute1));
trsltr t5(.number(second_display % 10),.s(second2));
trsltr t6(.number(second_display / 10),.s(second1));

endmodule 