function out = mntimes2_fast( a_mat, b_vec)

if size( b_vec, 5) == 1
    %% dx^n_Sc_mat_v*q_vec ‚ÌŒvZ
    out = sum( a_mat.*b_vec, 2);
else
    %% dx^n_Sc_mat_v2*q_vec ‚ÌŒvZ 
    out = sum( a_mat.*b_vec, 2);
    out = permute( out, [1 5 3 4 2]);
end

end



