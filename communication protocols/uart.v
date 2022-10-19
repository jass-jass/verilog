/*

Serial communication
Frame Fall
      8 bits data
      Rise

RX
States  Wait for start bit
        Capture 8 bits of data
        
*/
module RX_uart(input baud, input rx, output reg out);
  reg state = 1'b0;
  reg [0:2]data = 3'b000;
  always@(posedge baud)
  begin
    case(state)
    1'b0:   if(rx == 0)
                state = 1'b1;
    1'b1:   if(data==3'b111)
            begin
                state = 1'b0;
                data = 3'b000;
                out = 1;
            end
            else 
            begin
                out = rx;
                data = data + 3'b001;
            end
    endcase
  end
endmodule
