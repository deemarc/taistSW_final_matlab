function origin = getOrigin(trainRoute)
    url = 'https://sw-final-project-test.appspot.com/getlocation?appid=1';
    data = loadjson(webread(url));
    origin = data.start_station;
end