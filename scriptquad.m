close all
a=[1 1 1 1 1 1 1 1];
b=[2 2 0 2 0 0 0 2];
g=[-0.5 1 0.02 -0.5 0.5 0.01 2 -0.5];
d=[-0.5 1 0.02 -0.7 0.7 2 0.01 1];
e=[0.5 0.5 1 0.5 0.1 0.1 0.1 0.5];
for i=1:length(a)

% h=quadruped02(a(i),b(i),e(i),g(i),d(i),4);
% plotFileName = ['Plot_a_',num2str(a(i)),'_b_',num2str(b(i)),'_e_',num2str(e(i)),'_g_',num2str(g(i)),'_d_',num2str(d(i)),'quad.jpg'];
% print(h,'-dpng',plotFileName)
h=starfish01(a(i),b(i),e(i),g(i),d(i),5);
plotFileName = ['Plot_a_',num2str(a(i)),'_b_',num2str(b(i)),'_e_',num2str(e(i)),'_g_',num2str(g(i)),'_d_',num2str(d(i)),'star.jpg'];
print(h,'-dpng',plotFileName)
end