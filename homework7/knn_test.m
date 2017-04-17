clc;clear;close all;
load trainingData.mat;
% train data
class_all = [training group];
class_1 = class_all(1:100,[1 2]);
class_2 = class_all(101:200,[1 2]);
% test data
x = -6:0.1:6;y = -6:0.1:6;
test = [0 0];
for x = -6:0.1:6
    for y = -6:0.1:6
        test = [test;[x y]];
    end
end
test = test(2:end,:);
        
% show distributions
figure(1)
scatter(class_1(:,1),class_1(:,2),'b','filled');hold on;
scatter(class_2(:,1),class_2(:,2),'r','filled');hold on;
scatter(test(:,1),test(:,2),'g');
legend('train data class 1','train data class 2','test data');

dis = zeros(size(class_all,1),size(test,1));
% calculate the distance
for i = 1:size(test,1)
    dis(:,i) = sqrt(sum(((test(i,:) - class_all(:,[1 2])).^2),2));
end
dis_sort = sort(dis,1);
% number of neighbour
K = 50;
index = zeros(K,size(test,1));% 5*121
vote = zeros(1,size(test,1));% 1*121
dis_k = dis_sort(1:K,:);

for j = 1:size(test,1)
    for i = 1:K
        index(i,j) = find(dis(:,j) - dis_k(i,j) == 0);
        if index(i,j) - 0.5*size(dis,1) <= 0  % class 1
            vote(j) = vote(j) + 1;
        else     % class 2
            vote(j) = vote(j) - 1;
        end   
    end
    if vote(j) > 0
        vote(j) = 1;
    elseif vote(j) < 0
        vote(j) = 2;
    else
        vote(j) = randi(2,[1 1]);
    end
    
end

test_known = [test vote'];
test_class_1 = test_known(test_known(:,3)==1,[1 2]);
test_class_2 = test_known(test_known(:,3)==2,[1 2]);
figure(2)
scatter(class_1(:,1),class_1(:,2),'b','filled');hold on;
scatter(class_2(:,1),class_2(:,2),'r','filled');hold on;
scatter(test_class_1(:,1),test_class_1(:,2),'b');hold on;
scatter(test_class_2(:,1),test_class_2(:,2),'r');hold on;
legend('train class 1','train class 2','test class 1','test class 2');
r = zeros(200,1);
for i = 1:200
    r(:,i) = sqrt(sum(((test(7343,:) - class_all(:,[1 2])).^2),2));
end
r_sort = sort(r,1);

maxdis = r_sort(K);

rectangle('Position',[test(7343,1)-maxdis,test(7343,2)-...
    maxdis,2*maxdis,2*maxdis],'Curvature',[1 1],'EdgeColor','y','linewidth',1.5);hold on;
scatter(test(7343,1),test(7343,2),'filled','y');
% size(test_class_1,1)
% size(test_class_2,1)
    

