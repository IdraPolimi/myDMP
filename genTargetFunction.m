%each row of ytg,dytg and ddytg is a gld!

%updating number of gdl
gdl = 2;

T = timeScale/(tau*dt);
for jj = 1:gdl
    for ii=1:T
        ytg(jj,ii) = (exp(ii/1000)+sin(jj*pi*ii/1000)+0.5)/10;
    end
    dytgTemp =diff(ytg(jj,:))/dt;
    ddytgTemp =diff(dytgTemp)/dt;
    dytg(jj,:) = [dytgTemp(1) dytgTemp];
    ddytg(jj,:) = [ddytgTemp(1) ddytgTemp(1) ddytgTemp];
end
clear dytgTemp
clear ddytgTemp
clear jj
clear ii
