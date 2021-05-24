function Io=ContourExtraction(Ii)
%ÌáÈ¡ÒºµÎÂÖÀª
    I=imread(Ii);
    I=rgb2gray(I);
    level=graythresh(I);
    I = im2bw(I,level);
    I = ~I;
    I = imfill(I,'holes');
    Io=edge(I);
    imshow(Io);pause(0.5);
end

