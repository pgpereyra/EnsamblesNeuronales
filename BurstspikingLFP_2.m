function corrmatrix=BurstspikingLFP_2(signal1,signal2)
signal1=signal1;
signal2=signal2;
%% Find the cross-correlation between conditions
[r,lags]=xcorr([signal1',signal2']); %Here we get all cross correationbetween the same and other matriz

%% Create frames of 25ms in the burst, save them in a matrix and correlate between them an with the post condition;
m=[]; 
m2=[];
window_2=624; %size window (25ms)
step=624;
for l=1:size(signal1,1) 
    for t=1:step:size(signal1,2)-window_2;
        segment=signal1(t:t+window_2);
        segment2=signal2(t:t+window_2);
        m=[m;segment];               %Get the windows in both matrix at the same time
        m2=[m2;segment2];
    end
end
M=[m;m2]; %Put all the windows in the same matrix
[R P] = corrcoef(M','Rows','pairwise'); %We get the correlation values rowbyrow (row=window 25ms)
%% To get the graphics from every cross-correlation or autocorrelation
set(0,'DefaultFigureVisible','off');
figure(1) %controlvscontrol
%Plot only the crosscorrelation values that are not repeted
set(gcf,'Position',[209 295 1429 683],'color','w')
subplot(5,5,1),plot(lags,r(:,1));subplot(5,5,2),plot(lags,r(:,2));subplot(5,5,3),plot(lags,r(:,3));subplot(5,5,4),plot(lags,r(:,4));subplot(5,5,5),plot(lags,r(:,5));
subplot(5,5,7),plot(lags,r(:,12));subplot(5,5,8),plot(lags,r(:,13));subplot(5,5,9),plot(lags,r(:,14));subplot(5,5,10),plot(lags,r(:,15));
subplot(5,5,13),plot(lags,r(:,23));subplot(5,5,14),plot(lags,r(:,24));subplot(5,5,15),plot(lags,r(:,25));
subplot(5,5,19),plot(lags,r(:,34));subplot(5,5,20),plot(lags,r(:,35));
subplot(5,5,25),plot(lags,r(:,45))
savefig('ControlVSControl')

figure(2) %controlvspost
set(gcf,'Position',[209 295 1429 683],'color','w')
subplot(5,5,1),plot(lags,r(:,6));subplot(5,5,2),plot(lags,r(:,7));subplot(5,5,3),plot(lags,r(:,8));subplot(5,5,4),plot(lags,r(:,9));subplot(5,5,5),plot(lags,r(:,10));
subplot(5,5,7),plot(lags,r(:,17));subplot(5,5,8),plot(lags,r(:,18));subplot(5,5,9),plot(lags,r(:,19));subplot(5,5,10),plot(lags,r(:,20));
subplot(5,5,13),plot(lags,r(:,28));subplot(5,5,14),plot(lags,r(:,29));subplot(5,5,15),plot(lags,r(:,30));
subplot(5,5,19),plot(lags,r(:,39));subplot(5,5,20),plot(lags,r(:,40));
subplot(5,5,25),plot(lags,r(:,50))
savefig('ControlVSPost')

figure(3) %postvspost
set(gcf,'Position',[209 295 1429 683],'color','w')
subplot(5,5,1),plot(lags,r(:,56));subplot(5,5,2),plot(lags,r(:,57));subplot(5,5,3),plot(lags,r(:,58));subplot(5,5,4),plot(lags,r(:,59));subplot(5,5,5),plot(lags,r(:,60));
subplot(5,5,7),plot(lags,r(:,67));subplot(5,5,8),plot(lags,r(:,68));subplot(5,5,9),plot(lags,r(:,69));subplot(5,5,10),plot(lags,r(:,70));
subplot(5,5,13),plot(lags,r(:,78));subplot(5,5,14),plot(lags,r(:,79));subplot(5,5,15),plot(lags,r(:,80));
subplot(5,5,19),plot(lags,r(:,89));subplot(5,5,20),plot(lags,r(:,90));
subplot(5,5,25),plot(lags,r(:,100))
savefig('PostVSPost')
figure(4)
e = axes;
imagesc(R);
set(e,'YDir','normal');
colormap('jet')
colorbar
savefig('CorrMatrixLittleWindows')
end
