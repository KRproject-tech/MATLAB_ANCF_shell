function test_mntimes()
%% Purpose:
%  Test out the N-D matrix multiplication by providng different test cases
%  and ensuring consistency with the mtimes functionality.
%
%% Revision History:
%  Darin C. Koblick             Initial Release              (c) 06/29/2014
%% ------------------------ Begin Code Sequence ---------------------------

%% Start Test Sequence for 2-D, 3-D, and 4-D matrix multiplication
incr=0;
for thisDim5=1:5
for thisDim4=1:5
    for thisCase=1:5
        incr = incr+1;
        fprintf(1,'%s\n',[mfilename,' :: ','---------- Test Case ',num2str(incr),' ----------']);
        for thisTest = 1:5
            ArowSize = ceil(rand(1).*10)+1;
            A = randn(ArowSize,ArowSize);
            B = randn(ArowSize,ArowSize);
            Z = mntimes(repmat(A,[1 1 thisCase thisDim4 thisDim5]), ...
                repmat(B,[1 1 thisCase thisDim4 thisDim5]),1,2,1,2);
            compare2Dsol(A,B,Z(:,:,1));
            for thisDim2=1:size(B,2)
                C = B(:,1:thisDim2);
                Z = mntimes(repmat(A,[1 1 thisCase thisDim4 thisDim5]), ...
                    repmat(C,[1 1 thisCase thisDim4 thisDim5]),1,2,1,2);
                compare2Dsol(A,C,Z(:,:,1));
            end
            for thisDim1=1:size(A,1)
                C = A(1:thisDim1,:);
                Z = mntimes(repmat(C,[1 1 thisCase thisDim4 thisDim5]), ...
                    repmat(B,[1 1 thisCase thisDim4 thisDim5]),1,2,1,2);
                compare2Dsol(C,B,Z(:,:,1));
            end
        end
    end
end
end



end

function compare2Dsol(A,B,Z)
sol = A*B;
if all(abs(sol(:) - Z(:)) < 1e-12)
   fprintf(1,'%s\n',[mfilename,' :: Test Passed']); 
else
   fprintf(2,'%s\n',[mfilename,' :: Test Failed']); 
   userInpt = input('Press any key to continue ...'); %#ok<NASGU>
end

end