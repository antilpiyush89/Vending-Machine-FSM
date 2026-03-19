`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2026 13:03:43
// Design Name: 
// Module Name: vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// This is a Moore FSM, 
// since outputs depend only on the current state and are updated synchronously with the clock
`timescale 1ns/1ps

//created a black box with 2 inputs line and 1 output line
module vending_machine(
   input clk,reset,cancel,
   input [1:0] coin,sel,
   output reg PrA,PrB,PrC,change
   
    );
 reg [2:0] current_state, next_state;
 parameter S0 = 3'b000,S5 = 3'b001,S10 = 3'b010,S15 = 3'b011,S20 = 3'b100;
 // sequential logic for state change
 always @(posedge clk, posedge reset) begin
   if(reset) begin
   current_state <= S0;
   end
   else begin
   current_state <= next_state;
   end
 end
 
 // combinational logic to change state assigning according to coin value
 always @(*)begin
 
  next_state = current_state; //Prevent latch → always assign default first
  case(current_state)
  S0: begin
   if(coin==2'b01)begin
   next_state = S5;
   end
   else if(coin==2'b10)begin
   next_state = S10;
   end
   else if(cancel) begin
   next_state= S0;
   end
   else begin
   next_state = S0; // STAY 
   end
   end
  S5: begin
  
   if ( sel!=2'b00)begin
    next_state = S0; // if user select any product, go back to initial state
    // this resets the state after every purchase 
   end
   if(coin==2'b01)begin
   next_state = S10;
   end
   else if(coin==2'b10)begin
   next_state = S15;
   end
   else if(cancel) begin
   next_state= S0;
   end
   else begin
   next_state = S5; // STAY 
   end
   end
  S10: begin
   if ( sel!=2'b00)begin
    next_state = S0; // if user select any product, go back to initial state
    // this resets the state after every purchase 
   end
   if(coin==2'b01)begin
   next_state = S15;
   end
   else if(coin==2'b10)begin
   next_state = S20;
   end
   else if(cancel) begin
   next_state= S0;
   end
   else begin
   next_state = S10; // STAY 
   end
   end
  S15: begin
   if ( sel!=2'b00)begin
    next_state = S0; // if user select any product, go back to initial state
    // this resets the state after every purchase 
   end
   if(coin==2'b01)begin
   next_state = S20;
   end
   else if(cancel) begin
   next_state= S0;
   end
   else begin
   next_state = S15; // STAY 
   end
   end
  S20: begin
   if ( sel!=2'b00)begin
    next_state = S0; // if user select any product, go back to initial state
    // this resets the state after every purchase 
   end
   if(cancel) begin
   next_state= S0;
   end
   else begin
   next_state = S20; // STAY 
   end
   end
   default: next_state= S0; // to avoid latch formation
 endcase
 end
 
 //sequential logic for output
 
 always @(posedge clk or posedge reset) begin
    if(reset) begin
    PrA<=0;
    PrB<=0;
    PrC<=0;
    change<=0;
    end
    else begin
    PrA<=0;
    PrB<=0;
    PrC<=0;
    change<=0;
    
    case(current_state)
   S5: begin
    if(sel==2'b01)begin
    PrA<=1;
    change<=0;
    end

    end
   S10: begin
    if(sel==2'b01)begin
    PrA<=1;
    change<=1;
    end
    else if(sel==2'b10)begin
    PrB<=1;
    change<=0;
    end

    end
   S15: begin
    if(sel==2'b01)begin
    PrA<=1;
    change<=1;
    end
    else if(sel==2'b10)begin
    PrB<=1;
    change<=1;
    end
    else if(sel==2'b11)begin
    PrC<=1;
    change<=0;
    end
    end
   S20: begin
    if(sel==2'b01)begin
    PrA<=1;
    change<=1;
    end
    else if(sel==2'b10)begin
    PrB<=1;
    change<=1;
    end
    else if(sel==2'b11)begin
    PrC<=1;
    change<=1;
    end
    end
    endcase
    
    if (cancel)begin
    PrA<=0;PrB<=0;PrC<=0;change<=1;
    end
    end
    
 end
endmodule
