module flag_register(
    input clk,rst,
    input carry_in,
    input zero_in,
    input carry_wr,
    input zero_wr,
    output carry_flag_status,
    output zero_flag_status

);

    reg carry;
    reg zero;

    assign carry_flag_status = carry;
    assign zero_flag_status = zero;

    always @(posedge clk) begin
        if(rst) begin
            carry <= 0;
            zero <= 0;
        end

        else begin
            if(carry_wr) begin
                carry <= carry_in;
            end
            if(zero_wr) begin
                zero <= zero_in;
            end
        end
    end
endmodule