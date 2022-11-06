/*  pwm generator

Inputs :  Clock ( clk ),
          4 bit Duty ( duty ).
          
Output :  PWM output ( pwm )

*/

module generate_pwm(input clk, input [0:3]duty, output reg pwm);
  reg count = 4'b0000;
  always@(posedge clk)
  begin
    case(duty)
      4'b0000: if(
  end
  always@(duty)
  begin
    
  end
