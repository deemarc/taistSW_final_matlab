classdef masterClass
    %MASTERCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        masterState = wtbEnum.init
        timeOutTimer = 0;
        timeOutVal = 3,   %time out after 3 second
        
        wtbHandle = []
        cmdToSend = []
    end
    
    methods
        function obj = init(obj,comName)
            clearCom;
            obj.wtbHandle = wtbCmd;
            obj.wtbHandle.comName = comName;
            obj.wtbHandle = obj.wtbHandle.connect();
            obj = obj.sendScanNetworkMsg();
            %change state to scanNetwork and reset timer
            obj.masterState = wtbEnum.scan;
            obj.timeOutTimer = 0;
            
%             obj.wtbHandle = obj.wtbHandle.scanNetwork();
%             curMsg = wtbMsg.emptyWtbFrame;
%             curMsg.data(1) = 2;

%             obj.wtbHandle = obj.wtbHandle.wtbWrite();
%             obj.wtbHandle = obj.wtbHandle.wtbRead();
%             obj.wtbHandle = obj.wtbHandle.wtbUpdate(wtbEnum.read);
%             obj.wtbHandle = obj.wtbHandle.scanNetwork();
        end
        function obj = cycleTask(obj)
             
%             obj = obj.wtbHandle.read();
%             obj.wtbHandle = obj.wtbHandle.wtbUpdate(wtbEnum.driving);
%             curMsg.dest = obj.wtbHandle.compoTable(3).id;
%             obj.wtbHandle.txBuff{end+1} = wtbMsg.wtb2raw(curMsg);
%             curMsg.dest = obj.wtbHandle.compoTable(4).id;
%             obj.wtbHandle.txBuff{end+1} = wtbMsg.wtb2raw(curMsg);
%             obj.wtbHandle = obj.wtbHandle.wtbWrite();
%             breVal = obj.wtbHandle.compoTable(3).value;
%             acceVal = obj.wtbHandle.compoTable(4).value;
            obj.wtbHandle = obj.wtbHandle.wtbRead(obj.masterState);
            switch(obj.masterState)
                case wtbEnum.scan
                    if isempty(obj.wtbHandle.rxBuff)
                       obj.timeOutTimer =  obj.timeOutTimer + 1;
                       display('time out count up');
                    else
                       obj.timeOutTimer = 0;
                       obj.wtbHandle = obj.wtbHandle.wtbUpdate(obj.masterState);
                    end
                    
                    if obj.timeOutTimer >= obj.timeOutVal
                        if isempty(obj.wtbHandle.chkBuff)
                            obj.masterState = wtbEnum.read;
                            obj.timeOutTimer = 0;
                            %change to read functin state and read function
                            %of all messages ID
                            obj = obj.askAllFunc();
                        else
                            obj = obj.resendNonreplyMsg();
                            obj.timeOutTimer = 0;
                        end
                    end
%                     obj = obj.wtbHandle.read();
%                     obj.wtbHandle = obj.wtbHandle.wtbUpdate(wtbEnum.driving);
%                     obj.wtbHandle = obj.wtbHandle.wtbWrite();
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
                    if isempty(obj.wtbHandle.rxBuff)
                       obj.timeOutTimer =  obj.timeOutTimer + 1;
                       display('time out count up');
                    else
                       obj.timeOutTimer = 0;
                       obj.wtbHandle = obj.wtbHandle.wtbUpdate(obj.masterState);
                    end
                    
                    %if all message has function the we move to next state
                    %else resend after timeout is reach
                    if isempty(obj.wtbHandle.chkBuff)
                        obj.masterState = wtbEnum.driving;
                    elseif  obj.timeOutTimer >= obj.timeOutVal
                        obj = obj.resendNonreplyMsg();
                        obj.timeOutTimer;
                    end

                case wtbEnum.driving
                otherwise
                        error('masterState has enter unknown state');
            end
            
            
        end
        function obj = askAllFunc(obj)
            curMsg = wtbMsg.emptyWtbFrame;
            curMsg.data(1) = 2;
            for i = 2:length(obj.wtbHandle.compoTable)
                curMsg.dest = obj.wtbHandle.compoTable(i).id;
                obj.wtbHandle.txBuff{end+1} = wtbMsg.wtb2raw(curMsg);
            end
            obj.wtbHandle = obj.wtbHandle.wtbWrite();
        end
        function obj = sendScanNetworkMsg(obj)
            scanMsg = wtbMsg.scanNetworkMessage;
            obj.wtbHandle.txBuff{1} = wtbMsg.wtb2raw(scanMsg);
            obj.wtbHandle = obj.wtbHandle.wtbWrite();
        end
        function obj = resendNonreplyMsg(obj)
            obj.wtbHandle.txBuff = obj.wtbHandle.chkBuff;
            obj.wtbHandle.chkBuff = [];
            obj.wtbHandle = obj.wtbHandle.wtbWrite();
        end
        
    
    %%%%%%%%%%%%%%% internal fucntion %%%%%%%%%%%%%%%%%%%%%%%%%%%
        
             

        
    end
end
    

