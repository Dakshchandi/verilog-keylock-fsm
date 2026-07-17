module keylock(
input clk,
input reset,
input key_valid,
input ENTER,
input [3:0] key,
output reg unlock,
output locked
    );

parameter s0 = 3'd0,
          s1 = 3'd1,
          s2 = 3'd2,
          s3 = 3'd3,
          s4 = 3'd4,
          s5 = 3'd5;

parameter CLK_FREQ  = 100_000_000;
parameter LOCK_TIME = 30 ;

reg [2:0] present_state, next_state;

reg [1:0] wrong_attempts;
reg keypad_locked;
reg [31:0] timer;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        present_state <= s0;
        wrong_attempts <= 0;
        keypad_locked <= 0;
        timer <= 0;
    end
    else
    begin
        present_state <= next_state;
        if(keypad_locked)
        begin
            if(timer >= LOCK_TIME - 1 )
            begin
                keypad_locked <= 0;
                wrong_attempts <= 0;
                timer <= 0;
            end
            else
                timer <= timer + 1;
        end
        else
        begin
            if(next_state == s0 &&
               present_state != s0 &&
               present_state != s5)
            begin
                wrong_attempts <= wrong_attempts + 1;

                if(wrong_attempts == 2)
                begin
                    keypad_locked <= 1;
                    timer <= 0;
                end
            end
            if(present_state == s5)
                wrong_attempts <= 0;

        end
    end
end
   always @(*)
begin
    next_state = present_state;

    if(keypad_locked)
    begin
        next_state = s0;
    end
    else
    begin
        case(present_state)
        s0:
        begin
            if(key_valid)
            begin
                if(key == 4'd3)
                    next_state = s1;
            end
        end
        s1:
        begin
            if(key_valid)
            begin
                if(key == 4'd8)
                    next_state = s2;
                else
                    next_state = s0;
            end
        end
        s2:
        begin
            if(key_valid)
            begin
                if(key == 4'd2)
                    next_state = s3;
                else
                    next_state = s0;
            end
        end
        s3:
        begin
            if(key_valid)
            begin
                if(key == 4'd9)
                    next_state = s4;
                else
                    next_state = s0;
            end
        end
        s4:
        begin
            if(ENTER)
                next_state = s5;
        end
        s5:
        begin
            next_state = s0;
        end

        default:
            next_state = s0;

        endcase
    end
end
    always @(posedge clk or posedge reset)
begin
    if(reset)
        unlock <= 0;
    else if(present_state == s4 && next_state == s5)
        unlock <= 1;
    else
        unlock <= 0;
end
assign locked = keypad_locked;
endmodule
