disp("");
disp("      ---开始加载帮助文档自动生成工具箱---");
global AutoGenHelpToolbox_root;
AutoGenHelpToolbox_root = get_absolute_file_path("loader.sce");
macros_dir = AutoGenHelpToolbox_root + "macros" + filesep();
help_jar_dir = AutoGenHelpToolbox_root + "helpjar" + filesep();
disp("      -------正在加载宏脚本库文件--------");
if isfile(macros_dir+"lib") then
    load(macros_dir+"lib");
    disp("      --------加载宏脚本文件成功！-------");
else
    disp("      --加载宏脚本文件失败: lib 文件不存在!--");
end
disp("      ---------正在加载帮助文档---------");
jar_file = findfiles(help_jar_dir , "*.jar");
if jar_file <> [] then
    add_help_chapter("自动生成帮助文档帮助",help_jar_dir,%F);
    disp("      ---------加载帮助文档成功！-------");
else
    disp("      --加载帮助文档失败 :帮助文件不存在!--");
end
disp("      ---------已全部加载完成！---------");
disp("");
