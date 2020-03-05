helpdemos_root_path = get_absolute_file_path("xml2jar_script.sce");
helpdemos_xml_path = helpdemos_root_path + filesep() + "HelpSourceFile" + filesep() + "XmlFiles" + filesep();
helpdemos_titile = "这是这帮助文档的总标题";
helpdemos_jar_path = helpdemos_root_path + filesep() + "jar" + filesep();
//将xml文件转换为jar文件
jar_file = findfiles(helpdemos_jar_path , "*.jar");
if jar_file == [] then
    xmltojar(helpdemos_xml_path , helpdemos_titile , 'zh_CN');
    disp("--------xml转换jar帮助文档成功！--------");
end

//将生成的jar文件加载到Scilab中
ok = add_help_chapter(helpdemos_titile , helpdemos_jar_path , %f);
if ~ok then
    disp("未加载成功！");
else
    disp("加载成功！");
end
