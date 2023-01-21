function [u] = tv(u0,lambda,D)

   % u0 --> Image to be inpainted
   % lambda --> Hyperparameter
   % D --> Mask

   if ~exist('lambda')
       lambda = 0.01;
   end

   T = 500; % Run for 500 seconds
   dt = 0.1;  % time step
   a = 0.001;  % Constant to avoid division by zero

   u0 = double(u0);
   u = u0;
   [m,n] = size(u);

   for t = 0:dt:T
       % Computation of derivatives ...
       u_x = (u(:,[2:n,n]) - u(:,[1,1:n-1]))/2; % u_x
       u_y = (u([2:m,m],:) - u([1,1:m-1],:))/2; % u_y
       u_xx = u(:,[2:n,n]) - 2*u + u(:,[1,1:n-1]); % u_xx
       u_yy = u([2:m,m],:) - 2*u + u([1,1:m-1],:); % u_yy

       % u_xy --> Derivative w.r.t 'x' followed by w.r.t 'y' ...
       u_xy = ( u([2:m,m],[2:n,n]) + u([1,1:m-1],[1,1:n-1]) - u([1,1:m-1],[2:n,n]) - u([2:m,m],[1,1:n-1]) ) / 4;

       % Total variation computation ...
       Num = u_xx.*(u_y.^2) - 2*u_x.*u_y.*u_xy + u_yy.*(u_x.^2);
       Den = (u_x.^2 + u_y.^2).^(3/2) + a;

       % Updation in every iteration ...
       u = u + dt*( Num./Den - 2*lambda*(D.*(u-u0)));

       subplot(121); imagesc(u0,[0,255]); title('Original');
       subplot(122); imagesc(u,[0,255]); title(['TV\lambda=',num2str(lambda)]);  xlabel(['t=',num2str(t)]);
       colormap gray;
       drawnow;
end