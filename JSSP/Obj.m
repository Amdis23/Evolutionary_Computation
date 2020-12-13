function Fitness = Obj(Pop)

global prob

[nbMachines,nbJobs,duration,release,due,cost] = ProblemData(prob);

Pop = round(Pop);

[NPop,Nx] = size(Pop);

Fitness = NaN(NPop,1);

for p = 1:NPop
    singlesol = Pop(p,:);
    
    x = zeros(nbJobs,nbMachines);
    %Assigning jobs to machines
    for i = 1: nbJobs
        x(i,singlesol(i)) = 1;
    end
    
    % The last nbJobs variables correspond to the start time of the Jobs
    ts = singlesol(Nx-nbJobs+1 : Nx)';
    
    
    prod = duration .* x; % Pim*xim
    
    w = zeros(3,1); % Initilize the constraint violations
    
    %% Constraint 17 in the paper - to check if all of the jobs are completed before their due date
    Ordertimereqd = sum(prod,2);
    Ordertimecomplete = ts + Ordertimereqd;
    Ordertimedelay = due(:) - Ordertimecomplete;
    w(1) = sum(abs(Ordertimedelay((Ordertimedelay<0))));
    
    
    %%% Constraint 19 Horizon constraint.
    MachineTimeReqd = sum(prod,1);
    MaxTimeAvailable = max(due) - min(release);
    dummyvar = MachineTimeReqd - MaxTimeAvailable ;
    w(2) = sum(abs(dummyvar(dummyvar > 0)));
    
    
    %%% Constraint 20
    % no. of orders on each machine
    NOrderMachine = sum(x,1);
    
    for m = 1: nbMachines
        
        % Violation in sequencing can occur only if there is more than one order
        % on a particular machine
        if NOrderMachine(m) > 1
            
            % determine the orders to be processed on machine m
            CurrOrders  = find(x(:,m) == 1);
            
            [~, ind] = sort(ts(CurrOrders));
            
            order_sequence = CurrOrders(ind);
            
            for i = 1: length(CurrOrders)-1
                if ts(order_sequence(i)) > ts(order_sequence(i+1)) - duration(order_sequence(i),m)
                    
                    % indicates that the i+1th order is starting before the
                    % completion of ith order
                    w(3) = w(3) + abs(ts(order_sequence(i)) - ts(order_sequence(i+1)) + duration(order_sequence(i),m));
                end
            end
            
        end
    end
    
    TotalConViolation = sum(w);
    
    if TotalConViolation > 0
        Fitness(p,1) = sum(sum(cost.*x)) + TotalConViolation + sum(max(cost,[],2));
    else
        Fitness(p,1) = sum(sum(cost.*x));
    end
    
end