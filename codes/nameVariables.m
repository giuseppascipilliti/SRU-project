function out=nameVariables(in,matrix)
if matrix==1
    
    out=["in1(k-1)","in1(k-3)","in1(k-5)","in1(k-7)","in1(k-9)","in2(k-1)","in2(k-3)","in2(k-5)","in2(k-7)","in2(k-9)","in3(k-1)","in3(k-3)","in3(k-5)","in3(k-7)","in3(k-9)","in4(k-1)","in4(k-3)","in4(k-5)","in4(k-7)","in4(k-9)","in5(k-1)","in5(k-3)","in5(k-5)","in5(k-7)","in5(k-9)"];


else
    
    out=["in1","in1der1", "in1der2","in2","in2der1","in2der2","in3","in3der1","in3der2","in4","in4der1","in4der2","in5","in5der1","in5der2"];
end
