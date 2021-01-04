function draw_box(box1,box2,box3,box4,box5,box6,box7,box8)

surx1 = [box1(1) box2(1) box3(1) box4(1)];
sury1 = [box1(2) box2(2) box3(2) box4(2)];
surz1 = [box1(3) box2(3) box3(3) box4(3)];
fill3(surx1, sury1, surz1, 1);
hold on

surx2 = [box5(1) box6(1) box7(1) box8(1)];
sury2 = [box5(2) box6(2) box7(2) box8(2)];
surz2 = [box5(3) box6(3) box7(3) box8(3)];
fill3(surx2, sury2, surz2, 1);

hold on

surx3 = [box1(1) box5(1) box6(1) box2(1)];
sury3 = [box1(2) box5(2) box6(2) box2(2)];
surz3 = [box1(3) box5(3) box6(3) box2(3)];
fill3(surx3, sury3, surz3, 1);


hold on

surx4 = [box3(1) box7(1) box8(1) box4(1)];
sury4 = [box3(2) box7(2) box8(2) box4(2)];
surz4 = [box3(3) box7(3) box8(3) box4(3)];
fill3(surx4, sury4, surz4, 1);

hold on

surx5 = [box1(1) box4(1) box8(1) box5(1)];
sury5 = [box1(2) box4(2) box8(2) box5(2)];
surz5 = [box1(3) box4(3) box8(3) box5(3)];
fill3(surx5, sury5, surz5, 1);

hold on

surx6 = [box2(1) box3(1) box7(1) box6(1)];
sury6 = [box2(2) box3(2) box7(2) box6(2)];
surz6 = [box2(3) box3(3) box7(3) box6(3)];
fill3(surx6, sury6, surz6, 1);









end