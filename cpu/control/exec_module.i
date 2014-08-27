// Automatically generated by genref.py

// Module: control/ir.v
output logic ctl_ir_we,

// Module: control/interrupts.v
output logic ctl_iffx_clr,
output logic ctl_iff1_clr,
output logic ctl_iff1_iff2,
output logic ctl_in_nmi_clr,
output logic ctl_in_int_clr,
output logic ctl_iffx_we,
output logic ctl_iffx_bit,
output logic ctl_im_we,
output logic [1:0] ctl_im_sel,

// Module: control/decode_state.v
output logic ctl_state_iy_set,
output logic ctl_state_ixiy_clr,
output logic ctl_state_ixiy_we,
output logic ctl_state_halt_set,
output logic ctl_state_halt_clr,
output logic ctl_state_tbl_clr,
output logic ctl_state_tbl_ed_set,
output logic ctl_state_tbl_cb_set,
output logic ctl_state_alu,

// Module: alu/alu_control.v
output logic ctl_shift_en,
output logic ctl_daa_66,
output logic ctl_daa_oe,
output logic ctl_alu_op_low,
output logic ctl_cond_short,
output logic ctl_alu_core_hf,
output logic [1:0] ctl_pf_sel,

// Module: alu/alu_select.v
output logic ctl_alu_oe,
output logic ctl_alu_shift_oe,
output logic ctl_alu_op2_oe,
output logic ctl_alu_res_oe,
output logic ctl_alu_op1_oe,
output logic ctl_alu_bs_oe,
output logic ctl_alu_op1_sel_bus,
output logic ctl_alu_op1_sel_low,
output logic ctl_alu_op1_sel_zero,
output logic ctl_alu_op2_sel_zero,
output logic ctl_alu_op2_sel_bus,
output logic ctl_alu_op2_sel_lq,
output logic ctl_alu_sel_op2_neg,
output logic ctl_alu_sel_op2_high,
output logic ctl_alu_core_R,
output logic ctl_alu_core_V,
output logic ctl_alu_core_S,

// Module: alu/alu_flags.v
output logic ctl_flags_oe,
output logic ctl_flags_bus,
output logic ctl_flags_alu,
output logic ctl_flags_nf_set,
output logic ctl_daa,
output logic ctl_flags_cf_set,
output logic ctl_flags_cf_cpl,
output logic ctl_flags_cf_we,
output logic ctl_flags_sz_we,
output logic ctl_flags_xy_we,
output logic ctl_flags_hf_we,
output logic ctl_flags_pf_we,
output logic ctl_flags_nf_we,
output logic ctl_flags_sel_cf2,
output logic ctl_flags_cf2_we,

// Module: registers/reg_file.v
output logic ctl_sw_4d,
output logic ctl_sw_4u,

// Module: registers/reg_control.v
output logic ctl_reg_exx,
output logic ctl_reg_ex_af,
output logic ctl_reg_ex_de_hl,
output logic ctl_reg_use_sp,
output logic ctl_reg_sel_pc,
output logic ctl_reg_sel_ir,
output logic ctl_reg_sel_wz,
output logic ctl_reg_gp_we,
output logic ctl_reg_sys_we,
output logic ctl_reg_not_pc,
output logic [1:0] ctl_reg_gp_hilo,
output logic [1:0] ctl_reg_gp_sel,
output logic [1:0] ctl_reg_sys_hilo,

// Module: bus/address_latch.v
output logic ctl_inc_cy,
output logic ctl_inc_dec,
output logic ctl_inc_zero,
output logic ctl_al_we,
output logic ctl_ab_mux_inc,
output logic ctl_inc_limit6,
output logic ctl_bus_inc_oe,

// Module: bus/bus_control.v
output logic ctl_bus_ff_oe,
output logic ctl_bus_zero_oe,
output logic ctl_bus_db_oe,

// Module: bus/bus_switch.sv
output logic ctl_sw_1u,
output logic ctl_sw_1d,
output logic ctl_sw_2u,
output logic ctl_sw_2d,

// Module: bus/data_pins.v
output logic ctl_bus_db_we,
