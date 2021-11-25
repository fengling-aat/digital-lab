/*
 * 以此作为顶层模块，全部依据本模块进行链接
 * 将所有的其余组件尽量的放在各个文件中，便于维护和完善
 * MyClock  ->  Top level
 */

module MyClock(
	input CLK_50, 
	input reset_en,
	input run_en,

	input ps2_clk,
	input ps2_data,
	
	//output wire test_clk//用于测试输出，输出一个每秒频闪的LED作为测试
	output wire clock_clk,
	output wire set_time_en, // 用于进行时间设定的使能端
	output wire set_alarm_en, // 同理
	output wire DONE, // D的敲击显示
	output wire key_trans_en,
	output wire AlarmLED, // 用于测试输出Alarm信息

	output wire [3:0] LEDR, // 这个标准的四个输出是给移植而来的音频实验使用的，个人毫无意义
	//output wire [7:0] ASCII_show, // 用于DEBUG，马上就会删除
	output wire LAST,
	// 这是最后一个LED测试开关了

	output wire [41:0] all_HEX,   //此处是所有需要输出的七段数码管的信息
								 //便于使用所以没有进行区分0~5号HEX
								 /*
								  * [6:0]
								  * [13:7]
								  * [20:14]
								  * [27:21]
								  * [34:28]
								  * [41:35]
								  * 分割如上
								  */

	//output wire keyboard_ready

	inout 		          		AUD_BCLK,
	output		          		AUD_DACDAT,
	inout 		          		AUD_DACLRCK,
	output		          		AUD_XCK, // 音频实验所需要的大量引脚

	output		          		FPGA_I2C_SCLK,
	inout 		          		FPGA_I2C_SDAT,


	// VGA部分
	output hsync, // 行同步和列同步信号
	output vsync,
	output valid, // 消隐信号
	
	output vga_clk,
	
	output sync_n,
	
	output [7:0] vga_r, // 红绿蓝颜色信号
	output [7:0] vga_g,
	output [7:0] vga_b//都更改为4bits表示

	);

	wire [5:0] clock_hour;
	wire [5:0] clock_minute;
	wire [5:0] clock_second;
	//需要用来传递时间的wire变量

	wire [5:0] hour_trans;
	wire [5:0] minute_trans;
	wire [5:0] second_trans;
	// 用于传递时间的参数，不仅仅是时间设定的，还可以是闹钟设定的

	initial
	begin
		//old_clock = 1'b0;
	end
	
//分频器，输出1s的时钟信号
FrequencyDivision change_clk50_to_one_second(run_en,CLK_50,clock_clk);
	
//主要的时钟行走模块
ClockRun MainClock(clock_clk,clock_hour,clock_minute,clock_second,
    set_time_en,hour_trans,minute_trans,second_trans);

//7段数码管显示时间
TimeShow HEXShowTime(clock_hour,clock_minute,clock_second,
    hour_trans,minute_trans,second_trans,set_time_en,set_alarm_en,all_HEX);

//键盘输入时间
KeyTimeGet GetTime(ps2_clk,ps2_data,CLK_50,set_alarm_en,key_trans_en,
hour_trans,minute_trans,second_trans,DONE);

//闹钟和整点报时
AlarmRun Alarm(hour_trans,minute_trans,second_trans,clock_hour,clock_minute,clock_second,
set_alarm_en,clock_clk,CLK_50,LEDR,AlarmLED,
AUD_BCLK,AUD_DACDAT,AUD_DACLRCK,AUD_XCK,FPGA_I2C_SCLK,FPGA_I2C_SDAT);

//绘制表盘
ClockDrawing VGADrawing(clock_hour,clock_minute,clock_second,
CLK_50,1'b0,1'b0,hsync,vsync,valid,sync_n,vga_clk,vga_r,vga_g,vga_b,LAST);

endmodule
