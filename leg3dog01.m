function [h]=leg3dog01(a,b,e,g,d,k,n)
%n number of legs (even), a,b,e,g,d coupling parameters
%can be used for animal with even number of legs and a missing limb
%n>1
% n=4; dog
%k missing limb
    function dx = gaitpar(t,x,a,b,e,g,d,k,n)
        %x(i)=xi, x(i+n)=yi
        for i=1:n
            if i~=k
                if mod(i,2)==1
                    if i==n
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(1))+d*(x(i)-x(i-1));
                    elseif  i==1
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i+1))+d*(x(i)-x(n));
                    else
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i+1))+d*(x(i)-x(i-1));
                    end
                else
                    if i==n
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i-1))+d*(x(i)-x(1));
                    elseif  i==1
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(n))+d*(x(i)-x(i+1));
                    else
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i-1))+d*(x(i)-x(i+1));
                    end
                end
                dx(i+n)=-x(i);
            else
                dx(k:n:2*n)=0;
            end
        end
    end

    function dx=gait(t,x)
        dx=gaitpar(t,x,a,b,e,g,d,k,n)';
    end
IC=2*rand(2*n,1)-ones(2*n,1);
IC(k:n:2*n,1)=0;
%     options = odeset('RelTol',1e-4,'AbsTol',1e-4*ones(2*n,1),'NonNegative', 1:2*n);
    [T,X] = ode45(@gait,[0 100],IC);
    
    shift=10;
    for j=1:2*n
        for it=1:length(T);
        Y(it,j)=X(it,j)+mod(j-1,n)*shift;
        end
    end
    
%     figure(0)
%     plot(T,X(:,1:n));
    h=figure; 
    plot(T,Y(:,1:n));
%     figure(2)
%     plot(T,X(:,1:n));
%     figure(3)
%     plot(T,Y(:,n+1:2*n));
%     figure(4)
%     plot(T,X(:,n+1:2*n));

end