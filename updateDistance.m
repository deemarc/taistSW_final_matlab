function updateDistance(ip,trainRoute,distance)
    url = strcat('http://',ip,':8080/insertdistance?');
    distanceurl = strcat('train_no=',num2str(trainRoute),'&','distance=',num2str(distance));
    url = strcat(url,distanceurl);
    webread(url);
end
