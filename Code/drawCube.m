function drawCube(points)
    
    bottom    = [1, 2, 3, 4];
    top       = [5, 6, 7, 8];
    sideRight = [2, 6, 5, 1];
    sideLeft  = [3, 7, 8, 4];
    back      = [1, 5, 8, 4];
    front     = [2, 6, 7, 3];
    
    cube = [bottom;    top; ...
                 sideRight; sideLeft; ...
                 back;      front];
    
    for i = 1:length(cube)
        edges = cube(i, :);
        rectangle(points(:,edges(1)), points(:,edges(2)), points(:,edges(3)), points(:,edges(4)), i);
    end
    
end

function rectangle(p1, p2, p3, p4, c)
    x = [p1(1) p2(1) p3(1) p4(1)];
    y = [p1(2) p2(2) p3(2) p4(2)];
   
    if length(p1) == 3
        z = [p1(3) p2(3) p3(3) p4(3)];
        fill3(x, y, z, c);
    else
        fill(x,y,c);
    end
end