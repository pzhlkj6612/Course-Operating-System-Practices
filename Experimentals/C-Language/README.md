# 实验内容

本实验要求在 Linux/Unix 环境下用 C 语言编写三个具体的 shell 命令，基本涉及了 Linux/Unix 文件系统中较为常用的有关文件操作的系统调用。内容如下：

## [copy](./copy.c)

编程实现 copy 命令，执行格式：```copy file1 file2 file3```

功能：将 file1、file2 两文件的内容合并拷入 file3 中，其中间应有30个字节的空洞（调试成功后可将空洞调大到几十 MB ）。

程序执行后用du命令显示其占用磁盘空间，观察其大小，分析原因。

程序可能涉及到的系统调用：read(), write(), open(), creat(), close(), lseek()

## [renam](./renam.c)

编程实现 renam 命令（即 Linux 下的 rename ），功能是实现文件的重命名，执行格式：```renam filea fileb```

其中 filea 为源文件，fileb为目标文件。程序执行时应显示出命令行的所有参数，并给出重命名前后两个文件的大小、索引节点号及最近一次状态改变的时间。

程序可能涉及到的系统调用：read(), write(), open(), stat(), close(), link(), unlink()

## [lnk](./lnk.c)

编程实现 lnk 命令，执行格式：```lnk f1 f2 f3```。具体要求如下：

1. 分别使用 link() 和 symlink() 为文件 f1 创建其硬链接文件 f2 和符号链接文件 f3 。
2. 分别使用 stat() 和 lstat() 调用给出文件 f2 和 f3 大小、索引节点号、权限、存放该文件的设备号及文件修改时间，比较其异同。说明原因。

----

# 有用的

- [c - Where is sys/types.h located? - Stack Overflow](https://stackoverflow.com/questions/11823063/where-is-sys-types-h-located)
- [Section 2: system calls - Linux man pages](https://linux.die.net/man/2/)
- [SSIZE_MAX](https://lists.gnu.org/archive/html/bug-gnulib/2006-06/msg00014.html)
- [gcc - Is bool a native C type? - Stack Overflow](https://stackoverflow.com/questions/1608318/is-bool-a-native-c-type)
