function [h]=kangaroo01(a,b,e,g,d,n)
%can be used for any animal with even number of limbs and tail used for
%movement
%n number of legs (odd), a,b,e,g,d coupling parameters
%n needs to be >=3
%i=n is the tail
    function dx = gaitpar(t,x,a,b,e,g,d,n)
        %x(i)=xi, x(i+n)=yi
        for i=1:n
            if i~=n
                if mod(i,2)==1
                    if i==n-1
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(1))+d*(x(i)-x(i-1));
                    elseif  i==1
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i+1))+d*(x(i)-x(n-1));
                    else
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i+1))+d*(x(i)-x(i-1));
                    end
                else
                    if i==n-1
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i-1))+d*(x(i)-x(1));
                    elseif  i==1
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(n-1))+d*(x(i)-x(i+1));
                    else
                        dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(x(i)-x(i-1))+d*(x(i)-x(i+1));
                    end
                end
            else
                dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*((n-1)*x(i)-sum(x(1:n-1)));
            end
            dx(i+n)=-x(i);
        end
    end

    function dx=gait(t,x)
        dx=gaitpar(t,x,a,b,e,g,d,n)';
    end

%     options = odeset('RelTol',1e-4,'AbsTol',1e-4*ones(2*n,1),'NonNegative', 1:2*n);
    [T,X] = ode45(@gait,[0 100],2*rand(2*n,1)-ones(2*n,1));
    
    shift=10;
    for j=1:2*n
        for it=1:length(T);
        Y(it,j)=X(it,j)+mod(j-1,n)*shift;
        end
    end
    
%     figure(0)
%     plot(T,X(:,1:n));
    h=figure 
    plot(T,Y(:,1:n));
%     figure(2)
%     plot(T,X(:,1:n));
%     figure(3)
%     plot(T,Y(:,n+1:2*n));
%     figure(4)
%     plot(T,X(:,n+1:2*n));

end