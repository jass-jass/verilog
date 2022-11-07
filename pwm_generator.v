/*  pwm generator

Inputs :  Clock ( clk ),
          4 bit Duty ( duty ).
          
Output :  PWM output ( pwm )

*/

module generate_pwm(input clk, input rst, input [0:3]duty, output reg pwm);
  reg [0:3] count;
  reg [0:3] timep = 4'b0000;
  reg temp;
  always@(posedge clk, rst)
  begin
    timep = timep + 1;
    if(timep == 4'b1010 | rst == 1'b1)
    begin
        count = duty;
        timep = 4'b0000;
    end
    else
        temp = count;
    if(count > 4'b0000)
    begin
        pwm = 1'b1;
        count = count - 1;
    end
    else 
        pwm = 1'b0;
  end

  always@(duty)
  begin
    count  = duty;
    timep = 4'b0000; 
  end
endmodule
