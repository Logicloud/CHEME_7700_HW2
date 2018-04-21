figure(1);
plot(Time, TotE);

avg_E = mean(TotE);
std_E = std(TotE);
TotE_sqr = zeros([1 52002]);

for i = 1:52002
    TotE_sqr(i) = TotE(i)^2;
end

avg_TotE_sqr = mean(TotE_sqr);
diff = avg_TotE_sqr - avg_E^2;

m = [];
n = [];
for binsize = 200:20:2000
    Ab =[];
    SM = [];
    Binnum = int16(52002/binsize);
    for binnum = 1:Binnum
        Ab(binnum) = mean(TotE(binsize*(binnum-1)+1:binsize*binnum));
        SM(binnum) = (Ab(binnum) - avg_E)^2;
    end
    sigma_square = binsize/52002 * sum(SM);
    tb = binsize * 200 * 1e-6;
    inv_tb = 1 / tb;
    P = tb * sigma_square / diff;
    inv_P = 1/P;
    m = [m inv_tb];
    n = [n inv_P];
end
figure(2);
plot(m,n, 'x')