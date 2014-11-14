function quadruped02(a,b,e,g,d,n)
%n number of legs (even), a,b,e,g,d coupling parameters
    function dx = gaitpar(t,x,a,b,e,g,d,n)
        %x(i)=xi, x(i+n)=yi
        for i=1:n
            if mod(i,2)==1
                dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+g*(2*x(i)-x(i+1)-x(n-i+1));
                dx(i+n)=-dx(i);
            else
                dx(i)=x(i+n)-a*x(i)*(x(i)^2/3-1)+b+e*x(i)^2+d*(x(i)-x(i-1)-x(n-i+1));
                dx(i+n)=-dx(i);
            end
        end
    end
    function dx=gait(t,x)
        dx=gaitpar(t,x,a,b,e,g,d,n)';
    end
    options = odeset('RelTol',1e-4,'AbsTol',1e-4*ones(2*n,1));
    [T,X] = ode45(@gait,[0 200],[ones(n,1);zeros(n,1)]);
    shift=0.1;
    for j=1:n
        for it=1:length(T);
        Y(it,j)=X(it,j)+(j-1)*shift;
        end
    end
%     plot(T,X(:,1:n));
    plot(T,Y);
    

end