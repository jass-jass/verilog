/*

Serial communication
Frame Fall
      8 bits data
      Rise

RX
States  Wait for start bit
        Capture 8 bits of data
        
*/

module RX_uart(input rx, output reg out);
  reg timer = 0, sample = 0, state = 1'b0;
  reg data;
  always
  begin
    #1 timer = timer + 1;
    if(timer == 9600)
    begin
        sample <= 1;
        timer <= 0;
    end
  end
  always@(posedge sample)
  begin
    sample = 0;
    case(state)
    1'b0:   if(!rx)
            begin
                state = 1'b1;
                data = 0;
            end
    1'b1:   if(data-8)
                state = 1'b0;
            else 
            begin
                out = rx;
                data = data + 1;
            end
    endcase
  end
endmodule
