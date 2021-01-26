%genshin impact 5 star probability simulator
%we know that the probability of the 5 star is 0.6% which is 0.006
five_star_prob=0.006;
up_five_star_prob=0.5;

%the number of trials you want to play with
%I set 180 here to make sure that every user will get 2 five-star results
x=180;
counter=0;
gaurantee_counter=0;
five_star_accumulator=zeros(1,180);
repeater=1000000;
% gaurantee=90;

%detectors
%I design 2 detectors here in this model
%the 5 star detector
%the up-5-star detector
five_star_detector=false;
up_five_star_detector=false;

%we use the Bernoulli Distribution model to apply to this case
%let's simulate that 1million people
for j=1:1:repeater
for i=1:1:x
    counter = counter + 1;
    if counter<90
        result=binornd(1,five_star_prob);
        if result==1 && gaurantee_counter<1
            five_star_result=binornd(1,up_five_star_prob);
            counter=0;
            
            five_star_accumulator(i)=five_star_accumulator(i)+1;
            
            if five_star_result==1
                five_star_detector=true;
                up_five_star_detector=true;
                guarantee_counter=0;
            else
                five_star_detector=true;
                up_five_star_detector=false;
                gaurantee_counter=gaurantee_counter+1;
            end
        elseif result==1 && gaurantee_counter==1
            five_star_detector=true;
            up_five_star_detector=true;
            
            five_star_accumulator(i)=five_star_accumulator(i)+1;
            
            guarantee_counter=0;
            counter=0;
        elseif result==0
            five_star_detector=false;
            up_five_star_detector=false;
        end
        
%if we met the 90 trials        
    elseif counter==90
        if gaurantee_counter<1
            
            five_star_accumulator(i)=five_star_accumulator(i)+1;
            
            five_star_result=binornd(1,up_five_star_prob);
            counter=0;
            if five_star_result==1
                five_star_detector=true;
                up_five_star_detector=true;
                guarantee_counter=0;
            else
                five_star_detector=true;
                up_five_star_detector=false;
                gaurantee_counter=gaurantee_counter+1;
            end
        elseif gaurantee_counter==1
            
            five_star_accumulator(i)=five_star_accumulator(i)+1;
            
            five_star_detector=true;
            up_five_star_detector=true;
            guarantee_counter=0;
            counter=0;
        end
    end
end
counter=0;
gaurantee_counter=0;
end

bar(five_star_accumulator);
title('Simulator');