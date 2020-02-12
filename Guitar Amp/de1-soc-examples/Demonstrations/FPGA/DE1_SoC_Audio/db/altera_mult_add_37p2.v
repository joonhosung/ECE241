//altera_mult_add ADDNSUB_MULTIPLIER_PIPELINE_ACLR1="ACLR0" ADDNSUB_MULTIPLIER_PIPELINE_REGISTER1="CLOCK0" ADDNSUB_MULTIPLIER_REGISTER1="UNREGISTERED" CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEDICATED_MULTIPLIER_CIRCUITRY="YES" DEVICE_FAMILY="Cyclone V" DSP_BLOCK_BALANCING="Auto" INPUT_REGISTER_A0="UNREGISTERED" INPUT_REGISTER_B0="UNREGISTERED" INPUT_SOURCE_A0="DATAA" INPUT_SOURCE_B0="DATAB" MULTIPLIER1_DIRECTION="ADD" MULTIPLIER_ACLR0="ACLR0" MULTIPLIER_REGISTER0="CLOCK0" NUMBER_OF_MULTIPLIERS=1 OUTPUT_REGISTER="UNREGISTERED" port_addnsub1="PORT_UNUSED" port_addnsub3="PORT_UNUSED" REPRESENTATION_A="UNSIGNED" REPRESENTATION_B="UNSIGNED" SELECTED_DEVICE_FAMILY="CYCLONEV" SIGNED_PIPELINE_ACLR_A="ACLR0" SIGNED_PIPELINE_ACLR_B="ACLR0" SIGNED_PIPELINE_REGISTER_A="CLOCK0" SIGNED_PIPELINE_REGISTER_B="CLOCK0" SIGNED_REGISTER_A="UNREGISTERED" SIGNED_REGISTER_B="UNREGISTERED" WIDTH_A=16 WIDTH_B=16 WIDTH_RESULT=32 aclr0 clock0 dataa datab ena0 result
//VERSION_BEGIN 18.0 cbx_altera_mult_add 2018:04:24:18:04:18:SJ cbx_altera_mult_add_rtl 2018:04:24:18:04:18:SJ cbx_mgl 2018:04:24:18:08:49:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2018  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details.



//synthesis_resources = altera_mult_add_rtl 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  altera_mult_add_37p2
	( 
	aclr0,
	clock0,
	dataa,
	datab,
	ena0,
	result) /* synthesis synthesis_clearbox=1 */;
	input   aclr0;
	input   clock0;
	input   [15:0]  dataa;
	input   [15:0]  datab;
	input   ena0;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr0;
	tri1   clock0;
	tri0   [15:0]  dataa;
	tri0   [15:0]  datab;
	tri1   ena0;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [31:0]   wire_altera_mult_add_rtl1_result;

	altera_mult_add_rtl   altera_mult_add_rtl1
	( 
	.aclr0(aclr0),
	.chainout_sat_overflow(),
	.clock0(clock0),
	.dataa(dataa),
	.datab(datab),
	.ena0(ena0),
	.mult0_is_saturated(),
	.mult1_is_saturated(),
	.mult2_is_saturated(),
	.mult3_is_saturated(),
	.overflow(),
	.result(wire_altera_mult_add_rtl1_result),
	.scanouta(),
	.scanoutb(),
	.accum_sload(1'b0),
	.aclr1(1'b0),
	.aclr2(1'b0),
	.aclr3(1'b0),
	.addnsub1(1'b1),
	.addnsub1_round(1'b0),
	.addnsub3(1'b1),
	.addnsub3_round(1'b0),
	.chainin({1{1'b0}}),
	.chainout_round(1'b0),
	.chainout_saturate(1'b0),
	.clock1(1'b1),
	.clock2(1'b1),
	.clock3(1'b1),
	.coefsel0({3{1'b0}}),
	.coefsel1({3{1'b0}}),
	.coefsel2({3{1'b0}}),
	.coefsel3({3{1'b0}}),
	.datac({22{1'b0}}),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.mult01_round(1'b0),
	.mult01_saturation(1'b0),
	.mult23_round(1'b0),
	.mult23_saturation(1'b0),
	.negate(1'b0),
	.output_round(1'b0),
	.output_saturate(1'b0),
	.rotate(1'b0),
	.scanina({16{1'b0}}),
	.scaninb({16{1'b0}}),
	.sclr0(1'b0),
	.sclr1(1'b0),
	.sclr2(1'b0),
	.sclr3(1'b0),
	.shift_right(1'b0),
	.signa(1'b0),
	.signb(1'b0),
	.sload_accum(1'b0),
	.sourcea({1{1'b0}}),
	.sourceb({1{1'b0}}),
	.zero_chainout(1'b0),
	.zero_loopback(1'b0)
	);
	defparam
		altera_mult_add_rtl1.accum_direction = "ADD",
		altera_mult_add_rtl1.accum_sload_aclr = "NONE",
		altera_mult_add_rtl1.accum_sload_latency_aclr = "NONE",
		altera_mult_add_rtl1.accum_sload_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.accum_sload_latency_sclr = "NONE",
		altera_mult_add_rtl1.accum_sload_register = "UNREGISTERED",
		altera_mult_add_rtl1.accum_sload_sclr = "NONE",
		altera_mult_add_rtl1.accumulator = "NO",
		altera_mult_add_rtl1.adder1_rounding = "NO",
		altera_mult_add_rtl1.adder3_rounding = "NO",
		altera_mult_add_rtl1.addnsub1_round_aclr = "NONE",
		altera_mult_add_rtl1.addnsub1_round_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.addnsub1_round_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub1_round_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.addnsub1_round_register = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub1_round_sclr = "NONE",
		altera_mult_add_rtl1.addnsub3_round_aclr = "NONE",
		altera_mult_add_rtl1.addnsub3_round_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.addnsub3_round_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub3_round_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.addnsub3_round_register = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub3_round_sclr = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_aclr1 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_aclr3 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_latency_aclr1 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_latency_aclr3 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_latency_clock1 = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub_multiplier_latency_clock3 = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub_multiplier_latency_sclr1 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_latency_sclr3 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_register1 = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub_multiplier_register3 = "UNREGISTERED",
		altera_mult_add_rtl1.addnsub_multiplier_sclr1 = "NONE",
		altera_mult_add_rtl1.addnsub_multiplier_sclr3 = "NONE",
		altera_mult_add_rtl1.chainout_aclr = "NONE",
		altera_mult_add_rtl1.chainout_adder = "NO",
		altera_mult_add_rtl1.chainout_adder_direction = "ADD",
		altera_mult_add_rtl1.chainout_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_round_aclr = "NONE",
		altera_mult_add_rtl1.chainout_round_output_aclr = "NONE",
		altera_mult_add_rtl1.chainout_round_output_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_round_output_sclr = "NONE",
		altera_mult_add_rtl1.chainout_round_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.chainout_round_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_round_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.chainout_round_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_round_sclr = "NONE",
		altera_mult_add_rtl1.chainout_rounding = "NO",
		altera_mult_add_rtl1.chainout_saturate_aclr = "NONE",
		altera_mult_add_rtl1.chainout_saturate_output_aclr = "NONE",
		altera_mult_add_rtl1.chainout_saturate_output_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_saturate_output_sclr = "NONE",
		altera_mult_add_rtl1.chainout_saturate_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.chainout_saturate_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_saturate_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.chainout_saturate_register = "UNREGISTERED",
		altera_mult_add_rtl1.chainout_saturate_sclr = "NONE",
		altera_mult_add_rtl1.chainout_saturation = "NO",
		altera_mult_add_rtl1.chainout_sclr = "NONE",
		altera_mult_add_rtl1.coef0_0 = 0,
		altera_mult_add_rtl1.coef0_1 = 0,
		altera_mult_add_rtl1.coef0_2 = 0,
		altera_mult_add_rtl1.coef0_3 = 0,
		altera_mult_add_rtl1.coef0_4 = 0,
		altera_mult_add_rtl1.coef0_5 = 0,
		altera_mult_add_rtl1.coef0_6 = 0,
		altera_mult_add_rtl1.coef0_7 = 0,
		altera_mult_add_rtl1.coef1_0 = 0,
		altera_mult_add_rtl1.coef1_1 = 0,
		altera_mult_add_rtl1.coef1_2 = 0,
		altera_mult_add_rtl1.coef1_3 = 0,
		altera_mult_add_rtl1.coef1_4 = 0,
		altera_mult_add_rtl1.coef1_5 = 0,
		altera_mult_add_rtl1.coef1_6 = 0,
		altera_mult_add_rtl1.coef1_7 = 0,
		altera_mult_add_rtl1.coef2_0 = 0,
		altera_mult_add_rtl1.coef2_1 = 0,
		altera_mult_add_rtl1.coef2_2 = 0,
		altera_mult_add_rtl1.coef2_3 = 0,
		altera_mult_add_rtl1.coef2_4 = 0,
		altera_mult_add_rtl1.coef2_5 = 0,
		altera_mult_add_rtl1.coef2_6 = 0,
		altera_mult_add_rtl1.coef2_7 = 0,
		altera_mult_add_rtl1.coef3_0 = 0,
		altera_mult_add_rtl1.coef3_1 = 0,
		altera_mult_add_rtl1.coef3_2 = 0,
		altera_mult_add_rtl1.coef3_3 = 0,
		altera_mult_add_rtl1.coef3_4 = 0,
		altera_mult_add_rtl1.coef3_5 = 0,
		altera_mult_add_rtl1.coef3_6 = 0,
		altera_mult_add_rtl1.coef3_7 = 0,
		altera_mult_add_rtl1.coefsel0_aclr = "NONE",
		altera_mult_add_rtl1.coefsel0_latency_aclr = "NONE",
		altera_mult_add_rtl1.coefsel0_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel0_latency_sclr = "NONE",
		altera_mult_add_rtl1.coefsel0_register = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel0_sclr = "NONE",
		altera_mult_add_rtl1.coefsel1_aclr = "NONE",
		altera_mult_add_rtl1.coefsel1_latency_aclr = "NONE",
		altera_mult_add_rtl1.coefsel1_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel1_latency_sclr = "NONE",
		altera_mult_add_rtl1.coefsel1_register = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel1_sclr = "NONE",
		altera_mult_add_rtl1.coefsel2_aclr = "NONE",
		altera_mult_add_rtl1.coefsel2_latency_aclr = "NONE",
		altera_mult_add_rtl1.coefsel2_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel2_latency_sclr = "NONE",
		altera_mult_add_rtl1.coefsel2_register = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel2_sclr = "NONE",
		altera_mult_add_rtl1.coefsel3_aclr = "NONE",
		altera_mult_add_rtl1.coefsel3_latency_aclr = "NONE",
		altera_mult_add_rtl1.coefsel3_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel3_latency_sclr = "NONE",
		altera_mult_add_rtl1.coefsel3_register = "UNREGISTERED",
		altera_mult_add_rtl1.coefsel3_sclr = "NONE",
		altera_mult_add_rtl1.dedicated_multiplier_circuitry = "YES",
		altera_mult_add_rtl1.double_accum = "NO",
		altera_mult_add_rtl1.dsp_block_balancing = "Auto",
		altera_mult_add_rtl1.extra_latency = 0,
		altera_mult_add_rtl1.input_a0_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_a0_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_a0_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_a1_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_a1_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_a1_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_a2_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_a2_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_a2_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_a3_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_a3_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_a3_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_aclr_a0 = "NONE",
		altera_mult_add_rtl1.input_aclr_a1 = "NONE",
		altera_mult_add_rtl1.input_aclr_a2 = "NONE",
		altera_mult_add_rtl1.input_aclr_a3 = "NONE",
		altera_mult_add_rtl1.input_aclr_b0 = "NONE",
		altera_mult_add_rtl1.input_aclr_b1 = "NONE",
		altera_mult_add_rtl1.input_aclr_b2 = "NONE",
		altera_mult_add_rtl1.input_aclr_b3 = "NONE",
		altera_mult_add_rtl1.input_aclr_c0 = "NONE",
		altera_mult_add_rtl1.input_aclr_c1 = "NONE",
		altera_mult_add_rtl1.input_aclr_c2 = "NONE",
		altera_mult_add_rtl1.input_aclr_c3 = "NONE",
		altera_mult_add_rtl1.input_b0_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_b0_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_b0_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_b1_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_b1_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_b1_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_b2_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_b2_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_b2_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_b3_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_b3_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_b3_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_c0_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_c0_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_c0_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_c1_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_c1_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_c1_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_c2_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_c2_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_c2_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_c3_latency_aclr = "NONE",
		altera_mult_add_rtl1.input_c3_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.input_c3_latency_sclr = "NONE",
		altera_mult_add_rtl1.input_register_a0 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_a1 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_a2 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_a3 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_b0 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_b1 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_b2 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_b3 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_c0 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_c1 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_c2 = "UNREGISTERED",
		altera_mult_add_rtl1.input_register_c3 = "UNREGISTERED",
		altera_mult_add_rtl1.input_sclr_a0 = "NONE",
		altera_mult_add_rtl1.input_sclr_a1 = "NONE",
		altera_mult_add_rtl1.input_sclr_a2 = "NONE",
		altera_mult_add_rtl1.input_sclr_a3 = "NONE",
		altera_mult_add_rtl1.input_sclr_b0 = "NONE",
		altera_mult_add_rtl1.input_sclr_b1 = "NONE",
		altera_mult_add_rtl1.input_sclr_b2 = "NONE",
		altera_mult_add_rtl1.input_sclr_b3 = "NONE",
		altera_mult_add_rtl1.input_sclr_c0 = "NONE",
		altera_mult_add_rtl1.input_sclr_c1 = "NONE",
		altera_mult_add_rtl1.input_sclr_c2 = "NONE",
		altera_mult_add_rtl1.input_sclr_c3 = "NONE",
		altera_mult_add_rtl1.input_source_a0 = "DATAA",
		altera_mult_add_rtl1.input_source_a1 = "DATAA",
		altera_mult_add_rtl1.input_source_a2 = "DATAA",
		altera_mult_add_rtl1.input_source_a3 = "DATAA",
		altera_mult_add_rtl1.input_source_b0 = "DATAB",
		altera_mult_add_rtl1.input_source_b1 = "DATAB",
		altera_mult_add_rtl1.input_source_b2 = "DATAB",
		altera_mult_add_rtl1.input_source_b3 = "DATAB",
		altera_mult_add_rtl1.latency = 0,
		altera_mult_add_rtl1.loadconst_control_aclr = "NONE",
		altera_mult_add_rtl1.loadconst_control_register = "UNREGISTERED",
		altera_mult_add_rtl1.loadconst_control_sclr = "NONE",
		altera_mult_add_rtl1.loadconst_value = 64,
		altera_mult_add_rtl1.mult01_round_aclr = "NONE",
		altera_mult_add_rtl1.mult01_round_register = "UNREGISTERED",
		altera_mult_add_rtl1.mult01_round_sclr = "NONE",
		altera_mult_add_rtl1.mult01_saturation_aclr = "ACLR0",
		altera_mult_add_rtl1.mult01_saturation_register = "UNREGISTERED",
		altera_mult_add_rtl1.mult01_saturation_sclr = "ACLR0",
		altera_mult_add_rtl1.mult23_round_aclr = "NONE",
		altera_mult_add_rtl1.mult23_round_register = "UNREGISTERED",
		altera_mult_add_rtl1.mult23_round_sclr = "NONE",
		altera_mult_add_rtl1.mult23_saturation_aclr = "NONE",
		altera_mult_add_rtl1.mult23_saturation_register = "UNREGISTERED",
		altera_mult_add_rtl1.mult23_saturation_sclr = "NONE",
		altera_mult_add_rtl1.multiplier01_rounding = "NO",
		altera_mult_add_rtl1.multiplier01_saturation = "NO",
		altera_mult_add_rtl1.multiplier1_direction = "ADD",
		altera_mult_add_rtl1.multiplier23_rounding = "NO",
		altera_mult_add_rtl1.multiplier23_saturation = "NO",
		altera_mult_add_rtl1.multiplier3_direction = "ADD",
		altera_mult_add_rtl1.multiplier_aclr0 = "ACLR0",
		altera_mult_add_rtl1.multiplier_aclr1 = "NONE",
		altera_mult_add_rtl1.multiplier_aclr2 = "NONE",
		altera_mult_add_rtl1.multiplier_aclr3 = "NONE",
		altera_mult_add_rtl1.multiplier_register0 = "CLOCK0",
		altera_mult_add_rtl1.multiplier_register1 = "UNREGISTERED",
		altera_mult_add_rtl1.multiplier_register2 = "UNREGISTERED",
		altera_mult_add_rtl1.multiplier_register3 = "UNREGISTERED",
		altera_mult_add_rtl1.multiplier_sclr0 = "NONE",
		altera_mult_add_rtl1.multiplier_sclr1 = "NONE",
		altera_mult_add_rtl1.multiplier_sclr2 = "NONE",
		altera_mult_add_rtl1.multiplier_sclr3 = "NONE",
		altera_mult_add_rtl1.negate_aclr = "NONE",
		altera_mult_add_rtl1.negate_latency_aclr = "NONE",
		altera_mult_add_rtl1.negate_latency_clock = "UNREGISTERED",
		altera_mult_add_rtl1.negate_latency_sclr = "NONE",
		altera_mult_add_rtl1.negate_register = "UNREGISTERED",
		altera_mult_add_rtl1.negate_sclr = "NONE",
		altera_mult_add_rtl1.number_of_multipliers = 1,
		altera_mult_add_rtl1.output_aclr = "NONE",
		altera_mult_add_rtl1.output_register = "UNREGISTERED",
		altera_mult_add_rtl1.output_round_aclr = "NONE",
		altera_mult_add_rtl1.output_round_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.output_round_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.output_round_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.output_round_register = "UNREGISTERED",
		altera_mult_add_rtl1.output_round_sclr = "NONE",
		altera_mult_add_rtl1.output_round_type = "NEAREST_INTEGER",
		altera_mult_add_rtl1.output_rounding = "NO",
		altera_mult_add_rtl1.output_saturate_aclr = "NONE",
		altera_mult_add_rtl1.output_saturate_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.output_saturate_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.output_saturate_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.output_saturate_register = "UNREGISTERED",
		altera_mult_add_rtl1.output_saturate_sclr = "NONE",
		altera_mult_add_rtl1.output_saturate_type = "ASYMMETRIC",
		altera_mult_add_rtl1.output_saturation = "NO",
		altera_mult_add_rtl1.output_sclr = "NONE",
		altera_mult_add_rtl1.port_addnsub1 = "PORT_UNUSED",
		altera_mult_add_rtl1.port_addnsub3 = "PORT_UNUSED",
		altera_mult_add_rtl1.port_chainout_sat_is_overflow = "PORT_UNUSED",
		altera_mult_add_rtl1.port_negate = "PORT_UNUSED",
		altera_mult_add_rtl1.port_output_is_overflow = "PORT_UNUSED",
		altera_mult_add_rtl1.port_signa = "PORT_UNUSED",
		altera_mult_add_rtl1.port_signb = "PORT_UNUSED",
		altera_mult_add_rtl1.preadder_direction_0 = "ADD",
		altera_mult_add_rtl1.preadder_direction_1 = "ADD",
		altera_mult_add_rtl1.preadder_direction_2 = "ADD",
		altera_mult_add_rtl1.preadder_direction_3 = "ADD",
		altera_mult_add_rtl1.preadder_mode = "SIMPLE",
		altera_mult_add_rtl1.representation_a = "UNSIGNED",
		altera_mult_add_rtl1.representation_b = "UNSIGNED",
		altera_mult_add_rtl1.rotate_aclr = "NONE",
		altera_mult_add_rtl1.rotate_output_aclr = "NONE",
		altera_mult_add_rtl1.rotate_output_register = "UNREGISTERED",
		altera_mult_add_rtl1.rotate_output_sclr = "NONE",
		altera_mult_add_rtl1.rotate_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.rotate_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.rotate_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.rotate_register = "UNREGISTERED",
		altera_mult_add_rtl1.rotate_sclr = "NONE",
		altera_mult_add_rtl1.scanouta_aclr = "NONE",
		altera_mult_add_rtl1.scanouta_register = "UNREGISTERED",
		altera_mult_add_rtl1.scanouta_sclr = "NONE",
		altera_mult_add_rtl1.selected_device_family = "Cyclone V",
		altera_mult_add_rtl1.shift_mode = "NO",
		altera_mult_add_rtl1.shift_right_aclr = "NONE",
		altera_mult_add_rtl1.shift_right_output_aclr = "NONE",
		altera_mult_add_rtl1.shift_right_output_register = "UNREGISTERED",
		altera_mult_add_rtl1.shift_right_output_sclr = "NONE",
		altera_mult_add_rtl1.shift_right_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.shift_right_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.shift_right_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.shift_right_register = "UNREGISTERED",
		altera_mult_add_rtl1.shift_right_sclr = "NONE",
		altera_mult_add_rtl1.signed_aclr_a = "NONE",
		altera_mult_add_rtl1.signed_aclr_b = "NONE",
		altera_mult_add_rtl1.signed_latency_aclr_a = "NONE",
		altera_mult_add_rtl1.signed_latency_aclr_b = "NONE",
		altera_mult_add_rtl1.signed_latency_clock_a = "UNREGISTERED",
		altera_mult_add_rtl1.signed_latency_clock_b = "UNREGISTERED",
		altera_mult_add_rtl1.signed_latency_sclr_a = "NONE",
		altera_mult_add_rtl1.signed_latency_sclr_b = "NONE",
		altera_mult_add_rtl1.signed_register_a = "UNREGISTERED",
		altera_mult_add_rtl1.signed_register_b = "UNREGISTERED",
		altera_mult_add_rtl1.signed_sclr_a = "NONE",
		altera_mult_add_rtl1.signed_sclr_b = "NONE",
		altera_mult_add_rtl1.systolic_aclr1 = "NONE",
		altera_mult_add_rtl1.systolic_aclr3 = "NONE",
		altera_mult_add_rtl1.systolic_delay1 = "UNREGISTERED",
		altera_mult_add_rtl1.systolic_delay3 = "UNREGISTERED",
		altera_mult_add_rtl1.systolic_sclr1 = "NONE",
		altera_mult_add_rtl1.systolic_sclr3 = "NONE",
		altera_mult_add_rtl1.use_sload_accum_port = "NO",
		altera_mult_add_rtl1.use_subnadd = "NO",
		altera_mult_add_rtl1.width_a = 16,
		altera_mult_add_rtl1.width_b = 16,
		altera_mult_add_rtl1.width_c = 22,
		altera_mult_add_rtl1.width_chainin = 1,
		altera_mult_add_rtl1.width_coef = 18,
		altera_mult_add_rtl1.width_msb = 17,
		altera_mult_add_rtl1.width_result = 32,
		altera_mult_add_rtl1.width_saturate_sign = 1,
		altera_mult_add_rtl1.zero_chainout_output_aclr = "NONE",
		altera_mult_add_rtl1.zero_chainout_output_register = "UNREGISTERED",
		altera_mult_add_rtl1.zero_chainout_output_sclr = "NONE",
		altera_mult_add_rtl1.zero_loopback_aclr = "NONE",
		altera_mult_add_rtl1.zero_loopback_output_aclr = "NONE",
		altera_mult_add_rtl1.zero_loopback_output_register = "UNREGISTERED",
		altera_mult_add_rtl1.zero_loopback_output_sclr = "NONE",
		altera_mult_add_rtl1.zero_loopback_pipeline_aclr = "NONE",
		altera_mult_add_rtl1.zero_loopback_pipeline_register = "UNREGISTERED",
		altera_mult_add_rtl1.zero_loopback_pipeline_sclr = "NONE",
		altera_mult_add_rtl1.zero_loopback_register = "UNREGISTERED",
		altera_mult_add_rtl1.zero_loopback_sclr = "NONE",
		altera_mult_add_rtl1.lpm_type = "altera_mult_add_rtl";
	assign
		result = wire_altera_mult_add_rtl1_result;
endmodule //altera_mult_add_37p2
//VALID FILE
