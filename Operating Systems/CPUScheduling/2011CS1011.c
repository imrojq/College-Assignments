#include <stdio.h>
#include <stdlib.h>

#define max_int 100000000

struct process
{
    int start;
    float finish;
    int art;
    int ext;
    float wait;
    float rem;
};

struct node
{
    int num;
    struct node *next;
};

struct node *head,*tail;

void insert(int a)
{
    struct node *temp;
    temp=(struct node*)malloc(sizeof(struct node));
    temp->next=NULL;
    temp->num=a;
    if(head==NULL)
    {
        head=temp;
        tail=temp;
    }
    else
    {
        tail->next=temp;
        tail=temp;
    }
}

int pop()
{
    int temp;
    temp=head->num;
    if(head->next==NULL)
    {
        head=NULL;
        return temp;
    }
    head=head->next;
    return  temp;
}


int comparator(const void *p, const void *q) 
{
    int l = ((struct process *)p)->art;
    int r = ((struct process *)q)->art; 
    return (l-r);
}

void firstcome(struct process *p,int count)
{
    int i,gtime=0;
    gtime=p[0].art;
    for (i =0 ; i<count ;i++)
    {
        p[i].wait=gtime-p[i].art;
        p[i].start=gtime;
        gtime+=p[i].ext;
        p[i].finish=gtime;
                //printf("%d\n",gtime);
    }
 /*   int sum_wait=0;
    for (i=0;i<count ;i++)
        sum_wait+=p[i].wait;
    ////printf("%d\n",sum_wait);*/
}


        
     
void robin( struct process *p, int count, int quant)
{
    int end=0;
    float gtime=p[0].art;
    int runtime;//quant=100;
    int current=0,a=0;
    while(1)
    {
        a=0;
        if (p[current].rem <= quant)
        {
            runtime=p[current].rem;
            p[current].finish=gtime+runtime;
            //printf("%f\n",gtime+runtime);
            a=0.5;
        }
        else
            runtime=quant;
            
        p[current].rem-=runtime;
        
        gtime+=runtime+a;
        while (end+1<count)
        {
            if(p[end+1].art<gtime)
            {
                insert(end+1);
                end++;
            }
            else
                break;
        }
        if(p[current].rem!=0)
            insert(current);
             //   //printf("hi\n");
        if(head==NULL)
        {
            if(end==count-1)
                break;
            end++;
            insert(end);
            gtime=p[end].art;
        }
               
        current=pop();
        //pass=1;
        
        //printf("%d\n",current);
    }
    head=tail=NULL;
}
    
     
     
void srtf(struct process *p ,int count)
{
    int srindex,crindex=0,flag=1,pindex=0;
    int i,j;
    float prfinish,gtime=p[0].art,runtime,nextarv;
    while( flag || nextarv!=max_int)
    {
        flag=0;
        srindex=0;
        for(i=0;i<=crindex;i++)
        {
            if(p[i].rem!=0)
            {
                srindex=i;
                flag=1;
                break;
            }
        }
        for(i=srindex+1;i<=crindex;i++)
        {
            if(p[i].rem < p[srindex].rem && p[i].rem!=0) 
                srindex=i;
        }
        if (pindex!=srindex && p[pindex].rem!=0)
            gtime+=0.5;
        pindex=srindex;
        if (crindex+1!=count)
            nextarv=p[crindex+1].art;
        else
            nextarv=max_int;
        //printf("%d %d %d\n",srindex,flag,crindex);
        prfinish=gtime+p[srindex].rem;
        if( prfinish < nextarv && flag)
        {
            runtime=p[srindex].rem;
            p[srindex].rem=0;
            p[srindex].finish=gtime+runtime;
        }
        else //if(nextarv!=max_int)
        {
            runtime=(nextarv-gtime);
            if (flag!=0)
                p[srindex].rem-=(runtime);
            crindex++;
        }
        gtime+=runtime;

    }
}
        
void initialise(struct process *p, int count)
{
    int i;
    for(i=0;i<count;i++)
        p[i].rem=p[i].ext;
       
}    
        
     
int main()
{
    FILE *fp,*fp2;
    fp=fopen("input.txt","r");
    fp2=fopen("output.txt","w+");
    float wait_sum=0.0,turn_sum=0.0,temp;
    int count=0,i=0,j,t1,t2,gtime;
    while(fscanf(fp,"%d%d",&t1,&t2)!=EOF)
        count++;
    struct process p[count];
    rewind(fp);
    //printf("%d\n",count);
    while(fscanf(fp,"%d%d",&p[i].art,&p[i].ext)!=EOF)
        i++;
    qsort(p,count, sizeof(struct process), comparator);
    initialise(p,count);
    firstcome(p,count);
    for(i=0;i<count;i++)
    {
        temp=p[i].finish-p[i].art;
        turn_sum+=temp;
        wait_sum+=(temp-p[i].ext);
    }
    fprintf(fp2,"1.FCFS (First come First Serve)\n");
    fprintf(fp2,"The Average waiting time for  FCFS (First come First Serve) is %f \n",wait_sum/count); 
    fprintf(fp2,"The Average turnaround time for  FCFS (First come First Serve) is %f \n\n\n",turn_sum/count); 
    initialise(p,count);
    srtf(p,count);
    wait_sum=0;
    turn_sum=0;
    for(i=0;i<count;i++)
    {
        temp=p[i].finish-p[i].art;
        turn_sum+=temp;
        wait_sum+=(temp-p[i].ext);
    }
    fprintf(fp2,"2.SRTF (Shortest Remaining Time first) \n");
    fprintf(fp2,"The Average waiting time for  SRTF (Shortest Remaining Time first) is %f \n",wait_sum/count); 
    fprintf(fp2,"The Average turnaround time for  SRTF (Shortest Remaining Time first) is %f \n\n\n",turn_sum/count); 
    initialise(p,count);
    
    fprintf(fp2,"3.Round Robin:\n\n\n");
    robin(p,count,50);
    wait_sum=0;
    turn_sum=0;
    for(i=0;i<count;i++)
    {
        temp=p[i].finish-p[i].art;
        turn_sum+=temp;
        wait_sum+=(temp-p[i].ext);
    }
    fprintf(fp2,"The Average waiting time for   RR (Round Robin)  with quantum value 50 is %f \n",wait_sum/count); 
    fprintf(fp2,"The Average turnaround time for   RR (Round Robin)  with quantum value 50 is %f \n\n\n",turn_sum/count); 
    
    initialise(p,count);
    robin(p,count,100);
    wait_sum=0;
    turn_sum=0;
    for(i=0;i<count;i++)
    {
        temp=p[i].finish-p[i].art;
        turn_sum+=temp;
        wait_sum+=(temp-p[i].ext);
    }
    fprintf(fp2,"The Average waiting time for   RR (Round Robin)  with quantum value 100 is %f \n",wait_sum/count); 
    fprintf(fp2,"The Average turnaround time for   RR (Round Robin)  with quantum value 100 is %f \n\n\n",turn_sum/count); 
    
    initialise(p,count);
    robin(p,count,500);
    wait_sum=0;
    turn_sum=0;
    for(i=0;i<count;i++)
    {
        temp=p[i].finish-p[i].art;
        turn_sum+=temp;
        wait_sum+=(temp-p[i].ext);
    }
    fprintf(fp2,"The Average waiting time for   RR (Round Robin)  with quantum value 500 is %f \n",wait_sum/count); 
    fprintf(fp2,"The Average turnaround time for   RR (Round Robin)  with quantum value 500 is %f \n\n\n",turn_sum/count); 
    
    fclose(fp);
    fclose(fp2);
    return 0;
}