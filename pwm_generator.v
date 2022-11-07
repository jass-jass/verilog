/*  pwm generator

Inputs :  Clock ( clk ),
          4 bit Duty ( duty ).
          
Output :  PWM output ( pwm )

*/

module generate_pwm(input clk, input [0:3]duty, output reg pwm);
  reg [0:3] count;
  reg [0:3] timep = 4'b0000;
  always@(posedge clk)
  begin
    if(timep == 4'b1010)
    begin
        count <= duty;
        timep = 4'b0000;
    end
    if(count > 4'b0000)
    begin
        pwm <= 1'b1;
        count = count - 1;
    end
    else 
        pwm <= 1'b0;
    timep <= timep + 1;
  end
  always@(duty)
  begin
    count  <= duty;
    timep = 4'b0000; 
  end
endmodule
