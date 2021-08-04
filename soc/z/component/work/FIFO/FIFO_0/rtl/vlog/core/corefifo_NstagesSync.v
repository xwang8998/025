// ********************************************************************/
// Actel Corporation Proprietary and Confidential
//  Copyright 2011 Actel Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
// IN ADVANCE IN WRITING.
//
// Description: doubleSync.v
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

module FIFO_FIFO_0_corefifo_NstagesSync(
                  clk,
                  rstn,
                  inp,
                  sync_out
                  );

   // --------------------------------------------------------------------------
   // PARAMETER Declaration
   // --------------------------------------------------------------------------
  parameter NUM_STAGES = 2;
  parameter ADDRWIDTH = 3;

input clk;
input rstn;
input [ADDRWIDTH : 0 ] inp;
output [ADDRWIDTH : 0 ] sync_out;

//reg [WIDTH -1:0] signal_out;

 reg [ADDRWIDTH : 0 ] shift_reg [NUM_STAGES-1:0] ;

integer i;
always @ ( posedge clk or negedge rstn) 
  begin	
    if (!rstn) 
      begin
        for(i = NUM_STAGES-1; i >= 0 ; i = i-1) 
          begin
		    shift_reg[i] <= 'h0;
          end
      end
 /// signal_out <= 'h0;
  else
    begin

	  for(i = NUM_STAGES-1; i > 0; i = i-1) 
		shift_reg[i] <= shift_reg[i-1];

	shift_reg[0] <= inp;
//end
    //signal_out <= shift_reg[NUM_STAGES-1];
    end
end 

assign sync_out = shift_reg[NUM_STAGES-1];


   
   
endmodule // corefifo_doubleSync

   // --------------------------------------------------------------------------
   //                             End - of - Code
   // --------------------------------------------------------------------------
