function [lb,ub] = ProblemDetails(ca)
% ProblemDetails provides the relevant information on the eight problems
% such as the lower bound, upper bound and name of the objective function
% as a function handle
%
%  [lb,ub,fobj] = ProblemDetails(ca)
%  fobj         - function handle of the fitness function
%  lb           - lower bounds (size of 1 x 54) on the decision variables
%  ub           - upper bounds (size of 1 x 54) on the decision variables
%  ca           - integer value between 1 and 8

N = 54;
lb = zeros(1,N);

if ca == 1 || ca == 2 || ca == 5 || ca == 6 || ca == 3 || ca == 4|| ca == 7 || ca == 8
   flag = 1;
else
    flag = 0;
    lb = []; ub = []; 
end

if flag == 1
    h = [270,300,310,290,190,160,160,180,160,360,360,360,360,360,360,200,200,240,400,300,100,100,500,500,1000,360,200,270,270,270,400,300,490,200,540,540,550,590,590,340,50,50,1660,1660,1660,680,680,680,680,50,50,180,500,500];
    ub = h;
else
    display ('--------------------------------------------')
    display ('invalid input, enter a value between 1 to 8')
    display ('--------------------------------------------')
    
end

end




