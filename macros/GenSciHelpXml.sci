function GenSciHelpXml()
    global sciobj;
    global AutoGenHelpToolbox_root;
    //file operation
    parentdir = sciobj.Destdir + filesep();
    //copy sce script file to dest dir
    scriptfile_path = AutoGenHelpToolbox_root + "examples"+filesep()+"tmpFile"+filesep()+"xml2jar_script.sce";
    copyfile(parentdir, scriptfile_path);
    //New FileDir to save Xml File
    xmlpath = parentdir + "HelpSourceFile" + filesep() + "XmlFiles" + filesep();
    mkdir(parentdir + "HelpSourceFile" + filesep(), "XmlFiles");
    savefilepath = xmlpath + sciobj.FunctionName + ".xml";
    //copy chapter file to Genxmlfile
    copyfile(AutoGenHelpToolbox_root+"examples"+filesep()+"tmpFile"+filesep()+"CHAPTER", xmlpath + "CHAPTER");
    // Build xml_doc file
    functionname = sciobj.FunctionName;
    s = "<?xml version=""1.0"" encoding=""UTF-8""?>"+...
        "<refentry xml:id="""+functionname+""" xml:lang=""zh"">"+...//1
            "<refnamediv>"+...//1-1
                "<refname>"+sciobj.FunctionName+"</refname>"+...//1-1-1
                "<refpurpose>"+sciobj.Overview+"</refpurpose>"+...//1-1-2
            "</refnamediv>"+...
            "<refsynopsisdiv>"+...//1-2
                "<title>调用格式</title>"+...
                "<synopsis>"+sciobj.Syntax+"</synopsis>"+...
            "</refsynopsisdiv>"+...
            "<refsection>"+...//1-3
                "<title>参数说明</title>"+...//1-3-1
                "<variablelist>"+...//1-3-2    1-3-2-1
                "</variablelist>"+...
            "</refsection>"+...
            "<refsection>"+...//1-4
                "<title>详细描述</title>"+...
                "<para>"+sciobj.Detailed+"</para>"+...
            "</refsection>"+...
            "<refsection role=""see also"">"+...
                "<title>参见</title>"+...
                "<simplelist type=""inline"">"+...
                    "<member>"+...
                        "<link linkend="""+sciobj.SeeAlso+""">"+sciobj.SeeAlso+"</link>"+...
                    "</member>"+...
                "</simplelist>"+...
            "</refsection>"+...
        "</refentry>";
    doc = xmlReadStr(s);

    if sciobj.Input == "0" && sciobj.Output == "0" then    //无输入输出
        inNode = xmlElement(doc,"varlistentry");
        inNodeChild1 = xmlElement(doc,"listitem");
        inNodeChild1Child1 = xmlElement(doc,"para");
        inNodeChild1Child1.content = "无";
        doc.root.children(3).children(2).children(1) = inNode;
        doc.root.children(3).children(2).children(1).children(1) = inNodeChild1;
        doc.root.children(3).children(2).children(1).children(1).children(1) = inNodeChild1Child1;
    else
        for i = 1:strtod(sciobj.Input)
            inNode = xmlElement(doc,"varlistentry");
            inNodeChild1 = xmlElement(doc,"term");
            inNodeChild1.content = sciobj.ParamsData.Name(i);
            inNodeChild2 = xmlElement(doc,"listitem");
            inNodeChild2Child1 = xmlElement(doc,"para");
            inNodeChild2Child1.content = sciobj.ParamsData.Dim1(i)+"×"+sciobj.ParamsData.Dim2(i)+"      "+...
                                   sciobj.ParamsData.Type(i)+"      "+sciobj.ParamsData.Details(i);
            doc.root.children(3).children(2).children(i) = inNode;
            doc.root.children(3).children(2).children(i).children(1) = inNodeChild1;
            doc.root.children(3).children(2).children(i).children(2) = inNodeChild2;
            doc.root.children(3).children(2).children(i).children(2).children(1) = inNodeChild2Child1;
        end
        for i = 1:strtod(sciobj.Output)
            inNode = xmlElement(doc,"varlistentry");
            inNodeChild1 = xmlElement(doc,"term");
            inNodeChild1.content = sciobj.ParamsData.Name(strtod(sciobj.Input)+i);
            inNodeChild2 = xmlElement(doc,"listitem");
            inNodeChild2Child1 = xmlElement(doc,"para");
            inNodeChild2Child1.content = sciobj.ParamsData.Dim1(strtod(sciobj.Input)+i)+"×"+...
                                         sciobj.ParamsData.Dim2(strtod(sciobj.Input)+i)+"      "+...
                                         sciobj.ParamsData.Type(strtod(sciobj.Input)+i)+"      "+...
                                         sciobj.ParamsData.Details(strtod(sciobj.Input)+i);
            doc.root.children(3).children(2).children(strtod(sciobj.Input)+i) = inNode;
            doc.root.children(3).children(2).children(strtod(sciobj.Input)+i).children(1) = inNodeChild1;
            doc.root.children(3).children(2).children(strtod(sciobj.Input)+i).children(2) = inNodeChild2;
            doc.root.children(3).children(2).children(strtod(sciobj.Input)+i).children(2).children(1) = inNodeChild2Child1;
        end
    end
    
    xmlDump(doc);
    xmlWrite(doc,savefilepath,%t);
    if sciobj.DemofileContent <> "0" then
        details = fileinfo(savefilepath);
        [fd, err] = mopen(savefilepath,"r");
        source_str = mgetl(fd);
        mclose(fd);
        dest_str = source_str;
        for i = 1:9
            dest_str(size(source_str,1)-i+1) = [];
        end
        format_str_before = ["<refsection>";"<title>示例</title>";"<programlisting role=""example""><![CDATA["];
        format_str_after = ["]]></programlisting>";"</refsection>"];
        dest_str = [dest_str; format_str_before];
        dest_str = [dest_str; sciobj.DemofileContent'];
        dest_str = [dest_str; format_str_after];
        for i = 1:9
            dest_str = [dest_str;source_str(size(source_str,1)-9+i)];
        end
        [fd, err] = mopen(savefilepath,"w");
        mputl(dest_str, fd);
        mclose(fd);
    end
    disp("生成sci函数帮助文档成功！");
    disp(sciobj.FunctionName + ".xml" + "文件保存位置为:");
    disp("    " + xmlpath);
    //TODO:善后操作
    xmlDelete(doc);
    clearglobal sciobj;
    clearglobal bOK;
    clearglobal Stop;
endfunction
