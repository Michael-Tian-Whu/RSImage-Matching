function y = fun_HofGCM(imgGray)
%����Ϊ�Ҷ�ͼ��
%��������4������ĻҶȹ������󡢸�������ֵ�ľ�ֵ�ͷ������ֵ�����Ľṹ��

%����4������ĻҶȹ�������
[glcm] = graycomatrix(imgGray, 'N', 16, 'G', [],'O',[0,1;-1,1;-1,0;-1,-1]); 

%������ֵ���Աȶȡ���ͬ���ԡ�������ء���������
eig = graycoprops(glcm,{'contrast','homogeneity','correlation','energy'});

%������ֵ��ֵ                                                                 
y.ConM=mean(eig.Contrast,2);
y.HomM=mean(eig.Homogeneity,2);
y.CorM=mean(eig.Correlation,2);
y.EnerM=mean(eig.Energy,2);    
%������ֵ����
y.ConS=std(eig.Contrast,0,2)^2;
y.HomS=std(eig.Homogeneity,0,2)^2;
y.CorS=std(eig.Correlation,0,2)^2;
y.EnerS=std(eig.Energy,0,2)^2;      

%��������ֵ����
y.eigVec=[y.ConM,y.HomM,y.CorM,y.EnerM,y.ConS,y.HomS,y.CorS,y.EnerS];    
end

