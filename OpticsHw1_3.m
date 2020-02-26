
water3=dlmread('Water3.txt','\t');
lamda_water3=water3(:,1);
absorption_water3=water3(:,2);




water=dlmread('Water.txt','\t');
lamda_water=water(:,1);
absorption_water=water(:,2);


hemo=dlmread('Hemo.txt','\t');
lamda_hemo=hemo(:,1);
mec_o2=hemo(:,2);
mec_hb=hemo(:,3);

water2=dlmread('Water2.txt','\t');
lamda_water2=flip(water2(:,1));
absorption_water2=flip(water2(:,2));

lamda_water=cat(1,lamda_water,lamda_water2)
absorption_water=cat(1,absorption_water,absorption_water2)

lamda_water=cat(1,lamda_water3,lamda_water)
absorption_water=cat(1,absorption_water3,absorption_water)





absoption_o2 =  (2.303)* mec_o2 * 150/(64500)
absoption_hb =  (2.303)* mec_hb * 150/(64500)

so2=0.95
CHb= 150 %g/l

o2_con = 0.95*150/64500;
hb_con = (1-0.95)*150/64500;

total_absorption= (2.303)*( mec_o2 *o2_con + mec_hb*hb_con)

%{
figure;
hold on
%xlim([650,1000])
plot(lamda_water,absorption_water,'LineWidth',2)
ylabel('Absorption (cm^{-1})')
xlabel('Wavelength (nm)')
plot(lamda_hemo,absoption_o2,'LineWidth',2)
plot(lamda_hemo,absoption_hb,'LineWidth',2)
legend('water','HbO_{2}','Hb','Total')

%plot(lamda_hemo,total_absorption)
%legend('water','HbO_{2}','Hb','Total')


figure;
hold on

plot(lamda_water,absorption_water,'LineWidth',2)
ylabel('Absorption (cm^{-1})')
xlabel('Wavelength (nm)')
plot(lamda_hemo,total_absorption,'LineWidth',2)
plot([506,506],[0,107.8523],'k','LineWidth',1.5)
legend('water','Total')


%lamda_hemo_new=lamda_hemo[66:240]
%total_hemo_new=total_absorption[66:240]
total_hemo_new=interp1(lamda_hemo(66:240),total_absorption(66:240),lamda_water,'linear')
total=total_hemo_new*0.07+absorption_water*0.93;
figure;
plot(lamda_water,total,'LineWidth',2)
hold on
xlim([600,728])
ylabel('Absorption (cm^{-1})')
xlabel('Wavelength (nm)')
plot([695,695],[0, 0.1412],'--r','LineWidth',2)
%}

figure;
hold on
%xlim([650,1000])
semilogy(lamda_water,(absorption_water),lamda_hemo,(absoption_o2),lamda_hemo,(absoption_hb),'LineWidth',2)
ylabel('Absorption (cm^{-1})')
xlabel('Wavelength (nm)')

legend('Water','HbO_{2}','Hb')

%plot(lamda_hemo,total_absorption)
%legend('water','HbO_{2}','Hb','Total')


figure;
hold on

semilogy(lamda_water,(absorption_water),'LineWidth',2)
ylabel('Absorption (cm^{-1})')
xlabel('Wavelength (nm)')
semilogy(lamda_hemo,(total_absorption),'LineWidth',2)
%semilogy([506,506],[0,(107.8523)],'k','LineWidth',1.5)
legend('Water','Blood')


%lamda_hemo_new=lamda_hemo[66:240]
%total_hemo_new=total_absorption[66:240]
total_hemo_new=interp1(lamda_hemo,total_absorption,lamda_water,'linear')
total=total_hemo_new*0.07+absorption_water*0.75;
figure;
%hold on
%semilogy(lamda_water,total,'LineWidth',2)
%plot(lamda_water,total,'LineWidth',2)
%plot([695,695],[0, 0.1402],'--r','LineWidth',2)
semilogy(lamda_water,total_hemo_new*0.07,'r',lamda_water,absorption_water*0.75,'b',lamda_water,total,'k','LineWidth',1)
hold on
plot([695,695],[10^-5, 0.1402],'--r','LineWidth',1)
%xlim([600,728])
ylabel('Absorption (cm^{-1})')
xlabel('Wavelength (nm)')
ylim([10^-5,10^4])
%semilogy([695,695],[0, (0.1412)],'--r','LineWidth',2)
legend('7% Blood','75% Water','Total')

