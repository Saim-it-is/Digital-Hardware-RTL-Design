module Full_subtractor_using_half_subtractor(input A,B,Bin,output Difference,Bout);

wire w2,w3,w4;

half_subtractor h1(.a(A),.b(B),.difference(w2),.borrow(w3));
half_subtractor h2(.a(w2),.b(Bin),.difference(Difference),.borrow(w4));

or G3(Bout,w4,w3);
 
endmodule
