function figure4movie( h_fig, position)


width = position(3);
height = position(4);

image_even_flag = 1;
i_image = 1;
while image_even_flag
    
    set( h_fig, 'Position', [ position(1:2) ( width - 0.1*i_image )*[ 1 height/width]])
    frame = getframe( h_fig);
    image_even_flag = sum( mod( size( frame.cdata(:,:,1)), 2));
    
    i_image = i_image + 1;
end



end