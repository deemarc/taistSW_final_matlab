classdef wtbCmd
    %WTBCMD Summary of this class goes here
    %   Detailed explanation goes here
    properties
      comPort,
      comName = 'COM5', %put some initial value
      delay   = 0.2, %delay 100 ms each round
      delayCount = 5 %time out after 500 ms
      compoTable = struct('id',0,'tmpId',0, 'idOk', '0','function',0,'value',0); % init with first idex as master 
      recvBuf, %raw byte recv from com port
      rxBuff = [], %processed wtbMsg from recvBuf
      txBuff = [], %message to be send out
      chkBuff = [], %message that is sent and wait if it is reply properly or not
      
    end
    methods
        function obj = connect(obj)
                obj.comPort = serial(obj.comName,'baudrate',9600,'databits',8, ...
                'parity','none','stopbits',1);
                fopen(obj.comPort);
        end
        function disconnect(obj)
            fclose(obj.comPort);
        end
        function obj = wtbWrite(obj)
            if isempty(obj.comPort)
                obj.txBuff = -1;
            end
            
            for i=1:length(obj.txBuff)
                curMsg = obj.txBuff{i};
                fwrite(obj.comPort,curMsg(1));
                fwrite(obj.comPort,curMsg(2));
                fwrite(obj.comPort,curMsg(3));
                fwrite(obj.comPort,curMsg(4));
                fwrite(obj.comPort,curMsg(5));
                fwrite(obj.comPort,curMsg(6));
                fwrite(obj.comPort,curMsg(7));
                fwrite(obj.comPort,curMsg(8));
                if curMsg(2) ~= 255
                    %if it is not broadcast then we need to check for reply
                    obj.chkBuff{end+1} = obj.txBuff{i};
                end
                pause(obj.delay);
            end
            
            
            
            obj.txBuff = [];
        end
        
        function obj = wtbRead(obj,masterState)
        %return rigid wtb message(only for master) to the caller
            if isempty(obj.comPort)
                error('Com port is not init properly');
            end
            byteSize = get(obj.comPort,{'BytesAvailable'});
            %didn't recevie anything
            if byteSize{1} == 0
                obj.rxBuff = [];
                return;
            end        
            obj.rxBuff = []; %make sure message array is empty
            obj.recvBuf(end+1:end+byteSize{1}) = fread(obj.comPort,byteSize{1});
            obj = byte2QWord(obj);
            obj = filterWtb(obj);
            obj = txCrossCheck(obj,masterState);
        end
%         function obj = scanNetwork(obj)
%             scanMsg = wtbMsg.scanNetworkMessage;
%             obj.txBuff{1} = wtbMsg.wtb2raw(scanMsg);
%             obj = obj.wtbWrite();
%             counter = 0;
%             Condition = true;
%             while Condition
%                % do stuff
%                obj = obj.wtbRead();
%                if isempty(obj.rxBuff)
%                    counter =  counter + 1;
%                    pause(obj.delay); %pause for 10 ms
%                    display('time out count up');
%                else
%                    counter = 0;
%                    obj = obj.assignId();
%                end
%                
%                if ( counter == obj.delayCount) % no msg for 50 ms, t
%                  Condition = false; 
%                end
%   
%             end
%         end
        function obj = assignId(obj)
        % take new message in check wether it is message reply from network scan or set id
        % - reply from scan: check if it is new id or not set Id in compoTables
        % - reply from set ID: set comPotable.idOK and count up idOk
        newMsgArr = obj.rxBuff;
            for i=1:length(newMsgArr)

                curWtbMsg = wtbMsg.raw2wtb(newMsgArr{i});
                dec2hex(curWtbMsg.src)
               
            end
        end

%         function obj = read(obj,type,dest)
%             %assign commom val
%             curWtbMsg = wtbMsg.emptyWtbFram();
%             curWtbMsg.ctrl =  0;
%             curWtbMsg.data(2) = 0;
%             curWtbMsg.dest = dest;
%             switch(type)             
%                 case wtbEnum.cmdTypeFunc
%                     curWtbMsg.data(1) = 2;
%                 case wtbEnum.cmdTypeVal
%                     curWtbMsg.data(1) = 3;
%             end
%             rawByteMsg = wtbMsg.wtb2raw(curWtbMsg);
%             obj.send(rawByteMsg);
%         end
        
        %%%%%%%%%%%%% internal function %%%%%%%%%%%%%
%         function obj = askFunc(obj)
%             noFuncMsg = length(obj.compoTable);
%             %assign commom val
%             for i=2:noFuncMsg
%                 dest = obj.compoTable(i).id;
%                 obj.read(wtbEnum.cmdTypeFunc,dest);
%             end
%             while noFuncMsg>1
%                 obj.recv();
%                 haveFunc = length(obj.recvMsgArr);
%                 for i=1:haveFunc
%                     curMsg = wtbMsg(obj.recvMsgArr{i});
%                     obj.compoTable(curMsg.src + 1).function = ...
%                     curMsg.data(1) + 32*curMsg.data(2);
%                 end
%                 noFuncMsg = noFuncMsg - haveFunc;
%             end
%             
%         end
%         
        function obj = wtbUpdate(obj, masterState)
            for i=1:length(obj.rxBuff)
                curWtbMsg = wtbMsg.raw2wtb(obj.rxBuff{i});
                
                switch(masterState)
                    case wtbEnum.scan
                         if curWtbMsg.data(1) == 1
%                           disp('reply set');
                            % - reply from set: 
                            obj.compoTable(curWtbMsg.data(2)+1).idOk = 1;
                            %   obj.idOK = obj.idOK +1;
                        elseif curWtbMsg.data(1) == 0
                            disp('reply scan')
                            % - reply from set ID: update it in comPotable.idOK and count up idOk
                            obj.compoTable(end+1).id = obj.compoTable(end).id +1;
                            obj.compoTable(end).tmpId = curWtbMsg.src;
                            disp(obj.compoTable(end).id)
                            disp(obj.compoTable(end).tmpId)
                            curWtbMsg.dest = curWtbMsg.src;
                            curWtbMsg.src  = 0;
                            curWtbMsg.ctrl = 1;
                            curWtbMsg.data(1) = 1;
                            curWtbMsg.data(2) = obj.compoTable(end).id;
                            obj.txBuff{1} = wtbMsg.wtb2raw(curWtbMsg);
                            obj = obj.wtbWrite();
                        else
                            warning('recving incorrect response when scanning and assign ID');
                        end

                    case wtbEnum.read
                        obj.compoTable(curWtbMsg.src + 1).function = ...
                        512*curWtbMsg.data(1) + curWtbMsg.data(2);
                    case wtbEnum.driving
                        obj.compoTable(curWtbMsg.src + 1).value = ...
                            512*curWtbMsg.data(1) + curWtbMsg.data(2);
                end
                
            end
        end
        

%         
        function obj = byte2QWord(obj)
        %conver byre array into cell of wtb message
            while length(obj.recvBuf) >= 8
                if obj.recvBuf(1) == hex2dec('7E')
                    obj.rxBuff{end+1} = obj.recvBuf(1:8);
                    if length(obj.recvBuf)>8                       
                        obj.recvBuf = obj.recvBuf(9:end);
                    else
                        obj.recvBuf = [];
                    end 
                else
                    warning('wtb recv incorrect data frame');
                end
            end
        end
        
        function obj = filterWtb(obj)
            %filter out all message that are not send to master
            j=1;
            msgArrFil = [];
            for i=1:length(obj.rxBuff)
                %check Dest Addr which is at byte 2
                if obj.rxBuff{i}(2) == 0
                    msgArrFil{j} = obj.rxBuff{i};
                    j = j +1;
                end
            end
            
            obj.rxBuff = msgArrFil;
        
        end
        
        function obj = txCrossCheck(obj,masterState)
        %check if the transmitted message got reply or not
        %normal case: check Dest Id of sent message with src ID of received
        %             message
        %setId case : need to ckeck with setted Id instead(id will be changed)
        
            for i=1:length(obj.chkBuff)
                
                if masterState == wtbEnum.init || masterState == wtbEnum.scan
                    chkIdx = 7; % setted ID
                else
                    chkIdx = 2; % src ID
                end
                for j=1:length(obj.rxBuff)
                    disp('rxBufId');
                    disp(obj.rxBuff{j}(3));
                   if obj.chkBuff{i}(chkIdx) == obj.rxBuff{j}(3)
                       obj.chkBuff{i} = [];
                       break;
                   end
                end
            end
            if ~isempty(obj.chkBuff)
                emptyCells = cellfun('isempty', obj.chkBuff); 
                obj.chkBuff(emptyCells) = [];
            end
            
        end
        
    end

        
    
end

