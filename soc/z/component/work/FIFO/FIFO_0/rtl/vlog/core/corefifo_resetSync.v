// syncr.v

// ********************************************************************/
// Actel Corporation Proprietary and Confidential
//  Copyright 2011 Actel Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
// IN ADVANCE IN WRITING.
//
// Description: Reset synchroniser.v
//               
//
//
// Revision Information:
// Date     Description
//
// SVN Revision Information:
// SVN $Revision: 4805 $
// SVN $Date: 2012-06-21 17:48:48 +0530 (Thu, 21 Jun 2012) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ********************************************************************/

`timescale 1ns / 100ps

module FIFO_FIFO_0_corefifo_resetSync(
                  clk,
                  reset,
                  
                  reset_out
                  );

   // --------------------------------------------------------------------------
   // PARAMETER Declaration
   // --------------------------------------------------------------------------
 parameter NUM_STAGES = 2;
 

input clk;
input reset;
output  reset_out;
reg  [NUM_STAGES-1:0] shift_reg ;

always @( posedge clk or negedge reset) begin
if (!reset)
  shift_reg <= 'h0;
else
  shift_reg <= {shift_reg[NUM_STAGES-2:0], 1'b1};
end
  

assign reset_out = shift_reg[NUM_STAGES-1];



 endmodule
   
   // --------------------------------------------------------------------------
   //                             End - of - Code
   // --------------------------------------------------------------------------
