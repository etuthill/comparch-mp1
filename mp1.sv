// MP1

module top( 
    input logic     clk,
    output logic    RGB_R,
    output logic    RGB_G,
    output logic    RGB_B
    );
    
    parameter BLINK_INTERVAL = 2000000; // 1/6s
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0; //clock state (calcs number of bits needed)
    logic [2:0] color = 0; // 3 bit color state (need to be able to count 000-101)
    
    initial begin
        RGB_R = 1'b1;
        RGB_G = 1'b1;
        RGB_B = 1'b1;
    end

    always_ff @(posedge clk) begin //sequential (every positive/rising edge)
        if (count == BLINK_INTERVAL - 1) begin // max timer count
            count <= 0; // reset timer
            if (color == 5) // max color count
                color <= 0; // reset color
            else
                color <= color + 1; // add one if not maxed
        end
        else begin
            count <= count + 1; // continue if count max not reached
        end
    end

    always_comb begin // combinatorial
        case (color) // low = on
            0: begin //red
                RGB_R = 1'b0;
                RGB_G = 1'b1;
                RGB_B = 1'b1;
            end
            1: begin // red green = yellow
                RGB_R = 1'b0;
                RGB_G = 1'b0;
                RGB_B = 1'b1;
            end
            2: begin // green
                RGB_R = 1'b1;
                RGB_G = 1'b0;
                RGB_B = 1'b1;
            end
            3: begin // blue green = cyan
                RGB_R = 1'b1;
                RGB_G = 1'b0;
                RGB_B = 1'b0;
            end
            4: begin  // blue
                RGB_R = 1'b1;
                RGB_G = 1'b1;
                RGB_B = 1'b0;
            end
            5: begin // red blue = magenta
                RGB_R = 1'b0;
                RGB_G = 1'b1;
                RGB_B = 1'b0;
            end
            default: begin //default off
                RGB_R = 1'b1;
                RGB_G = 1'b1;
                RGB_B = 1'b1;
            end
        endcase
    end
endmodule
