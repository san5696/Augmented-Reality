temp1=dlmread('points3D.txt', ' ', [3 1 13741 3]);

pts = temp1';

threshold = 0.1;
%finding RANSAC
[plane, inliers] = ransacPlane(pts, threshold);
inplane = zeros(size(pts,2),1);
inplane(inliers) = 1;
outliers = (find(inplane==0))';
x_inliers = pts(1,inliers);
y_inliers = pts(2,inliers);
z_inliers = pts(3,inliers);


figure(1)
scatter3(pts(1,inliers),pts(2,inliers), pts(3,inliers),'.','r')
hold on
scatter3(pts(1,outliers),pts(2,outliers), pts(3,outliers),'.','b')

hold off

%plotPlaneAndPoints(pts, plane, inliers);
%Finding inliner and outliner 

origin = mean(pts(:, inliers), 2);
t = [eye(3), -origin];
t = [t; [0, 0, 0, 1]];

index= randperm(size(inliers,2));
p1 = [x_inliers(index(1)), y_inliers(index(1)), x_inliers(index(1))];
p2 = [x_inliers(index(2)), y_inliers(index(2)), x_inliers(index(2))];
p3 = [x_inliers(index(3)), y_inliers(index(3)), x_inliers(index(3))];
normal = cross(p1-p2, p1-p3);

x1 = x_inliers - mean(x_inliers);
y1 = y_inliers - mean(y_inliers);
z1 = z_inliers - mean(z_inliers);

cx = mean(x_inliers);
cy = mean(y_inliers);
cz = mean(z_inliers);

center = [cx cy cz];

Pw = [0 0 0];


X = cross([0 0 1],Z);
X = X/norm(X);

Y = cross(Z,X);
Y = Y/norm(Y);

Z = normal;
Z = Z/norm(Z);

R = [X',Y',Z', [0, 0, 0]'];
R = [R; [0, 0, 0, 1]];
%Dominant plane
pose = R\t;

newpts=zeros(3,size(pts,2));
for i =1:size(pts,2)
    temp2=pose*[pts(:,i);1];
    newpts(:,i)=temp2(1:3);
end


figure(2)
scatter3(newpts(1,inliers),newpts(2,inliers), newpts(3,inliers),'.','r')
hold on
scatter3(newpts(1,outliers),newpts(2,outliers), newpts(3,outliers),'.','b')

alpha = 0.3;
box1 = [1,1,0]*alpha;
box2 = [1,-1,0]*alpha;
box3 = [-1,-1,0]*alpha;
box4 = [-1,1,0]*alpha;
box5 = [1,1,2]*alpha;
box6 = [1,-1,2]*alpha;
box7 = [-1,-1,2]*alpha;
box8 = [-1,1,2]*alpha;

%Drawing the virtual box
draw_box(box1,box2,box3,box4,box5,box6,box7,box8);

newbox1 = (pose\[box1';1]);
newbox1 = newbox1(1:3);
newbox2 = (pose\[box2';1]);
newbox2 = newbox2(1:3);
newbox3 = (pose\[box3';1]);
newbox3 = newbox3(1:3);
newbox4 = (pose\[box4';1]);
newbox4 = newbox4(1:3);
newbox5 = (pose\[box5';1]);
newbox5 = newbox5(1:3);
newbox6 = (pose\[box6';1]);
newbox6 = newbox6(1:3);
newbox7 = (pose\[box7';1]);
newbox7 = newbox7(1:3);
newbox8 = (pose\[box8';1]);
newbox8 = newbox8(1:3);
%plotting the newly formed box on the Dominant plane
figure(3)
scatter3(pts(1,inliers),pts(2,inliers), pts(3,inliers),'.','r')
hold on
scatter3(pts(1,outliers),pts(2,outliers), pts(3,outliers),'.','b')
rotate3d on
draw_box(newbox1,newbox2,newbox3,newbox4,newbox5,newbox6,newbox7,newbox8);

newbox = [newbox1,newbox2,newbox3,newbox4,newbox5,newbox6,newbox7,newbox8];
save 'newbox.mat' 'newbox'

%calculating the 3D to 2D points
augmentedRealityPlot();
