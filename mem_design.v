module single_port_ram(
    input [7:0] data, //input data
    input [5:0] addr,   // 8*64 bit ram
    input write,
    input clk,
    output [7:0]out  //output data
);
reg [7:0] ram [63:0];
reg [5:0] addr_reg;
always@(posedge clk)
begin
    if(write)
    ram[addr]<=data;
    else addr_reg<=addr;
end
assign out=ram[addr_reg];
endmodule


// testbench

module single_port_ram_tb;
reg[7:0] data;
reg[5:0] addr;
reg write;
reg clk;
wire [7:0]out;

single_port_ram ram1(.data(data),.addr(addr),.write(write),.clk(clk),.out(out));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,single_port_ram_tb);

    clk=1'b1;
    forever #5 clk=~clk;
end

initial 
begin
    data=8'h01;
    addr=5'd0;
    write=1'b1;
    #10;
     
     data=8'h02;
     addr=5'd1;
     #10

     data=8'h03;
     addr=5'd2;
     #10

     addr=5'd0;
     write=1'b0;
     #10

     addr=5'd1;
    #10

     addr=5'd2;
     #5 $finish;
end
endmodule
