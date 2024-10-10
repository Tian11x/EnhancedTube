function [X] = Seaquential(Matrix,p)

[n,~] = size(Matrix);
omega = floor(n*n*p);
omega1 = floor(n*n*p*0.5);
omega2 = floor(0.5*n*log(n));
Omega = zeros(n,n);
num = 0;
while num<omega1
    pos = randi(n*n);
    row=floor( (pos-1)/n) +1;
    col=mod( (pos-1),n)+1; 
    if Omega(row,col)==1
       continue; 
    end
    Omega(row,col) = 1;
    num = num + 1;
end
X1 = SVT(Matrix.*Omega, 0.1);
Omega2 = Omega;
num2 = 0;
while num2<omega2
    pos = randi(n*n);
    row=floor( (pos-1)/n) +1;
    col=mod( (pos-1),n)+1; 
    if Omega2(row,col)==1
       continue; 
    end
    Omega2(row,col) = 1;
    num2 = num2 + 1;
end
X2 = SVT(Matrix.*Omega2, 0.1);
INF = abs(X1-X2)/(0.5*abs(X1+X2));
while num<omega
   a = max(max(INF));
   if a == 0
        pos = randi(n*n);
        row=floor( (pos-1)/n) +1;
        col=mod( (pos-1),n)+1; 
   else
       [row,col] = find(INF==a);
       row = row;
        col = col;
   end
   if Omega(row, col)==1
      INF(row, col) = 0;
      continue;
   else
      Omega(row,col) = 1;
      num = num + 1;
   end
end
X = SVT(Matrix.*Omega, 0.1);

end

