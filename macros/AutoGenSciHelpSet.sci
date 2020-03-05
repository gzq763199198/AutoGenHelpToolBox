function [Ack] = AutoGenSciHelpSet()
    global bOK;
    global sciobj;
    Ack = %f;
    SciDesSet();
    if(bOK) then
        setsize = strtod(sciobj.Input);
        for i = 1 : setsize
            SciParamSet("Input",i);
            if ~bOK then
                disp("在第"+string(i)+"个输入参数时退出.");
                return;
            end
        end
    else
        disp("退出帮助文档自动生成流程.");
        return;
    end
    if(bOK) then
        setsize = strtod(sciobj.Output);
        for i = 1 : setsize
            SciParamSet("Output",i);
            if ~bOK then
                disp("在第"+string(i)+"个输出参数时退出.");
                return;
            end
        end
    else
        disp("退出帮助文档自动生成流程.");
        return;
    end
    GenSciHelpXml();
    Ack = %t;
endfunction

