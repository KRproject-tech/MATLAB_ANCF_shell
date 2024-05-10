function out = mntimes2( a_mat, b_vec)

a_row = size( a_mat, 1);
b_col = size( b_vec, 2);

if b_col == 1

    b_vec2 = permute( b_vec, [2 1 3 4]);
    b_vec2 = b_vec2(ones(1,a_row),:,:,:);
    
    out = sum( a_mat.*b_vec2, 2);
else
    
    b_vec2 = permute( b_vec, [ 5 1 3 4 2]);

    out = sum( bsxfun( @times, a_mat, b_vec2), 2);    
    out = permute( out, [1 5 3 4 2]);
end

end



