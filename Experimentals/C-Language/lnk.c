#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include<stdio.h>
#include<errno.h>
#include<string.h>
#include<limits.h>
#include<time.h>
//#include<stdlib.h>


extern int errno;


int FileOptFailed(char* opt, char* fname){
	printf("Fail to %s: %s, %s\n", opt, fname, strerror(errno));
	return errno;
}


int PrintStat(const char* filepath, int symbolic){
	struct stat file_stat;
	if(symbolic){
		if(-1 == lstat(filepath, &file_stat)){
			return -1;
		}
	}
	else{
		if(-1 == stat(filepath, &file_stat)){
			return -1;
		}
	}
	printf("%s:\n", filepath);
	printf("size:\t%d\n", (int)file_stat.st_size);
	printf("inode:\t%d\n", (int)file_stat.st_ino);
	printf("mode:\t%o\n", file_stat.st_mode);
	printf("device id:\t%d\n", (int)file_stat.st_dev);
	printf("last modified on:\t%s", ctime(&file_stat.st_mtime));

	return 0;
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
	if(-1 != open(file2, O_RDONLY)){
		if(0 == strcmp(file1, file2)){
			printf("The source and destination file names are the same.\n");
		}
		else{
			printf("File: %s existed, I don't want to overwrite it :(\n", file2);
		}
		return -2;
	}
	if(-1 != open(file3, O_RDONLY)){
		if(0 == strcmp(file1, file3)){
			printf("The source and destination file names are the same.\n");
		}
		else{
			printf("File: %s existed, I don't want to overwrite it :(\n", file3);
		}
		return -2;
	}

	if(-1 == link(file1, file2)){
		return FileOptFailed("create link", file2);
	}
	if(-1 == symlink(file1, file3)){
		return FileOptFailed("create symbolic link", file3);
	}

	if(-1 == PrintStat(file2, 0)){
		return FileOptFailed("stat", file2);
	}
	if(-1 == PrintStat(file3, 1)){
		return FileOptFailed("lstat", file3);
	}

	return 0;
 
	// 
}
