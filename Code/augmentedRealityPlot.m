function augmentedRealityPlot()
load('images.mat');
load('cameras.mat');
load('points3D.mat')
load('newbox.mat');

images_name=[];
images=[];

%Finding the output parameters
for i = 1:size(images,1)
    id = images(i,1);
    name = images(i,10);
    images_name = [images_name; id name];
end
images_name = table2cell(images_name);
images = table2cell(images);
%calculating camera parameters and saving
focal = cameras(1,5);
delta_x = cameras(1,6);
delta_y = cameras(1,7);
%calculating K matrix from the camera.txt paratmeters
K = [focal   0    delta_x; ...
       0   focal  delta_y; ...
       0     0       1     ];
   
for index = 1:size(images, 1)
    
    img = imread(strcat('./Picss/', images_name{index, 2}));
    %reading the image parameters from images.txt
    Qw = images{index,2};
    Qx = images{index,3};
    Qy = images{index,4};
    Qz = images{index,5};
    Tx = images{index,6};
    Ty = images{index,7};
    Tz = images{index,8};
    Q  = quaternion([Qw Qx Qy Qz]);
    %finding rotation matrix
    R  = quat2rotm(Q);
    %finding the translation matrix
    T  = [Tx;Ty;Tz];
    %Finding POSE matrix
    Pose = [R, T];

    newBoxCamCoordinates   = Pose*([newbox; ones(1, size(newbox, 2))]);
    newBoxImageCoordinates = K*newBoxCamCoordinates;
    newBoxImageCoordinates = newBoxImageCoordinates(1:2, :)./newBoxImageCoordinates(3, :);
    
    figure; imshow(img); hold on;
   %calculating the Cube coordinates
    drawCube(newBoxImageCoordinates);
       
    hold off;
end
end
