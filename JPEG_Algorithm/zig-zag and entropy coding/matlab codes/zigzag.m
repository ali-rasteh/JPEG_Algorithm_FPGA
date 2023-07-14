function [ output ] = zigzag( input )
    
current_x=1;
current_y=1;
direction=1;
index=1;

output = zeros(64,1);

for current_x = 1:1:8
    for current_y=1:1:8
        
        
        if (current_x==1)
            if(current_y==1)
                current_x=current_x+1;
            elseif(current_y<8)
                if(direction==1);
                    current_y=current_y+1;
                    direction=0;
                else
                    current_x=current_x+1;
                    current_y=current_y-1;
                end
            else
                current_x=current_x+1;
            end
        elseif(current_x==8)
            if(current_y<8)
                if(direction==0)
                    current_y=current_y+1;
                    direction=1;
                else
                    current_x=current_x-1;
                    current_y=current_y+1;
                end
            end
        elseif(current_y==1)
            if(direction==0)
                current_x=current_x+1;
                direction=1;
            else
                current_x=current_x-1;
                current_y=current_y+1;
            end
        elseif(current_y==8)
            if (current_x<8)
                if(direction==1)
                    current_x=current_x+1;
                    direction=0;
                else
                    current_x=current_x+1;
                    current_y=current_y-1;
                end
            end
        elseif(direction ==0)
            current_x=current_x+1;
            current_y=current_y-1;
        else
            current_x=current_x-1;
            current_y=current_y+1;
        end
        index = 8*current_y + current_x;
        output(index) = input(current_y , current_x);
 
    end
end


end

