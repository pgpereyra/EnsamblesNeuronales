function cosmatrix=cos_angle(matrix);
m=matrix;
[a b]=size(m);
for c=1:b;
 for d=1:b;
  cosmatrix(c,d) = dot(m(:,c),m(:,d))/(norm([m(:,c)])*norm([m(:,d)]));
 end
end
e = axes;
cosmatrix=imagesc(cosmatrix);
set(e,'YDir','normal');
colormap('jet');
c = colorbar;
c.Label.String = 'Similarity index';
xlabel('vector {\it i} (t)'),ylabel('vector {\it i} (t)');
set(gca,'XTick',(0:300:998),'YTick',(0:300:998));
savefig('cosmatrix')
end
