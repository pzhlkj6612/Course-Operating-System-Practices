# Course-Operating-System-Practices

```pwd``` ```ls``` ```awk``` ```cp``` ```mv``` ```ln``` ```echo``` ```whoami``` ```bc``` ```expr``` ```env``` ```export``` ```$()``` ```read``` ```cat``` ```touch``` ```chmod``` ```mkdir``` ```head``` ```tail``` ```grep``` ```find``` ```clear``` ```exit``` ```logout``` ```date``` ```rm -rf /```

Experimentals:

- [Shell Basic](./Experimentals/Shell-Basic)
- [C Language](./Experimentals/C-Language) -- ↓ uncompleted, read and write files with buffer in the loop

``` C
int main(){
	int n;
	char buf[BUFFSIZE];
	while (( n=read(STDIN_FILENO,buf,BUFFSIZE))>0)
	if ( write(STDOUT_FILENO,buf,n)!=n)
	printf("write error\n");
	if (n<0) printf("read error\n");
	return 0;
}
```

Useful tool:

- [Pygments - It is a generic syntax highlighter](http://pygments.org/)

Recommendation:

- [Windows Subsystem for Linux &#8211; The underlying technology enabling the Windows Subsystem for Linux](https://blogs.msdn.microsoft.com/wsl/)
