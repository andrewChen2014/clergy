// luajit
	  // luajit编译
		    // windows
			      打开vs x64兼容命令行
			      cd 到 luajit 里的src目录
			      设置64位 setenv /release /x64
			      编译静态lib库
			      msvcbuild.bat static
			      // 修改 使带符号(修改msvcbuild.bat)
				        @set LJPDBNAME="lua51"

				        @rem 添加调试信息 add by andrew 20171127
				        %LJCOMPILE% /Zi /Fd%LJPDBNAME% lj_*.c lib_*.c

    // C/C++，VS下使用luajit(环境配置)
        http://blog.csdn.net/dugaoda/article/details/50423934
    // 用好Lua+Unity，让性能飞起来—LuaJIT性能坑详解
        http://blog.csdn.net/uwa4d/article/details/72916830
    // luajit官方性能优化指南和注解
        http://www.cnblogs.com/zwywilliam/p/5992737.html
    // Numerical Computing Performance Guide
        http://wiki.luajit.org/Numerical-Computing-Performance-Guide






