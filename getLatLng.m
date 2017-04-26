function latlng = getLatLng(trainRoute)
    url = 'https://sw-final-project-test.appspot.com/getlocation?appid=1';
    data = loadjson(webread(url));
    latlng(1) = data.latitude;
    latlng(1) = data.longtitude;
end