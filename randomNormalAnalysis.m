%this code is intended to read waveform data from the randomNormal module

data = readmatrix('testNumbers.csv');
dataSize = size(data, 2);
modifiedData = zeros(size(data, 2), 1);

%the matrix read from testNumbers.csv is read in integers, but are defined
%through my verilog program as 4.28 2's comp fixed point. This section
%converts each 32 bit "integer" to a floating point number.
for i = 1 : size(data, 2) - 1
    temp = data(1, i);
    neg = 0;
    
    %the following section converts this number into a positive magnitude
    %it also raises a neg flag for the final part of the conversion.
    if(temp < 0)
        temp = temp * -1;
        neg = 1;
    end
    
    %does the fixed to floating point conversion
    temp2 = 0.0;
    for j = 0 : 30
       if(bitand(int32(temp), int32(2^j)) ~= 0)
           number = 2^(j - 28);
           temp2 = temp2 + number;
       end
    end
    modifiedData(i, 1) = temp2;
    
    if(neg == 1)
       modifiedData(i,1) = modifiedData(i, 1) * -1;
    end
end

%plots the data in a histogram for verification
histogram(modifiedData);
%histogram(data)
