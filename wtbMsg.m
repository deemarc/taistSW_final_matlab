classdef wtbMsg
    %WTBMSG Summary of this class goes here
    %   Detailed explanation goes here
    
    methods(Static)
        function  wtbMsg = raw2wtb(rawByte)
           wtbMsg = [];
           wtbMsg.header   = rawByte(1);
           wtbMsg.dest     = rawByte(2); 
           wtbMsg.src      = rawByte(3); 
           wtbMsg.ctrl     = rawByte(4); 
           wtbMsg.size     = rawByte(5); 
           wtbMsg.data(1)  = rawByte(6);
           wtbMsg.data(2)  = rawByte(7); 
           wtbMsg.crc      = rawByte(8);
        end
        function rawByte = wtb2raw(wtbMsg)
           rawByte = [];
           rawByte(1)   = wtbMsg.header;
           rawByte(2)   = wtbMsg.dest; 
           rawByte(3)   = wtbMsg.src; 
           rawByte(4)   = wtbMsg.ctrl; 
           rawByte(5)   = wtbMsg.size; 
           rawByte(6)   = wtbMsg.data(1);
           rawByte(7)   = wtbMsg.data(2); 
           rawByte(8)   = wtbMsg.crc;
        end
        function  wtbMsg = emptyWtbFrame()
           wtbMsg = [];
           wtbMsg.header   = hex2dec('7E');
           wtbMsg.dest     = 0; 
           wtbMsg.src      = 0;
           wtbMsg.ctrl     = 0; 
           wtbMsg.size     = 2; 
           wtbMsg.data(1)  = 0;
           wtbMsg.data(2)  = 0; 
           wtbMsg.crc      = 0;
        end
         function  wtbMsg = scanNetworkMessage()
           wtbMsg = [];
           wtbMsg.header   = hex2dec('7E');
           wtbMsg.dest     = hex2dec('FF'); 
           wtbMsg.src      = 0;
           wtbMsg.ctrl     = 0; 
           wtbMsg.size     = 2; 
           wtbMsg.data(1)  = 0;
           wtbMsg.data(2)  = 0; 
           wtbMsg.crc      = hex2dec('FF'); 
        end
        
        
    end
    
end

