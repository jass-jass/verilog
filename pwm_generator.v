/*    Tff 

Inputs :  clock ( clk ),
          reset ( rst ),
          T ( t ).

Output :  Q ( q )

Truth Table:   rst  clk   t      q
                1    x    x      0
                0   rise  1      ~q
                0   rise  0      q
                0   fall  x      q

*/ 
module tff(input t, input clk, input rst, output reg q);
  always@(posedge clk, posedge rst) 
  begin
    if(rst)
    begin
      q <= 1;
    end
    else 
    begin
      if(t)
        q <= ~q;
      else
        q <= q;
    end
  end
endmodule


/*    4 bit Asynchronous counter

Inputs :  clock ( clk ),
          reset ( rst ).

Output :  4 bit count ( count ).
*/
module up_counter(input clk, input rst, output [3:0] count);
  and(eleven, ~count[3], ~count[1], ~count[0]);
  or(reset, eleven, rst);
  tff t0(.clk(clk), .t(1'b1), .rst(reset), .q(count[0]));
  tff t1(.clk(count[0]), .t(1'b1), .rst(reset), .q(count[1]));
  tff t2(.clk(count[1]), .t(1'b1), .rst(reset), .q(count[2]));
  tff t3(.clk(count[2]), .t(1'b1), .rst(reset), .q(count[3]));
endmodule


/*    pwm generator

Inputs :  clock ( clk ),
          reset ( rst ),
          4 bit duty ( duty ).

Output :  pwm (pwm)
*/
module generate_pwm(input clk, input rst, input [3:0] duty, output reg pwm);
  reg n_off, on;
  up_counter counter(.clk(clk), .rst(rst), .count({a, b, c, d}));
  always@(posedge clk)
  begin
    n_off <= (~a^duty[3]) || (~b^duty[2]) || (~c^duty[1]) || (~d^duty[0]); 
    on <= a && b && c && d;
  end
  always@(n_off, on)
  begin
    if(on)
    begin
      pwm = 1'b1;
    end
    else if (~n_off)
      pwm = 1'b0;
  end
endmodule
