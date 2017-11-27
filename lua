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

    // ffi 倒是可以关注下

    // (ok) C/C++，VS下使用luajit(环境配置)
        http://blog.csdn.net/dugaoda/article/details/50423934
	
    // (ok) 用好Lua+Unity，让性能飞起来—LuaJIT性能坑详解
		// 一、LuaJIT 模式
				// JIT模式
					直接将代码编译成机器码级别执行，效率大大提升
				// Interpreter模式
					事实上这个模式跟原生Lua的原理是一样的，就是并不直接编译成机器码，而是编译成中间态的字节码（bytecode），
					然后每执行下一条字节码指令，
			// 二、JIT模式一定更快？不一定！
				LuaJIT使用了一个很特殊的机制（也是其大坑），叫做trace compiler的方式，来将代码进行JIT编译的。
				// 总结
					第一，Interpreter模式是必须的，无论平台是否允许JIT，都必须先使用Interpreter执行；
					第二，并非所有代码都会JIT执行，仅仅是部分代码会这样，并且是运行过程中决定的。
			// 三、 要在安卓下发挥JIT的威力，必须要解决掉JIT模式下的坑：JIT失败
				一个大坑：LuaJIT无法保证所有代码都可以JIT化，并且这点只能在尝试编译的过程中才知道。
				// 3.1 可供代码执行的内存空间被耗尽->要么放弃JIT，要么修改LuaJIT的代码
					
				// 3.2 寄存器分配失败->减少local变量、避免过深的调用层次
					
				// 3.3 调用c函数的代码无法JIT->使用ffi，或者使用2.1.0beta2
					2.1.0beta2开始正式引入了trace stitch，可以将调用c的lua代码独立起来，将其他可以jit的代码jit掉，
					不过根据作者的说法，这个优化效果依然有限。
				// 3.4 JIT遇到不支持的字节码->少用for in pairs，少用字符串连接
			// 四、怎么知道自己的代码有没有JIT失败？使用v.lua
				完整的LuaJIT的exe版本都会带一个JIT目录，下面有大量LuaJIT的工具,其中有一个v.lua，这是LuaJIT Verbose Mode
			// 五、照着LuaJIT的偏好来写Lua代码
				如何在写Lua的时候，根据LuaJIT的特性，按照其喜好的方式来写，获得更好的性能
			// 六、如果可以，用传统的local function而非class的方式来写代码
				目前主流的Lua面向对象实现都依赖metatable来调用成员函数
			// 七、不要过度使用C#回调Lua，这非常慢
				目前LuaJIT官方文档（ffi的文档）中建议优先进行Lua调用c，而尽可能避免c回调Lua。
			// 八、借助ffi，进一步提升LuaJIT与C/C#交互的性能
				ffi是LuaJIT独有的一个神器，用于进行高效的LuaJIT与C交互。其原理是向LuaJIT提供C代码的原型声明，
				这样LuaJIT就可以直接生成机器码级别的优化代码来与C交互，不再需要传统的Lua API来做交互。
			// 九、既然LuaJIT坑那么多那么复杂，为什么不用原生Lua？
			
			
    // luajit官方性能优化指南和注解
        http://www.cnblogs.com/zwywilliam/p/5992737.html
    // Numerical Computing Performance Guide
        http://wiki.luajit.org/Numerical-Computing-Performance-Guide






