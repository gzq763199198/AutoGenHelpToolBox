function GenSciHelpXML_action()
    handle = findobj("Tag","AutoGenHelpFile");
    close(handle);
    //Preogress Gen Sci Help XML File
    AutoGenSciHelpSet();
endfunction
