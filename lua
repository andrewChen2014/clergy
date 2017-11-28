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
			
			
    // (ok) luajit官方性能优化指南和注解
        http://www.cnblogs.com/zwywilliam/p/5992737.html
			// 1.Reduce number of unbiased/unpredictable branches. (减少不可预测的分支代码)
				
			// 2.Use FFI data structures. (如果可以，将你的数据结构用ffi实现，而不是用lua table实现)
				
			// 3.Call C functions only via the FFI. (尽可能用ffi来调用c函数。)
				
			// 4.Use plain 'for i=start,stop,step do ... end' loops. (实现循环时，最好使用简单的for i = start, stop, step do这样的写法，或者使用ipairs，而尽量避免使用for k,v in pairs(x) do)
				
			// 5.Find the right balance for unrolling. (循环展开，有利有弊，需要自己去平衡)
				
			// 6.Define and call only 'local' (!) functions within a module.
				
			// 7.Cache often-used functions from other modules in upvalues. (调用任何函数的时候，保证这个函数是local function，性能会更好)
				
			// 8.Avoid inventing your own dispatch mechanisms. (避免使用你自己实现的分发调用机制，而尽量使用內建的例如metatable这样的机制)
				
			// 9.Do not try to second-guess the JIT compiler. (无需过多去帮jit编译器做手工优化)
				
			// 10.Be careful with aliasing, esp. when using multiple arrays. (变量的别名可能会阻止jit优化掉子表达式，尤其是在使用多个数组的时候。)
				
			// 11.Reduce the number of live temporary variables. (减少存活着的临时变量的数量)
				
			// 12.Do not intersperse expensive or uncompiled operations. (减少使用高消耗或者不支持jit的操作)
    // (ok) Numerical Computing Performance Guide
        http://wiki.luajit.org/Numerical-Computing-Performance-Guide
	// 描述的条条框框，大概了解下，实际在项目里用了才知道

    // (ok) luajit FFI简单使用
    	http://blog.csdn.net/erlang_hell/article/details/52836467
	http://luajit.org/ext_ffi.html
	// 每个例子基本都玩了一遍
	
	



