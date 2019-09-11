function corrmatrix=BurstspikingLFP(signal,channel)
signal=signal(channel,:);
%% Set the ttreshold and obtain every value up that treshold

threshold=mean(signal)-std(signal)*2.5;       %define the treshold 2.5 std
Noisefree=find(signal<threshold);              %find everythin up that threshold
Noisefree=signal(Noisefree);                   %obtain that values
fs=25000;
fc= 350;                                       % frecuency cut
Wn= fc/fs;                                     % normalize the frecuency
filt_order= 2;                                 % order filter
[b,a]=butter(filt_order,Wn, 'low');
Noisefree=filter(b,a,Noisefree);               %get the slow component (<350Hz)


%% Find the peaks and the location to detect the busts (500ms frames)
burst=[];
[pks, locs]=findpeaks(-Noisefree);
endfrm = locs(1)+12499; %End point of 1st frame   ;
for j = 1: numel(locs)
       if(j ~= 1)    
        if(locs(j) > endfrm)
            if((locs(j) + 12499) > numel(Noisefree))
                break;    
            else
            disp(['iteracion',num2str(j)])                       
            arr=Noisefree(locs(j):locs(j)+12499); %obtaining every frame 500ms
            burst=[burst;arr];
            endfrm =locs(j-1)+12499;
            end
        end
       else
    arr = Noisefree(locs(j): locs(j)+12499);
    burst=[burst;arr];
    end
end

%% Create frames of 25ms in the burst, save them in a matrix and correlate between
m=[];
m2=[];
window_2=624;
step=624;
for l=1:size(control,1)
    for t=1:step:size(control,2)-window_2;
        segment=control(t:t+window_2);
        segment2=post(t:t+window_2);
        m=[m;segment];
        m2=[m2;segment2];
    end
end
[a, b]=size(m);
for c=1:a
 for d=1:a
     cosmatrix(d,c)= dot(m(c,:),m(d,:))/(norm(m(c,:))*norm(m(d,:)));
 end
end
save('cosmatrix_1.mat','cosmatrix');
end



