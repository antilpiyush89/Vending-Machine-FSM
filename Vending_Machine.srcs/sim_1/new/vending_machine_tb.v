`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2026 19:27:59
// Design Name: 
// Module Name: vending_machine_tb
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

`timescale 1ns/1ps
module vending_machine_tb;
    //Inputs
    reg clk, reset,cancel;
    reg [1:0] coin,sel;
    
    //Outputs
    wire PrA,PrB,PrC,change;
    
    //Instantiate the vending machine module
    vending_machine uut(
    .clk(clk),
    .reset(reset),
    .cancel(cancel),
    .coin(coin),
    .sel(sel),
    .PrA(PrA),
    .PrB(PrB),
    .PrC(PrC),
    .change(change)
    );
    
    //Clock generation: 10ns/50Mhz
    always #5 clk=~clk;
    
    //Test procedure
    initial begin
    
    //Initialize inputs
    clk = 0;
    reset = 1;
    cancel = 0;
    coin = 2'b00;
    sel = 2'b00;
    
    //Hold reset for 20ns
    #20 reset = 0; // reset = 1 for 20ns, at 20ns reset become 0 and program starts working
    
    //Test case 1: Insert 5 rupees coin and select product A
    #10 coin = 2'b01; // at 30ns, 5 rupees inserted 
    #10 coin = 2'b00; // coin signal become 0, it means no coin inserted 
    #10 sel = 2'b01;  // at 40ns
    #10 sel = 2'b00; // select signal becomes 0
    #20;             // at 60ns
    
    //Test case 2: Insert 10 rupees coin and select product B
    #10 coin = 2'b10; // 10 rupees inserted 
    #10 coin = 2'b00; // no coin inserted
    #10 sel = 2'b10; 
    #10 sel = 2'b00;
    #20;             
    
    
    //Test case 3: Insert 15 rupees coin and select product C
    #10 coin = 2'b10; 
    #10 coin = 2'b00;
    #10 coin = 2'b01; 
    #10 coin = 2'b00;
    #10 sel = 2'b11; 
    #10 sel = 2'b00;
    #20;
    
    //Test case 4: Insert 20 rupees coin and select product C and get change
    #10 coin = 2'b10;
    #10 coin = 2'b00; 
    #10 coin = 2'b10; 
    #10 coin = 2'b00;
    #10 sel = 2'b11; 
    #10 sel = 2'b00;
    #20; 
    
    #50 $finish;             
    end
    
    // to monitor the results
    
    initial begin
    
    $monitor("Time: %d, Coin: %d, Select: %d, PrA:%d, PrB:%d, PrC:%d, change:%d",$time, coin,
    sel,PrA,PrB,PrC,change);
    end
endmodule
