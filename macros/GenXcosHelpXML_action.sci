function GenXcosHelpXML_action()
    handle = findobj("Tag","AutoGenHelpFile");
    close(handle);
    //Preogress Gen Xcos Help XML File
    AutoGenXcosHelpSet();
endfunction
