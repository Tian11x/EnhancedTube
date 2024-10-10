function [u, v] = partition_based_algorithm(X_prime, ratio)
    [n, ~] = size(X_prime);
    u = 1; 
    v = 1;
    X_prime=X_prime.^2;
    % Compute initial Sum_tmp and Sum_total
    Sum_tmp = sum(sum(X_prime(1:u,:))) + sum(sum(X_prime(u+1:end, 1:v)));
    Sum_total = sum( sum(X_prime.^2));
    p = Sum_tmp / Sum_total;

    while p < ratio
        Sum_u = Sum_tmp + sum(X_prime(u+1, v+1:end));
        Sum_v = Sum_tmp + sum(X_prime(u+1:end, v+1));
        
        if Sum_u >= Sum_v
            u = u + 1;
            Sum_tmp = Sum_u;
        else
            v = v + 1;
            Sum_tmp = Sum_v;
        end
        
        p = Sum_tmp / Sum_total;
    end
end
