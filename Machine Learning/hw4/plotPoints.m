function [] = plotPoints(X,Y,w0,w)
figure;
plot(X(Y==1,1),X(Y==1,2),'r*');
hold on;
plot(X(Y==-1,1),X(Y==-1,2),'b*');
iter= -2.5:0.1:2.5;
%x = [iter;iter]';
%y= w0 + x*w';
plot(iter,-(w0 + w(1)*iter)/w(2));
plot(iter,-(w0-1 + w(1)*iter)/w(2),'r');
plot(iter,-(w0+1 + w(1)*iter)/w(2),'r');

end