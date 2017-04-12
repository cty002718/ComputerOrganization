module ALU_1bit_last( result, Overflow, Set, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire Overflow;
  output wire Set;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
  wire amux;
  wire bmux;
  wire outputand;
  wire outputor;
  wire outputadd;

  and(outputand, amux, bmux);
  or(outputor, amux, bmux);
  
  Full_adder Add(outputadd, carryOut, carryIn, amux, bmux);
  
  assign amux = invertA? ~a:a;
  assign bmux = invertB? ~b:b;
  assign result = operation == 2'b00 ? outputand :
  				  operation == 2'b01 ? outputor  :
				  operation == 2'b10 ? outputadd :
				  					   less;
 
  assign Set = outputadd;
  assign Overflow = carryIn^carryOut;
  /*your code here*/ 
  
endmodule
