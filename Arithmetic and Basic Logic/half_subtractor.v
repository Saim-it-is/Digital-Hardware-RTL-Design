module half_subtractor(input a,b, output difference,borrow);

wire w1;

xor G1(difference,a,b);
not G2(w1,a);
and G3(borrow,b,w1);

endmodule