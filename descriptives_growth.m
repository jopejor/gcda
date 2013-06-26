function [blank,Descriptives] = descriptives_growth(Dat)



%Descriptive statistics for the bioscreen growth curves




% Calculate the blank

blank.mean= mean(Dat(:,size(Dat,2)));

blank.std=std(Dat(:,size(Dat,2)));

blank.cv=blank.std/blank.mean*100;

% Calculate the descriptives

Descriptives.std=zeros(size(Dat,1),3);

Descriptives.means=zeros(size(Dat,1),3);

 i=1;
 
 
for i= 1:size(Dat,1)
     
    
     j=1;
     k=1;
    
    
    
   
    
   for j=1:3

       
    Temp_dat1=Dat(i,(k:k+8))-blank.mean; 
    
    k=k+2;
    
    
    Temp_dat2=Dat(i,(k:k+8))-blank.mean; 
    
    k=k+2;
    
    
    Temp_dat3=Dat(i,(k:k+8))-blank.mean; 
    
    Temp_dat=[Temp_dat1, Temp_dat2,Temp_dat3];
    
    Descriptives.std(i,j)=std(Temp_dat);

    Descriptives.means(i,j)=mean(Temp_dat);
    
    k=k+2;
    
   end

   
   
end

end

