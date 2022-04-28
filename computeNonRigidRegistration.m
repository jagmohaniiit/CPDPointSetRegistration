
%Load Points
sourcePoints=importdata(char('\\gvk-imt-ts-01.win.ntnu.no\filestorage\nbl-users\Jag_Mohan\IJCB2021-3DMorphing\SOTAComparisonCodeBase\PyCPDCode\bunny_source.txt'));
targetPoints=importdata(char('\\gvk-imt-ts-01.win.ntnu.no\filestorage\nbl-users\Jag_Mohan\IJCB2021-3DMorphing\SOTAComparisonCodeBase\PyCPDCode\bunny_target.txt'));

%Compute Non-Rigid Registration
transformedTarget=NonRigidRegistration(sourcePoints,targetPoints,0.97,0.5,0.5);
ptCloud1=pointCloudDSFrom3DPoints(sourcePoints);
ptCloud2=pointCloudDSFrom3DPoints(targetPoints);
ptCloud3=pointCloudDSFrom3DPoints(transformedTarget);


figure(1);
pcshowpair(ptCloud1,ptCloud2,'VerticalAxis','Y','VerticalAxisDir','Down')
title('Initial Alignment')
xlabel('X(m)')
ylabel('Y(m)')
zlabel('Z(m)')

figure(2);
pcshowpair(ptCloud1,ptCloud3,'VerticalAxis','Y','VerticalAxisDir','Down')
title('Non Rigid Alignment')
xlabel('X(m)')
ylabel('Y(m)')
zlabel('Z(m)')