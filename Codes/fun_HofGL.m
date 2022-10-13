function y = fun_HofGL(imgGray)
%����Ϊ�Ҷ�ͼ��
%�������ػҶ�ֱ��ͼ����������ֵ������ֵ�����Ľṹ��

%����Ҷ�ֱ��ͼ
imgHist=imhist(imgGray);%����Ҷ�ֱ��ͼ
L_r=size(imgGray,1);%����������
L_l=size(imgGray,2);%���ص�����
imgHist_Per=(imgHist/(L_r*L_l));%ת��Ϊ�ٷֱ���ʽ
y.imgHist=imgHist_Per;%����

%���㡰�ҶȾ�ֵ��
GrayLevel=0:255;
imgGrayAve=sum(GrayLevel'.*y.imgHist);
y.Ave=imgGrayAve;%����
%���㡰�Ҷȷ��
Aver=mean(GrayLevel);
imgGrayVar=sum((GrayLevel-Aver).^2'.*y.imgHist);
y.Var=imgGrayVar;%����
%���㡰��б�ȡ�
Aver=mean(GrayLevel);
imgGraySkew=imgGrayVar^-1.5*sum((GrayLevel-Aver).^3'.*y.imgHist);
y.Skew=imgGraySkew;%����
%���㡰���Ͷȡ�
GrayLevel=0:255;
Aver=mean(GrayLevel);
imgGrayKur=imgGrayVar^-2*sum((GrayLevel-Aver).^4'.*y.imgHist)-3;
y.Kur=imgGrayKur;%����
%���㡰������
imgGrayEner=sum(y.imgHist.^2);
y.Ener=imgGrayEner;%����

%��������ֵ����
imgEigVec=[imgGrayAve imgGrayVar imgGraySkew imgGrayKur imgGrayEner];
y.eigVec=imgEigVec;
end

