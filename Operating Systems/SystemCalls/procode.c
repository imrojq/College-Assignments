#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>


void  signalHandler(int);     

void  signalHandler(int sig)
{
	printf("\nReceived a termination signal from process with pid = %d\n",getpid());
	kill(getpid(),1);						//kills the process
}
              
void execute()
{
	char executable[20];
	printf("Enter the name of the executable :");
	scanf("%s",executable);
	execl(executable,executable, (char *) 0);	//opens a new process
}

void getProcessAttributes(id)
{
	pid_t pd=getpid();
	printf("%dst Child process running with process id=%d\n",id,pd);
	printf("%dst Child process running with parent process id=%d\n",id,getppid());
	printf("%dst Child process running with group process id=%d\n",id,getpgid(pd));
	printf("%dst Child process running with niceness=%d\n\n",id,nice(0));
}

void setProcessAttributes()
{
	setpgid(getpid(),0);
	int increment=5,ret;
	ret=nice(increment);			//increments the niceness of the process

}
	
	

void childProcess(int id)
{
	
	signal(SIGTERM, signalHandler); 
	pid_t pd=getpid();
	getProcessAttributes(id);
	int i,j,k,lim_i=rand()%1000,lim_j=rand()%1000;   //random interations for a process to do some work
	for(i=0;i<lim_i;i++){
		for(j=0;j<lim_j;j++)
			k=0;}
	raise(SIGTERM);				//process terminated using kill by raising termination signal
	//exit(0);					//process can be terminated by exit also
	//abort();					//process can be terminated by abort also
}	


void allocDealloc()
{
	int *p=sbrk(sizeof(int));			//allocates memory to variable p
	*p=30;
	printf("%d",*p);	
	brk(p);								//deallocates memory
//	printf("%d",*p);
	exit(0);
}
	

void parentProcess()
{
	pid_t pd=getpid();
	printf("Parent process running with pid=%d\n\n",pd);
	
	int i,j,k;
	for(i=0;i<10000;i++){
		for(j=0;j<10000;j++)
			k=0;}
}	

int wait_for_time(int t){
struct timespec t1, t2;
   t1.tv_sec = t;
   t1.tv_nsec = 5000;
   if(nanosleep(&t1 , &t2) < 0 )   
   {
      printf("sleep failed \n");
      return 0;
   }
   printf("sleep successfull \n"); 
   return 1;
}

int main()
{
	//allocDealloc();					//The function for allocation and deallocation is there but not used
	srand(time(NULL));
	pid_t pd1,pd2,pd;	
	char choice[10];
	int variable=0,status;
	pd1=fork();							//First child Process
	if (pd1<0)
		printf("Forking process failed\n");
	else if (pd1==0)
		childProcess(1);
		
	pd2=fork();							//Second child Process
	if (pd2<0)
		printf("Forking process failed\n");
	else if (pd2==0)
		childProcess(2);
	parentProcess();
	pd=wait(&status);					//Waits for any of the two child process to finish 
	printf("Parent detects child process %d was done first\n",pd);
	pd=wait(&status);					//Waits for second process to finish
	printf("Parent detects child process %d is done \n",pd);
	printf("Parent exits\n");
	wait_for_time(1);					//Wait for a given time
	printf("Do you want to execute any file yes or no\n");
	scanf("%s",choice);
	if (strcmp(choice,"yes")==0) 
	{
		printf("The program is moving over to executing another binary\n");		//executes another file
		execute();
	}
	else
	{
		printf("That's all");
		exit(0);
	}

	return 0;
}

