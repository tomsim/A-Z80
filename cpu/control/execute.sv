//============================================================================
// Module execute in control/decode Z80 CPU
//
// Copyright 2014 Goran Devic
//
// This module implements the instruction execute state logic.
//============================================================================
`timescale 1ns/ 100 ps

module execute
(
    //----------------------------------------------------------
    // Control signals generated by the instruction execution
    //----------------------------------------------------------
    `include "exec_module.i"

    output logic nextM,
    output logic setM1,

    output logic fFetch,
    output logic fMRead,
    output logic fMWrite,
    output logic fIORead,
    output logic fIOWrite,

    //----------------------------------------------------------
    // Inputs from the instruction decode PLA
    //----------------------------------------------------------
    input wire [104:0] pla,             // Statically decoded instructions

    //----------------------------------------------------------
    // Inputs from various blocks
    //----------------------------------------------------------
    input wire fpga_reset,              // Used only in simulation
    input wire reset,                   // Internal reset signal
    input wire clk,                     // Internal clock signal
    input wire in_intr,                 // Servicing maskable interrupt
    input wire in_nmi,                  // Servicing non-maskable interrupt
    input wire im1,                     // Interrupt Mode 1
    input wire im2,                     // Interrupt Mode 2
    input wire use_ixiy,                // Special decode signal
    input wire flags_cond_true,         // Flags condition is true
    input wire repeat_en,               // Enable repeat of a block instruction
    input wire flags_zf,                // ZF to test a condition
    input wire flags_nf,                // NF to test for subtraction
    input wire flags_sf,                // SF to test for 8-bit sign of a value
    input wire flags_cf,                // CF to set HF for CCF

    //----------------------------------------------------------
    // Machine and clock cycles
    //----------------------------------------------------------
    input wire M1,                      // Machine cycle #1
    input wire M2,                      // Machine cycle #2
    input wire M3,                      // Machine cycle #3
    input wire M4,                      // Machine cycle #4
    input wire M5,                      // Machine cycle #5
    input wire M6,                      // Machine cycle #6
    input wire T1,                      // T-cycle #1
    input wire T2,                      // T-cycle #2
    input wire T3,                      // T-cycle #3
    input wire T4,                      // T-cycle #4
    input wire T5,                      // T-cycle #5
    input wire T6                       // T-cycle #6
);

// If set by the execution matrix, prevents looping back to the next instruction
// Instructions that are longer than 4T set this at M1/T4
logic contM1;                           // Continue M1 cycle
// Instructions that use M2 immediately after M1/T4 set this at M1/T4
logic contM2;                           // Continue with the next M cycle
// Activates a state machine to compute WZ=IX+d; takes 5T cycles
logic ixy_d;                            // Compute WX=IX+d
// Signals the setting of IX/IY and CB/ED prefix flags; inhibits clearing them
logic setIXIY;                          // Set IX/IY flag at the next T cycle
logic setCBED;                          // Set CB or ED flag at the next T cycle
// Holds asserted by non-repeating versions of block instructions (LDI/CPI,...)
logic nonRep;                           // Non-repeating block instruction

//----------------------------------------------------------
// Define various shortcuts to field naming
//----------------------------------------------------------
`define GP_REG_BC       2'h0
`define GP_REG_DE       2'h1
`define GP_REG_HL       2'h2
`define GP_REG_AF       2'h3

`define PFSEL_P         2'h0
`define PFSEL_V         2'h1
`define PFSEL_IFF2      2'h2
`define PFSEL_REP       2'h3
//----------------------------------------------------------
// Make available different sections of the opcode byte
//----------------------------------------------------------
wire op5;
wire op4;
wire op3;
wire op2;
wire op1;
wire op0;
assign op5 = pla[104];
assign op4 = pla[103];
assign op3 = pla[102];
assign op2 = pla[101];
assign op1 = pla[100];
assign op0 = pla[99];

wire [1:0] op54;
wire [1:0] op43;
wire [1:0] op21;

assign op54 = { pla[104], pla[103] };
assign op43 = { pla[103], pla[102] };
assign op21 = { pla[101], pla[100] };

//-----------------------------------------------------------
// 8-bit register selections needs to swizzle mux for A and F
//-----------------------------------------------------------
wire rsel3;
wire rsel0;
assign rsel3 = op3 ^ (op4 & op5);
assign rsel0 = op0 ^ (op1 & op2);

always_comb
begin
    //----------------------------------------------------------
    // Default assignment of all control outputs to 0 to prevent the
    // generation of latches
    //----------------------------------------------------------
    `include "exec_zero.i"

    // Reset internal control wires
    contM1 = 0; contM2 = 0;
    nextM = 0;  setM1 = 0;
    // Reset global machine cycle functions
    fFetch = 0; fMRead = 0; fMWrite = 0; fIORead = 0; fIOWrite = 0;
    ixy_d = 0;
    setIXIY = 0; setCBED = 0;
    nonRep = 0;

    //----------------------------------------------------------
    // Reset control: Set PC and IR to 0
    //----------------------------------------------------------
    if (reset && !fpga_reset) begin
        ctl_inc_zero = 1;               // Force 0 to the output of incrementer
        ctl_bus_inc_oe = 1;             // Incrementer to the abus
        ctl_reg_sel_pc = clk;           // Write to the PC on clock up
        ctl_reg_sel_ir = !clk;          // Write to the IR on clock down
        ctl_reg_sys_we = 1;             // Perform write
        ctl_reg_sys_hilo = 2'b11;       // 16-bit width & write
    end

    //----------------------------------------------------------
    // State-based signal assignment
    //----------------------------------------------------------
    `include "exec_matrix.i"

    //========================================================================
    // Default M1 fetch state control
    //========================================================================
    if (M1 && T4) begin
        nextM = !contM1;                // Complete the default M1 cycle
        setM1 = !contM1 & !contM2;      // Set next M1 cycle
    end
end

endmodule
