function [Ack] = AutoGenXcosHelpSet()
    global bOK;
    global xcosobj;
    Ack = %f;
    XcosDesSet();
    if(bOK) then
        setsize = strtod(xcosobj.Input);
        for i = 1 : setsize
            XcosParamSet("Input",i);
            if ~bOK then
                disp("在第"+string(i)+"个输入设置时退出.");
                return;
            end
        end
    else
        disp("退出帮助文档自动生成流程.");
        return;
    end
    if(bOK) then
        setsize = strtod(xcosobj.Output);
        for i = 1 : setsize
            XcosParamSet("Output",i);
            if ~bOK then
                disp("在第"+string(i)+"个输出设置时退出.");
                return;
            end
        end
    else
        disp("退出帮助文档自动生成流程.");
        return;
    end
    if(bOK) then
        setsize = strtod(xcosobj.Params);
        for i = 1 : setsize
            XcosParamSet("Params",i);
            while(bOK == ""),
            end
            if ~bOK then
                disp("在第"+string(i)+"个参数设置时退出.");
                return;
            end
        end
    else
        disp("退出帮助文档自动生成流程.");
        return;
    end
    GenXcosHelpXml();
    Ack = %t;
endfunction

