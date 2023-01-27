function derivatives=incrementalRatio(inputs,order)

for idx=1:size(inputs,2)
        j=order;
        leng=1;
        for k=order+1:size(inputs)
            leng=leng+1;
            if leng<=order
                derivatives(leng,idx)=0;
                leng=leng+1;
            end
            if leng==size(inputs)
                break;
            end
            derivatives(leng,idx)= inputs(k,idx)-inputs(j,idx);
            j=j+1;
            if k==size(inputs)
                break;
            end
        end
end
end