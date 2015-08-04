#include <iostream>
#include <stdio.h>
#include <conio.h>
#include <time.h>
#include <limits.h>


using namespace std;


bool toss_coin() 
{    
     if (rand()%2==0)
        return true;
     else
        return false;

}


class listnode 
{
    public:
    listnode *up;
    listnode *left;
    listnode *right;
	listnode *down;
    int jump;
    int num;
	listnode ()
	{}
    listnode(int n, int j)
    {
        jump=j;
		num = n;
        left=NULL;
        right=NULL;
        up=NULL;
		down=NULL;

    }

};


class skiplist
{   
    public:
	listnode *s1,*s2;
	int height,width;
	skiplist()
	{
	height=1;
    width=1;
	s1=new listnode(-INT_MAX,1);
	s2=new listnode(INT_MAX,0);
	s1->right=s2;
	s2->left=s1;
	}
	
	listnode *search(int n)
	{
		listnode *p=s1;
		while(p->down!=NULL)
		{
			if(s1->right->num < n)
				p=s1->right;
			else if (s1->right->num > n)
				p=p->down;
			else
				return NULL;
		}
		while(p->right->num<n)
			p=p->right;
		if (p->num ==n)
			return NULL;
    //    cout<<p->num<<"\n";
		return p;
	}


	listnode *dsearch(int n)
	{
		listnode *p=s1;
		while(p->down!=NULL)
		{
			if(p->right->num < n)
				p=p->right;
			else if (p->right->num > n)
				p=p->down;
			else
			    {while(p->down!=NULL)
                    p=p->down;}
		}
		while (p->num !=n && p->right!=NULL)
			p=p->right;
		if (p->right==NULL)
			return NULL;
		return p;
	}
	
	
	
	void increaseheight()
	{
		listnode *temp,*temp1;
		temp=new listnode(-INT_MAX,s1->jump);
		temp1=new listnode(INT_MAX,0);
		s1->up=temp;
		temp->down=s1;
		s2->up=temp1;
		temp1->down=s2;
		s1=temp;
		s2=temp1;
        s1->right=s2;
        s2->left=s1;
		height+=1;
	}
	
	void decreaseheight()
	{	
		listnode *a,*b;
		a=s1;
		b=s2;
		s1=s1->down;
		s2=s2->down;
        height-=1;
		delete a;
		delete b;
	}

	void ksmallest(int n)
	{
		listnode *p;
		p=s1;
		while(true)
		{
          
			if(p->jump<n)
			{
				n-=p->jump;
				p=p->right;
			}
			else if (p->jump>n)
				p=p->down;
            else
                break;
		}
		cout<<p->right->num;
     }
			
	void insert(int n)
	{
	//	cout<<"\n\n\n";
        listnode *p,*a,*temp,*curr;
		int theight=1;
        int count=0;
		if (height==1)
		{
			curr=s1;
			increaseheight();
		}
		else
			curr=search(n);
        if (curr==NULL)
           return ;
		temp=new listnode (n,1);
		curr->right->left=temp;
		temp->right=curr->right;
		curr->right=temp;
		temp->left=curr;
		curr=temp;
		p=curr;
		while(toss_coin())
		{
			while(p->up==NULL)
			{	
				p=p->left;
				count+=p->jump;
			}
			p=p->up;
			if(theight+1==height)
				increaseheight();
            theight++;
			a=new listnode(curr->num,1);
			p->right->left=a;
			a->right=p->right;
			p->right=a;
			a->left=p;
			a->down=curr;
			curr->up=a;
            p->jump+=1;
			a->jump=p->jump-count;
			p->jump=count;
            curr=a;
		}
		while(p!=s1)
		{
			while(p->up==NULL)
				p=p->left;
			p=p->up;
			p->jump+=1;
		}
		
		
   /*  display(1);
     cout<<"\n";
     display(0);*/
	}	
				
			
       
      
       


	void deletion(int n)
	{    listnode *temp,*curr,*temp1,*p;
		curr=dsearch(n);
       // cout<<curr->num;
        if(curr==NULL)
            return ;
		temp=curr->up;
		curr->left->right=curr->right;
		curr->right->left=curr->left;
        temp1=curr->left;
        delete curr;
		while(temp!=NULL)
		{
			temp1=temp;
			temp1->left->right=temp1->right;
			temp1->right->left=temp1->left;
			temp1->left->jump=temp1->left->jump+temp->jump-1;
            p=temp1;
			temp=temp->up;
            temp1=temp1->left;
            delete p;
		//	delete temp1->right;
            
		}
		if(temp1->up==s1 && temp1->right->up==s2)
			decreaseheight();
	//	delete curr;
        
     	while(temp1!=s1)
		{
			while(temp1->up==NULL)
				temp1=temp1->left;
			temp1=temp1->up;
			temp1->jump-=1;
		}
		
  
        
	}
	
	void display(int i)
	{
	listnode *p,*a=s1;

    while(a!=NULL)
    {
       p=a;
       a=p->down;
     while(p!=NULL)
       {if (i==1)
        cout<<p->jump;
        else
        {
        if (p->num==2147483647 || p->num==-2147483647)
           cout<<"i";
        else
        cout<<p->num;
        }
        for(int i=0;i<p->jump-1;i++)
                cout<<" ";
        p=p->right;
        }
       
       cout<<"\n";
       }


	}
};
		
		
	
	
int main()
{
    srand(time(NULL));
	skiplist a;
    int nop,noi,ip,i,j;
    string b;
    /*for (i=0;i<500;i++)
        a.insert(i);
 //   a.display(0);
    cout<<"\n";
    for (i=100;i<199;i++)
        a.deletion(i);
    a.ksmallest(45);*/
    
   // cout<<a.height;*/
  // a.ksmallest(0);
    cin>>nop;
    for (i=0;i<nop;i++)
    {
       cin>>b;
       if (b=="insert")
       {
       cin>>noi;
	  
       for(j=0;j<noi;j++)
          {cin>>ip;
		 // cout<<ip<<"\n";
          a.insert(ip);
          }
        //a.display(1);
       }
       if (b=="delete")
       {
       cin>>noi;
	  
       for(j=0;j<noi;j++)
          {cin>>ip;
		 // cout<<ip<<"\n";
          a.deletion(ip);
          }
        //a.display(1);
       }
       
       if (b=="select")
       {
       cin>>ip;
       a.ksmallest(ip);
       cout<<"\n";
       }
       a.display(0);
    }

    getch();
}
	
	
	



