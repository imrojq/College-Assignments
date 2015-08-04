#include<iostream>
#include<conio.h>
using namespace std;



class queue;
class queuenode {
        int cust;
        public:
        queuenode *next;
        queuenode () {
            next=NULL;
            }
        friend class queue;

};
class queue
{
    public :
        queuenode *temp,*head,*lastnode;
        queue (){
            head = NULL;
            temp = NULL;
            lastnode = NULL;
        }
        void enqueue(int x ){
            if (head == NULL){
                head= new queuenode ;
                head->cust =x;
               // curr=head;
                lastnode =head;
            }
            else{
                lastnode -> next = new queuenode ;
                lastnode -> next -> cust =x;
                lastnode=lastnode ->next;
            }
        }
        int dequeue(){
            int customer = head ->cust;
            temp=head;
            head=head -> next;
            delete temp;
            return customer;
        }
        void display()
        {
        return;
        temp=head;
        while(temp!=NULL)
{
        cout<<temp->cust<<" -> ";
        temp=temp->next;
}
        cout<<endl;
        }
        
            
};
class leastr
      {
          public:
          int time;
          int a[8];
          leastr()
          {
           time=0;
          int i;
          for(i=0;i<8;i++)
          a[i]=time;
          }
          void inc(int index)
          {
               time+=1;
               a[index]=time;
          }
          int lru()
          {
               int min=a[0];
               int mindex=0;
               for(int i=1;i<8;i++)
               {
                             if (a[i]<=min)
                             {
                                        mindex=i;
                                        min=a[i];
                             }
               }
               inc(mindex);
               return mindex;
          }
          } ;
                                        
         

int wrong=0,totprd=0;
int gtime=0;
int bim[1024];
int tour[4096];
int gs[4096];
int bhr=0;
int mis1=0,mis2=0;

class inst1{
public:
      int pc,type,rs,rt,rd,start;
      };
      
class inst2{
public:
      int pc,address,branch;
      };

class block1{
      public:
      int tag;
      block1()
      {
              tag=-1;
      }
      int blk[8];
      }  ;
      
class block2{
      public:
      int tag;
      block2()
      {
              tag=-1;
      }
      block1 blk[4];
      }  ;

class set1{
      public:
      queue q;
      block1 s[2];
      }   ;

class set2{
      public:
      leastr l;
      block2 s[8];
      }  ;
set1 c1[512];
set2 c2[2048];
void read2( unsigned int mem)
{
      int sindex=(mem/32)%2048;
      int i,j,flag=0;
      int tag=(mem/65536);
      int m2=(mem%32);
      m2=m2/8;
      gtime+=8;
      for(i=0;i<8;i++)
      {
                      if(c2[sindex].s[i].tag==tag)
                      {
                      c2[sindex].l.inc(i);
                      return;
                      //return c2[sindex].s[i].blk[m2]; 
                       }
      }
      mis2++;
      for(i=0;i<8;i++)
                {
                 if(c2[sindex].s[i].tag==-1){
                                             
                                             c2[sindex].s[i].tag=tag;
                                             c2[sindex].l.inc(i);
                                             return;
                                             }
                 }
      
      //replacement pol
      int temp=c2[sindex].l.lru();
      c2[sindex].s[temp].tag=tag;
      gtime+=200;
      return;
      }   


void read1(unsigned int mem)
{//cout<<"in read1   "<<mem<<endl;
      int sindex=(mem/8)%512;
      int i,j;
      int tag=(mem/4096);
      //cout<<"sindex is and tag is  "<<sindex<<"  " <<tag<<endl;
      for(i=0;i<2;i++)
      {
                      if(c1[sindex].s[i].tag==tag){
                      c1[sindex].q.enqueue(i);
                       c1[sindex].q.display();
                       return ;
                       }
      }
      mis1++;
      for(int i=0;i<2;i++)
                {//cout<<"in for of tag -1 "<<endl;
                 if(c1[sindex].s[i].tag==-1){//cout<<"in if"<<endl;
                                             
                                             c1[sindex].s[i].tag=tag;
                                             c1[sindex].q.enqueue(i);
                                              c1[sindex].q.display();
                                             read2(mem);
                                             return;
                                             }
                                           
                 }


      int temp=c1[sindex].q.dequeue();
      //cout<<"place replaced"<<temp<<endl;
      c1[sindex].q.enqueue(temp);
    c1[sindex].q.display();
      c1[sindex].s[temp].tag=tag;
      read2(mem);
     //replacement pol
      }
      
void write2(unsigned int mem){
cout<<" in write 2 with mem - "<<mem<<endl;
int sindex=(mem/32)%2048;
int tag=(mem/65536);
int m2=mem%8,i;
m2=m2/8;
cout<<"sindex and tag is "<<sindex<<"  "<<tag<<endl; 
for(i=0;i<8;i++){
                 if(c2[sindex].s[i].tag==tag){
                                              c2[sindex].l.inc(i);
                                              return;
                                              }
                 }
for(i=0;i<8;i++)
                {
                
                 if(c2[sindex].s[i].tag==-1){
                                             cout<<"\nindex selected is "<<i<<endl; 
                                             c2[sindex].s[i].tag=tag;
                                             c2[sindex].l.inc(i);
                                             return;
                                             }
                 }
      int temp=c2[sindex].l.lru();
      //c2[sindex].l.inc(temp);
      c2[sindex].s[temp].tag=tag;
     // gtime+=200;
     // mis2++;
      return;

            }
      
void write1( unsigned int mem){//cout<<"in write1 "<<mem<<endl;
int sindex=(mem/8)%512;
int tag=(mem/4096);
//cout<<"sindex is and tag is  "<<sindex<<"  " <<tag<<endl;
for(int i=0;i<2;i++){//cout<<c1[sindex].s[i].tag<<endl;
                 if(c1[sindex].s[i].tag==tag){//cout<<" "<<endl;
                                              c1[sindex].q.enqueue(i);
                                               c1[sindex].q.display();
                                              write2(mem);
                                              return ;
                                              }
                 }
for(int i=0;i<2;i++)
                {//cout<<"in for of tag -1 "<<endl;
                 if(c1[sindex].s[i].tag==-1){//cout<<"in if"<<endl;
                                             c1[sindex].s[i].tag=tag;
                                             c1[sindex].q.enqueue(i);
                                              c1[sindex].q.display();
                                             write2(mem);
                                             return;
                                             }
                                           
                 }  //cout<<"after for"<<endl;
      int temp=c1[sindex].q.dequeue();//cout<<"temp set"<<endl;
      c1[sindex].q.enqueue(temp);
      c1[sindex].s[temp].tag=tag;
      write2(mem);


      }

int bimodal(int pc){
                     
                     int index=(pc)%1024;
                    // index=index>>22;
                     return bim[index]>=2;
                    }

int gshare(int pc){
                   int index=(pc)%4096;
                 //  index=index>>20;
                   return gs[index^bhr]>=2;
                   }
                   
void update(int *a,int ind,int inc){
                                    if (inc==0)
                                    {
                                               a[ind]-=1;
                                               if(a[ind]<0)
                                                         a[ind]=0;
                                    }
                                    else
                                    {
                                              a[ind]+=1;
                                              if(a[ind]>3)
                                                          a[ind]=3;
                                    }
                                    }

void train(int pc,int ptype,int predicted,int actual){
                                                      totprd++;
                                                      ////cout<<(actual!=predicted)<<endl;
                                                      wrong+=(actual!=predicted);
                                                     int index;
                                                     if(ptype==0){//means bimodal
                                                                  index=(pc)%1024;
                                                                  ////cout<<index<<" ";
                                                                  update(bim,index,actual);  
                                                                  index=(pc)%4096;
                                                                  update(tour,index,actual!=predicted);
                                                                  }
                                                     if(ptype==1){//means gshare
                                                                  index=(pc)%4096;
                                                                  update(gs,index^bhr,actual); 
                                                                  index=(pc)%4096;
                                                                  update(tour,index,actual==predicted); 
                                                                  bhr=bhr%32;
                                                                  bhr=bhr<<2;
                                                                  bhr+=actual;
                                                                  }
                                                     gtime+=(actual!=predicted)*2;
                                                     
                                                     }

int tournament(int pc){
                       int index=(pc)%4096;
                       
                       return tour[index]>=2;
                      //return 0;
                       }

int main(){
for(int i=0;i<4096;i++){
                        tour[i]=2;
                        gs[i]=2;
                        if(i<1024)
                        bim[i]=2;
                        }
inst1 in1[10000];
inst2 in2,temp;
int i=0,j,numofinst=0,x;
char str[100],*ch;
FILE *fp,*f;
fp=fopen("trace1.txt","r");
f= fopen("trace2.txt","r");
while(1){//printf("%x\n",x);
                if (fscanf(fp,"%x",&x)==EOF)
                   break;
                in1[x].pc=x;
                fscanf(fp,"%d",&in1[x].type);
                fscanf(fp,"%d",&in1[x].rs);
                fscanf(fp,"%d",&in1[x].rt);
                fscanf(fp,"%d",&in1[x].rd);
                
                }
//cout<<"lola\n";

//for(i=0;i<=limit;i++)//cout<<"("<<i<<")"<<in1[i].pc<<" "<<in1[i].type<<" "<<in1[i].rs<<" "<<in1[i].rt<<" "<<in1[i].rd<<endl;  

fscanf(f,"%x",&in2.pc);
fscanf(f,"%x",&in2.address);
fscanf(f,"%d",&in2.branch); 
numofinst++; 
gtime++;
int ctr=0; 
temp=in2;    
int ptype,taken;  
int load=0;
while(1){ ////cout<<"ganja"<<endl;
          numofinst++;
      //    if (numofinst==500000)
        //  break;
          if (fscanf(f,"%x",&in2.pc)==EOF)
             break;
          fscanf(f,"%x",&in2.address);
          fscanf(f,"%d",&in2.branch);
          gtime++;
          if(in1[in2.pc].type==0){
                                  load++;
                               read1(in2.address);
                               }
          if(in1[in2.pc].type==1){
                               write1(in2.address);
                               }
          if(in1[temp.pc].type==0){//load
                           if(in1[in2.pc].type==2&&(in1[temp.pc].rd==in1[in2.pc].rs||in1[temp.pc].rd==in1[in2.pc].rt)){
                                                                            gtime++;
                                                                            }
                           if((in1[in2.pc].type==0||in1[in2.pc].type==1)&&(in1[temp.pc].rd==in1[in2.pc].rs)){
                                                                         gtime++;
                                                                          }
                           if(in1[in2.pc].type==3&&(in1[temp.pc].rd==in1[in2.pc].rs||in1[temp.pc].rd==in1[in2.pc].rt||in1[temp.pc].rd==in1[in2.pc].rd)){
                                                                                            gtime++;
                                                                                            }
                                 }
        if(in1[in2.pc].type==3){
                                  ptype=tournament(in2.pc);
                                  if(ptype==0){
                                               taken=bimodal(in2.pc);
                                               }
                                  else if(ptype==1){
                                               taken=gshare(in2.pc);
                                               }
                                  train(in2.pc,ptype,taken,in2.branch);
                                  }
                temp=in2;
               }
        //       for(i=0;i<1024;i++)
          //     //cout<<bim[i]<<" ";
               
               cout<<totprd<<endl;
               cout<<gtime<<endl;
               
               cout<<(totprd-wrong)/(totprd*.01)<<endl;
               cout<<numofinst/(gtime*1.0)<<endl;
               cout<<mis1/(load*1.0)<<endl;
               cout<<mis2/(load*1.0)<<endl;
           getch();
           }
