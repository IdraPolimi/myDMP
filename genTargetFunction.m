%each row of ytg,dytg and ddytg is a gld!

%updating number of gdl
gdl = 1;

T = timeScale/(tau*dt);
% for jj = 1:gdl
%     for ii=1:T
%         ytg(jj,ii) = (exp(ii/1000)+sin(jj*pi*ii/1000)+0.5)/10;
%     end
%     dytgTemp =diff(ytg(jj,:))/dt;
%     ddytgTemp =diff(dytgTemp)/dt;
%     dytg(jj,:) = [dytgTemp(1) dytgTemp];
%     ddytg(jj,:) = [ddytgTemp(1) ddytgTemp(1) ddytgTemp];
% end
%%%%%%%%%%%%%%%%%
k = 1;
zOld = 0;
 for jj = 1:gdl
     for ii=-(T/2):(T/2-1)
         z = ii/1000;
         ytg(jj,k) = (z^5 + 3.5*z^4 - 2-5*z^3 - 12.5*z^2 + 1.5*z +9)/10-1.5;
         k = k+1;
         z-zOld
         zOld = z;
      end
     dytgTemp=diff(ytg(jj,:))/(1/1000);
     ddytgTemp=diff(dytgTemp)/(1/1000);
     dytg(jj,:) = [dytgTemp(1) dytgTemp];
     ddytg(jj,:) = [ddytgTemp(1) ddytgTemp(1) ddytgTemp];
 end
 figure()
plot(ytg(1,:));
figure()
plot(dytg(1,:),'r--');
figure()
plot(ddytg(1,:),'g--');

clear dytgTemp
clear ddytgTemp
clear jj
clear ii
