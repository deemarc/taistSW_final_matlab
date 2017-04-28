function destination = getDestination(ip,trainRoute)
    url = strcat('http://',ip,':8080/getlocation?');
    distanceurl = strcat('train_no=',num2str(trainRoute));
    url = strcat(url,distanceurl);
    data = loadjson(webread(url));
    destination = data.next_station;
end