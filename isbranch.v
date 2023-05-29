module isbranch(input branch, input zero_flag, input sign_flag, input carry_flag, input overf_flag, input [14:12]inst, output reg isb_ou);

always@(*) 
begin
    case(inst)
        3'b000:begin
        if (branch && zero_flag)
        isb_ou = 1'b1;
        else
        isb_ou = 1'b0;
        end
        3'b001:begin
        if (branch && !zero_flag)
        isb_ou = 1'b1;
        else
        isb_ou = 1'b0;
        end
        3'b100: begin
        if (branch && (sign_flag!=overf_flag))
        isb_ou = 1'b1;
        else
        isb_ou = 1'b0;
        end
        3'b101: begin
        if (branch && (sign_flag==overf_flag))
        isb_ou = 1'b1;
        else
        isb_ou = 1'b0;
        end
        3'b110: begin
        if (branch && !carry_flag)
        isb_ou = 1'b1;
        else
        isb_ou = 1'b0;
        end
        3'b111: begin
        if (branch && carry_flag)
        isb_ou = 1'b1;
        else
        isb_ou = 1'b0;
        end
    endcase
end

endmodule

