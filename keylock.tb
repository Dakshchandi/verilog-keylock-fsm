module keylock_tb();

reg clk;
reg reset;
reg key_valid;
reg ENTER;
reg [3:0] key;

wire unlock;
wire locked;

keylock uut(
    .clk(clk),
    .reset(reset),
    .key_valid(key_valid),
    .ENTER(ENTER),
    .key(key),
    .unlock(unlock),
    .locked(locked)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    key_valid = 0;
    ENTER = 0;
    key = 0;

    #20;
    reset = 0;

    //-----------------------------
    // Correct Password
    //-----------------------------

    //3
    @(negedge clk);
    key = 4'd3;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    //8
    @(negedge clk);
    key = 4'd8;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    //2
    @(negedge clk);
    key = 4'd2;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    //9
    @(negedge clk);
    key = 4'd9;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    //ENTER
    @(negedge clk);
    ENTER = 1;
    @(posedge clk);
    @(negedge clk);
    ENTER = 0;

    @(posedge clk);

    if(unlock)
        $display("PASS : Correct Password");
    else
        $display("FAIL : Correct Password");

    #20;

    //-----------------------------
    // Wrong Attempt 1 (3,5)
    //-----------------------------

    @(negedge clk);
    key = 4'd3;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    @(negedge clk);
    key = 4'd5;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    #20;

    //-----------------------------
    // Wrong Attempt 2 (3,1)
    //-----------------------------

    @(negedge clk);
    key = 4'd3;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    @(negedge clk);
    key = 4'd1;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    #20;

    //-----------------------------
    // Wrong Attempt 3 (3,7)
    //-----------------------------

    @(negedge clk);
    key = 4'd3;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    @(negedge clk);
    key = 4'd7;
    key_valid = 1;
    @(posedge clk);
    @(negedge clk);
    key_valid = 0;

    #20;

    if(locked)
        $display("PASS : Keypad Locked");
    else
        $display("FAIL : Keypad Not Locked");

    //-----------------------------
    // Wait for Timer
    //-----------------------------

    repeat(35)
        @(posedge clk);

    if(!locked)
        $display("PASS : Keypad Unlocked");
    else
        $display("FAIL : Keypad Still Locked");

    #20;
    $finish;
end

endmodule
