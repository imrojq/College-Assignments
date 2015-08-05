function [keypoints] = MySIFT(Image)
    Image = double(rgb2gray(Image));
    octave = MyScaleSpace(Image);
    dog = MyDoG(octave);
    keypoints  =MyKeyPointDetect( dog );
    elimKeypoints = MyEliminateKeypoints(keypoints,dog);
    orientation = MyAssignOrientation( octave, elimKeypoints);
    descriptors  =MyKeypointDescriptor( octave,orientation);
    imshow((dog{1,2}));
    hold on; 
    plot(keypoints(:,4),keypoints(:,3),'r+');
end

