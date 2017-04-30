classdef masterClass
    %MASTERCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        masterState = wtbEnum.init
        timeOutCounter = 0;
        timeOut = 3,   %time out after 5 second
        
        wtbHandle = []
        cmdToSend = []
    end
    
    methods
        function obj = init(obj,comName)
            clearCom;
            obj.wtbHandle = wtbCmd;
            obj.wtbHandle.comName = comName;
            obj.wtbHandle = obj.wtbHandle.connect();
            obj.wtbHandle = obj.wtbHandle.scanNetwork();
            curMsg = wtbMsg.emptyWtbFrame;
            curMsg.data(1) = 2;
            for i = 2:length(obj.wtbHandle.compoTable)
                curMsg.dest = obj.wtbHandle.compoTable(i).id;
                obj.wtbHandle.txBuff{end+1} = wtbMsg.wtb2raw(curMsg);
            end
            obj.wtbHandle = obj.wtbHandle.wtbWrite();
            obj.wtbHandle = obj.wtbHandle.wtbRead();
            obj.wtbHandle = obj.wtbHandle.wtbUpdate(wtbEnum.read);
            obj.wtbHandle = obj.wtbHandle.scanNetwork();
        end
        function obj = cycleTask(obj)
            curMsg = wtbMsg.emptyWtbFrame;
            curMsg.data(1) = 3;
            obj = obj.wtbHandle.read();
            obj.wtbHandle = obj.wtbHandle.wtbUpdate(wtbEnum.driving);
            curMsg.dest = obj.wtbHandle.compoTable(3).id;
            obj.wtbHandle.txBuff{end+1} = wtbMsg.wtb2raw(curMsg);
            curMsg.dest = obj.wtbHandle.compoTable(4).id;
            obj.wtbHandle.txBuff{end+1} = wtbMsg.wtb2raw(curMsg);
            obj.wtbHandle = obj.wtbHandle.wtbWrite();
            breVal = obj.wtbHandle.compoTable(3).value;
            acceVal = obj.wtbHandle.compoTable(4).value;
            switch(obj.masterState)
                case wtbEnum.scan
                    obj = obj.wtbHandle.read();
                    obj.wtbHandle = obj.wtbHandle.wtbUpdate(wtbEnum.driving);
                    obj.wtbHandle = obj.wtbHandle.wtbWrite();
%                     if isempty(obj.wtbHandle.rxBuf)
%                         obj.timeOutCounter = obj.timeOutCounter +1;
%                     else
%                         obj = obj.assignId(obj.wtbHandle.rxBuf);
%                         obj.timeOutCounter = 0;
%                     end
%                     
%                     
%                     if obj.timeOutCounter = obj.timeOutCount
%                         tableSize = length(obj.compoTable);
%                         if (tableSize > 1) && (tableSize == obj.idOK)
%                             obj.masterState = wtbEnum.read;
%                             obj.timeOutCounter = 0;
%                         else
%                             error('compoTable is not initiate properly');
%                         end
%                     end
                case wtbEnum.read
                case wtbEnum.driving
                otherwise
                        error('masterState has enter unknown state');
            end
            
            
        end
    
    
    %%%%%%%%%%%%%%% internal fucntion %%%%%%%%%%%%%%%%%%%%%%%%%%%
        
             

        
    end
end
    

