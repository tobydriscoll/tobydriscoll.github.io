
one = bits(1.0)

function ieee(x::Float64)
    b = bits(x);
    s = (b[1:1],parse(Int,b[1:1]));
    e = (b[2:12],parse(Int,b[2:12],2)-1023);
    f = (b[13:64],parse(Int,b[13:64],2));
    return s,e,f
end

ieee(1.0)

@show eps()
ieee(1.0+eps())

@show R = (2.0^1023)*(1 + (2^52-1)/2^52);
ieee(R)

nextfloat(R)

2.0^(-1022)

@show r = 2.0^-1022;
ieee(r)
