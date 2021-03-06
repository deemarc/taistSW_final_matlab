function latlng = getLatLng(ip,trainRoute)
    url = strcat('http://',ip,':8080/getlocation?');
    distanceurl = strcat('train_no=',num2str(trainRoute));
    url = strcat(url,distanceurl);
    data = loadjson(webread(url));
    latlng(1) = data.latitude;
    latlng(2) = data.longtitude;
end