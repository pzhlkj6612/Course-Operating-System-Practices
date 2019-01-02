#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include<stdio.h>
#include<errno.h>
#include<string.h>
#include<limits.h>
//#include<stdlib.h>


#define BUF_SIZE 1024


extern int errno;


int FileOptFailed(char* opt, char* fname){
	printf("Fail to %s: %s, %s\n", opt, fname, strerror(errno));
	return errno;
}


int main(int argc, char* argv[]){
	if(argc != 4){
		printf("%s\n", "Not enough arguments");
		return -1;
	}

	char* file1 = argv[1];
	char* file2 = argv[2];
	char* file3 = argv[3];

	int fd_f1, fd_f2, fd_f3;

	if(-1 == (fd_f1 = open(file1, O_RDONLY))){
		return FileOptFailed("open", file1);
	}
	if(-1 == (fd_f2 = open(file2, O_RDONLY))){
		return FileOptFailed("open", file2);
	}
	if(-1 != open(file3, O_RDONLY)){
		if(0 == strcmp(file1, file3) || 0 == strcmp(file2, file3)){
			printf("The source and destination file names are the same.\n");
		}
		else{
			printf("File: %s existed, I don't want to overwrite it :(\n", file3);
		}
		return -2;
	}
	if(-1 == (fd_f3 = creat(file3, O_CREAT | 00644))){
		return FileOptFailed("create", file3);
	}

	char buf_f1[BUF_SIZE];// enough?
	char buf_f2[BUF_SIZE];

	int size_f1, size_f2;

	if(-1 == (size_f1 = read(fd_f1, buf_f1, BUF_SIZE))){
		return FileOptFailed("read", file1);
	}
	if(-1 == (size_f2 = read(fd_f2, buf_f2, BUF_SIZE))){
		return FileOptFailed("read", file2);
	}
	close(fd_f1);
	close(fd_f2);

	off_t cur_offset;
	off_t hole_size = 666233;
	if(-1 == write(fd_f3, buf_f1, size_f1)){
		return FileOptFailed("write", file3);
	}
	if(-1 == (cur_offset = lseek(fd_f3, hole_size, SEEK_END))){
		return FileOptFailed("change offset", file3);
	}
	if(-1 == write(fd_f3, buf_f2, size_f2)){
		return FileOptFailed("write", file3);
	}
	close(fd_f3);

	return 0;
 
	// 
}
