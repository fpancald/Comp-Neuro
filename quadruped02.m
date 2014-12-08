function [h]=quadruped02(a,b,e,g,d,n)
%n number of legs (even), a,b,e,g,d coupling parameters
%can be used with animals with even number of limbs
%n needs to be >1
    function dx = gaitpar(t,x,a,b,e,g,d,n)
        %x(i)=xi, x(i+n)=yi
        for i=1:n
            if mod(i,2)==1
                if i==n
                    dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(2*x(i)-x(1)-x(i-1));
                elseif  i==1
                    dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(2*x(i)-x(i+1)-x(n));
                else
                    dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(2*x(i)-x(i+1)-x(i-1));
                end
            else
                if i==n
                    dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+d*(2*x(i)-x(i-1)-x(1));
                elseif  i==1
                    dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+d*(2*x(i)-x(n)-x(i+1));
                else
                    dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+d*(2*x(i)-x(i-1)-x(i+1));
                end
            end
            dx(i+n)=-x(i);
        end
    end

    function dx=gait(t,x)
        dx=gaitpar(t,x,a,b,e,g,d,n)';
    end

%     options = odeset('RelTol',1e-4,'AbsTol',1e-4*ones(2*n,1));
    [T,X] = ode45(@gait,[0 100],2*rand(2*n,1)-ones(2*n,1));
    
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