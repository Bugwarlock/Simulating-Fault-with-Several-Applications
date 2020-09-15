`timescale 1ns/1ns
module collapsingc6288 ();
  reg [0:31] inp;
  wire [0:31] out;
  c6288_net MUT (inp[0],inp[1],inp[2],inp[3],inp[4],inp[5],inp[6],inp[7],inp[8],inp[9],inp[10],inp[11],inp[12],
  inp[13],inp[14],inp[15],inp[16],inp[17],inp[18],inp[19],inp[20],inp[21],inp[22],inp[23],inp[24],inp[25],inp[26],
  inp[27],inp[28],inp[29],inp[30],inp[31],
  out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12],out[13],out[14],
  out[15],out[16],out[17],out[18],out[19],out[20],out[21],out[22],out[23],out[24],out[25],out[26],out[27],out[28],
  out[29],out[30],out[31]);
  initial begin 
  $FaultCollapsing (collapsingc6288.MUT, "c6288_fault.flt"); 
  repeat (4294967295) #300 {inp[0],inp[1],inp[2],inp[3],inp[4],inp[5],inp[6],inp[7],inp[8],inp[9],inp[10],inp[11],inp[12],
  inp[13],inp[14],inp[15],inp[16],inp[17],inp[18],inp[19],inp[20],inp[21],inp[22],inp[23],inp[24],inp[25],inp[26],
  inp[27],inp[28],inp[29],inp[30],inp[31]} = {inp[0],inp[1],inp[2],inp[3],inp[4],inp[5],inp[6],inp[7],inp[8],inp[9],inp[10],inp[11],inp[12],
  inp[13],inp[14],inp[15],inp[16],inp[17],inp[18],inp[19],inp[20],inp[21],inp[22],inp[23],inp[24],inp[25],inp[26],
  inp[27],inp[28],inp[29],inp[30],inp[31]} + 1; 
  end
endmodule
