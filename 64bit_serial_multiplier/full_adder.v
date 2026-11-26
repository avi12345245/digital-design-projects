module full_adder(a, b, cin, sum, cout);
  input a, b, cin;
  output sum, cout;
  wire s1, s2,s3;
  xor (s1, a, b);
  xor (sum, s1, cin);
  and (s2, a, b);
  and (s3, s1, cin);
  or  (cout, s2, s3);
 endmodule