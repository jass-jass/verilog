/*      JK flip flop
    Inputs :    clock ( clk ),
                reset ( rst ),
                J ( j ),
                K ( k ).

    Outputs :   Q ( q ),
                Q bar ( n_q ).
*/
module jkff(input clk, input rst, input j, input k, 
            output reg q, output reg n_q);
    always @(posedge clk, posedge rst) 
    begin
        if(rst)
            q <= 1'b0;
        else
        begin
            case({j,k})
                2'b01 : q <= 1'b0;
                2'b10 : q <= 1'b1;
                2'b11 : q <= ~q;
                default : q <= q;
            endcase
        end
    end
    always@(q) 
    begin
        n_q <= q;
    end
endmodule


/*      Grey Code Counter

    Inputs :    clock ( clk ),
                reset ( rst )
    
    Output :    4 bit count ( count ).
*/
module grey_code_counter(input clk, input rst, 
                        output [3:0] count);
    jkff b0(.clk(clk), .rst(rst), .j(1'b1), 
            .k(1'b1), .q(q0), .n_q(n_q0));
    jkff b1(.clk(~n_q0), .rst(rst), .j(1'b1), 
            .k(1'b1), .q(q1), .n_q(n_q1));
    jkff b2(.clk(~n_q1), .rst(rst), .j(1'b1), 
            .k(1'b1), .q(q2), .n_q(n_q2));
    jkff b3(.clk(~n_q2), .rst(rst), .j(1'b1), 
            .k(1'b1), .q(q3), .n_q(n_q3));
    xor(count[0], q0, q1);
    xor(count[1], q1, q2);
    xor(count[2], q2, q3);
    xor(count[3], q3, 1'b0); 
endmodule
