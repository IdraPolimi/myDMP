T = timeScale/(tau*dt);
for ii=1:T
    ytg(ii) = (exp(ii/1000)+sin(pi*ii/1000)+0.5)/10;
end
dytg =diff(ytg)/dt;
ddytg =diff(dytg)/dt;
dytg = [dytg(1) dytg];
ddytg = [ddytg(1) ddytg(1) ddytg];
clear ii
