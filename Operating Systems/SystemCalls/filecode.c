#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

void createFile(char *filename)
{
	int file_descriptor;
	file_descriptor=creat(filename,S_IREAD | S_IWRITE);		//Creates the file with only read and write permissions
	if(file_descriptor==-1)
		printf("Creating the file was Unsuccesful\n");
	else
		printf("File creation was succesful\n");
	close(file_descriptor);
}


void deleteFile(char *filename)
{
	int s;
	s=unlink(filename);							//Deletes the file
	if(s==0)
		printf("Deletion of the file succesfull\n");
	else
		printf("Deletion unsuccesfull\n");
}
	
void openFile(char *filename)
{
	int file_descriptor;
	file_descriptor=open(filename,O_RDONLY);			//Opens the file with read mode
	if(file_descriptor==-1)
		printf("Opening the file was Unsuccesful\n");
	else
		printf("File opening was succesful\n");
	close(file_descriptor);
}

void writeFile(char *filename)
{
	creat(filename,S_IWRITE| S_IREAD);
	int file_descriptor=open(filename,O_WRONLY);			//Opens the file with write mode
	char towrite[100]="This is a random string";
	write(file_descriptor,towrite,strlen(towrite));
	close(file_descriptor);									//Close the file of a given file descriptor
}

void reposition(int file_descriptor,int offset)
{
	lseek(file_descriptor,offset,SEEK_SET);					//repositions the pointer
}



void readFile(char *filename)
{
	int file_descriptor=open(filename,O_RDONLY);		//opens the file in the read only mode
	if(file_descriptor==-1)
	{
		printf("Opening the file was Unsuccesful\n");
		return;
	}
	else
	{
		char toread[80];
		int offset;
		printf("Enter the offset");
		scanf("%d",&offset);
		reposition(file_descriptor,offset);		//Changes the pointer by a given offset
		read(file_descriptor,toread,100);		//Reads the given number of character from the file
		printf("%s\n",toread);
		close(file_descriptor);
	}
}



int main()
{
	char filename[20];
	char choice[20];
	while(1){
	printf("Enter the file name on which operation has to be done :");
	scanf("%s",filename);
	printf("Enter the operation among create,delete,open,read,write,attributes,exit\n");
	scanf("%s",choice);
	if(strcmp(choice,"create")==0)
		createFile(filename);
	else if(strcmp(choice,"delete")==0)
		deleteFile(filename);
	else if(strcmp(choice,"open")==0)
		openFile(filename);
	else if(strcmp(choice,"read")==0)
		readFile(filename);
	else if(strcmp(choice,"write")==0)
		writeFile(filename);
	else
		exit(0);
	printf("\n\n\n\n");
	}
	return 0;

}
