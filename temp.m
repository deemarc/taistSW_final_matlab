%1= narita
%2 = yamanote
% function station_update()
% global StartStatus;
% global TrainRoute;
% global Narita;
% global Yamanote;
% end
% Train route
% Name of Next Station
% How many blocks left before arrival
% Display Rail Traffic light(Red, Green,blue)
function StationInRoute = getStation(trainRoute)
switch trainRoute
    case 1
        StationInRoute = {'Nartia Airport','Nartia Airport Terminal 2','Narita','Yotsukaido','Chiba','Tokyo','Shinagawa','Shibuya','Shinjuku','Ikebukuro','Omiya'};
    case 2
        StationInRoute = {'Tokyo','Shinagawa','Shibuya','Shinjuku','Ikebukuro','Ueno','Akihabara'};
    otherwise
        StationInRoute = {'None'};
end
end



function UpdateStat(TrainRoute)
url = 'https://sw-final-project-test.appspot.com/getlocation?appid=1';
data = loadjson(webread(url));
global origin;
global destination;
global blockLeft;
global TrafficStatus;
origin = data.start_station;
destination = data.next_station;
blockLeft = data.distance_track;
if RemainingBlock == 0
    station = getStation(TrainRoute);
    origin = destination;
    nextstation = strmatch(origin,station,'exact');
    destination = station(nextstation+1);
    RemainingBlock = 
end
end

