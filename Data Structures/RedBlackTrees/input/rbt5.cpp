#include <iostream>
#include <stdio.h>
#include <conio.h>
#include <time.h>
#include<fstream>

using namespace std;

class treenode 
{
    public:
    treenode *parent;
    treenode *left;
    treenode *right;
    int height;
    int num;
    int leftsize;
    char colour;
    treenode()
    {
        height=0;
        left=NULL;
        right=NULL;
        parent=NULL;
        leftsize=0;

    }
};

treenode sentinel;


class tree
{
    public:
    treenode *head,*temp,*curr,*temp1;
    tree(){
   head=&sentinel;
   head->colour='b';   

    }
    treenode  *search(treenode *a,int x)
    {
        if(x<a->num && a->left!=&sentinel)
            return search(a->left,x);
        else if (x>a->num && a->right!=&sentinel)
            return search(a->right,x);
        else if(x==a->num)
              return NULL;
        return a;
    }
    treenode  *dsearch(treenode *a,int x)
    {   
        if(x<a->num && a->left!=&sentinel)
           {
            return dsearch(a->left,x);}
        else if (x>a->num && a->right!=&sentinel)
            return dsearch(a->right,x);
        else if(x==a->num)
            return a;
        return NULL;
    }
	
	
   void lsupdate(treenode *p,int k)
   {
		while(p!=head)
		{
		if(p->parent->left==p)
            p->parent->leftsize+=k;
		p=p->parent;
        }

	}
                         
   

   void ksmallest(treenode *p,int k)
   {
		if(p->leftsize+1==k)
			cout<<p->num<<"\n";
		else if (p->leftsize+1>k)
			ksmallest(p->left,k);
		else
			ksmallest(p->right,k-p->leftsize-1);
	}

	treenode *inorder(treenode *x)
	{
         x=x->right;
         while(x->left!=&sentinel)
           x=x->left;
         return x;
    }	

	treenode *sleftrot(treenode *p)
	{       
		treenode *temp,*temp1,*temp2;
		temp=p->parent;
        temp1=p->right;
		temp2=p->right->left;
		p->right->left=p;
		p->right=temp2;
		p->parent=temp1;    
        temp1->parent=temp;
       if(p->right!=&sentinel)
          p->right->parent=p;
		if (temp!=NULL)
		{
			int i= temp->num > temp1->num ;
			if (i)
				temp->left=temp1;
			else 
				temp->right =temp1;
		}
		else
			head=temp1;
		temp1->leftsize+=temp1->left->leftsize+1;
		return temp1;
	}
	treenode *srightrot(treenode *p)
	{
		treenode *temp,*temp1,*temp2;
		temp=p->parent;
        temp1=p->left;
		temp2=p->left->right;
		p->left->right=p;
		p->left=temp2;
		p->parent=temp1;
		temp1->parent=temp;
        if(p->left!=&sentinel)
        		p->left->parent=p;
		if (temp!=NULL)
		{
			int i= temp->num > temp1->num ;
			if (i)
				temp->left=temp1;
			else 
				temp->right =temp1;
		}
		else
			head=temp1;
		temp1->right->leftsize-=(temp1->leftsize+1);
		return temp1;
	}
	
	
		treenode  *rotate(treenode *u)
	{  
		if (u->parent->left==u)
		{           
			if(u->right->colour=='r')
			{	
				u=sleftrot(u);
				temp= srightrot(u->parent);
                
				temp->colour='b';
				temp->height+=1;
				temp->right->colour='r';
				temp->right->height-=1;
			}
			else
			{
				temp= srightrot(u->parent);
				temp->colour='b';
				temp->height+=1;
				temp->right->colour='r';
				temp->right->height-=1;
			}
		}
		else
		{   
			if(u->left->colour == 'r')
			{                  
			    u=srightrot(u);
				temp=sleftrot(u->parent);
				temp->colour='b';
				temp->height+=1;
				temp->left->colour='r';
				temp->left->height-=1;
                
                
			}
			else
			{
				temp= sleftrot(u->parent);
				temp->colour='b';
				temp->height+=1;
				temp->left->colour='r';
				temp->left->height-=1;
			}
		}
	}
	
	void dpropogate(treenode *p)
	{
		if(p->left->height<p->right->height)
		{   
			if(p->right->colour=='r')
				{

					p=sleftrot(p);
					p->colour='b';
					p->height+=1;
					p->left->right->colour='r';
					p->left->right->height-=1;
					if(p->left->right->left->colour =='r' || p->left->right->right->colour=='r')
						propogate(p->left->right);				
				}
			else
			{
				if(p->right->left->colour=='r' && p->right->right->colour=='b')
				{
					p->right=srightrot(p->right);
					p=sleftrot(p);
					p->colour='b';
					p->height+=1;
					p->left->height-=1;
					if(p->left->colour=='r')
					{
						p->right->colour='r';
						p->right->height-=1;
					}
					else
						p->height+=1;
						
				}
				else if (p->right->left->colour=='b' && p->right->right->colour == 'r' )
				{
					p=sleftrot(p);
					p->left->height-=1;
					if(p->left->colour=='b')
					{
						p->right->colour='b';
						p->right->height+=1;
						p->height+=1;
					}
				}
				else if (p->right->left->colour=='r' && p->right->right->colour=='r')
				{
					p=sleftrot(p);
					if(p->left->colour=='r')
					{
						p->colour='r';
						p->left->colour='b';
					}	
					else
					{
						p->height+=1;
						p->left->height-=1;
					}
				}
				else
				{
					if(p->colour=='r')
					{
						p->colour='b';
						p->right->colour='r';
						p->right->height-=1;
					}
					else
					{
						p->height-=1;
						p->right->colour='r';
						p->right->height-=1;
						if(p->parent!=NULL)
							dpropogate(p->parent);
					}
				}
			}
		}
		else if(p->left->height>p->right->height)
		{
			if(p->left->colour=='r')
				{
				p=srightrot(p);
				p->colour='b';
				p->height+=1;
				p->right->left->colour='r';
				p->right->left->height-=1;
				}
			else
			{
				if(p->left->right->colour=='r' && p->left->left->colour=='b')
				{
					p->left=sleftrot(p->left);
					p=srightrot(p);
					p->colour='b';
					p->height+=1;
					p->right->height-=1;
					if(p->right->colour=='r')
					{
						p->left->colour='r';
						p->left->height-=1;
					}
					else
						p->height+=1;
						
				}
				else if (p->left->right->colour=='b' && p->left->left->colour == 'r' )
				{
					p=srightrot(p);
					p->right->height-=1;
					if(p->right->colour=='b')
					{
						p->left->colour='b';
						p->left->height+=1;
						p->height+=1;
					}
				}
				else if (p->left->right->colour=='r' && p->left->left->colour=='r')
				{
					p=srightrot(p);
					if(p->right->colour=='r')
					{
						p->colour='r';
						p->right->colour='b';
					}	
					else
					{
						p->height+=1;
						p->right->height-=1;
					}
				}
				else
				{
					if(p->colour=='r')
					{
						p->colour='b';
						p->left->colour='r';
						p->left->height-=1;
					}
					else
					{
						p->height-=1;
						p->left->colour='r';
						p->left->height-=1;
						if(p->parent!=NULL)
							dpropogate(p->parent);
					}
				}
			}
		}
	}
		
	
	void propogate(treenode *u)
	{   
		if(u==head)
		{
			head->colour='b';
			head->height+=1;
		}
		else 
		{   
			if(u->parent->left==u)
				temp=u->parent->right;
			else
				temp=u->parent->left;
			
            if(temp->colour=='r')
			{
				temp->colour='b';
				u->colour='b';
				u->height+=1;
				temp->height+=1;
				if(u->parent!=head)
				{
					u->parent->colour='r';
					if(u->parent->parent->colour=='r')
						propogate(u->parent->parent);
				}
				else
					u->parent->height+=1;
			}
			else
			{
				rotate(u);
			}
		}	
	}
		
				
	void insert(int x)
	{	
		if (head==&sentinel)
		{
			head =new treenode ;
			head->colour='b';
			head->height=1;
			head->num=x;
            head->left=&sentinel;
            head->right=&sentinel;
		}
		else
		{	
            temp=new treenode ;
			temp->colour='r';
			temp->height=0;
			temp->num=x;
            temp->left=&sentinel;
            temp->right=&sentinel;
			curr=search(head,x);
            if (curr==NULL)
               return;
            temp->parent=curr;
			if(x<curr->num)
				curr->left=temp;
			else
				curr->right=temp;
            lsupdate(temp,1);
			if(curr->colour=='r')
            {
				propogate(curr);
			}
		}	
	}			
			
	void deletion(int x)
	{
		curr=dsearch(head,x);
		if(curr->left!=&sentinel && curr->right!=&sentinel )
		{
			temp=inorder(curr);
			curr->num=temp->num;
			curr=temp;
			temp=curr->right;
		}
		if(curr!=head)
		{	
			if(curr->left==&sentinel && curr->right!=&sentinel)
			{
				temp=curr->right;
                lsupdate(curr,-1);
				if(curr->parent->left==curr)
					curr->parent->left=temp;
				else
					curr->parent->right=temp;
				temp->parent=curr->parent;
				if(curr->colour=='b')
                    {
					temp->colour='b';
                    temp->height+=1;}
				delete curr;
			}
			else if(curr->right==&sentinel && curr->left!=&sentinel)
			{
				temp=curr->left;
                lsupdate(curr,-1);
				if(curr->parent->left==curr)
					curr->parent->left=temp;
				else
					curr->parent->right=temp;
				temp->parent=curr->parent;
				if(curr->colour=='b')
					{temp->colour='b';
                     temp->height+=1;}
				delete curr;
			}
			else
			{
				temp=&sentinel;
                lsupdate(curr,-1);
				if(curr->parent->left==curr)
					curr->parent->left=temp;
				else
					curr->parent->right=temp;
				if(curr->colour=='b')
				{
					dpropogate(curr->parent);
				}
				delete curr;
			}
		}
		else
		{
			if(curr->left!=&sentinel)
			{
				head=curr->left;
				if(head->colour=='r')
				{
					head->colour='b';
					head->height+=1;
				}
			}
			else
			{
				head=curr->right;
				if(head->colour=='r')
				{
					head->colour='b';
					head->height+=1;
				}
			}
			delete curr;
		}		
	}
	
	void split(int k,tree &t1,tree &t2);		
    void display()
    {
        temp=head;
        if(temp==&sentinel)
			cout<<"nothing to display\n";
        while(temp!=&sentinel)
        {
			cout<<temp->colour<<endl;            
            temp=temp->left;
        }
        cout<<"\n\n\n";
    }


};
  int calsize(treenode *p)
  {
  int sum=0;
  while(p!=&sentinel)
  {
  sum+=(1+p->leftsize);
  p=p->right;
  }
  return sum;
  }


tree trans;
tree &threewayjoin(int k,tree &t1,tree &t2)
{
	treenode *joint,*temp,*temp1;
	joint=new treenode;
	joint->num=k;
	joint->colour='r';
	if(t1.head==&sentinel)
        {
        t2.insert(k);
		return t2;
        }
	if(t2.head==&sentinel)
        {
        t1.insert(k);
		return t1;
        }
	if(t1.head->height>t2.head->height)
	{    
		temp=t1.head;
		while(temp->height!=t2.head->height)
			temp=temp->right;
		temp1=temp->parent;
        temp1->right=joint;
		temp->parent=joint;
		t2.head->parent=joint;
		joint->left=temp;
        joint->height=temp->height;
		joint->right=t2.head;
		joint->parent=temp1;
        joint->leftsize=calsize(joint->left);
        if(joint->parent->colour=='r')
        { 
          t1.propogate(joint->parent);
        }
		trans.head=t1.head;
	}
	else if (t1.head->height <t2.head->height)
	{   int z;
		temp=t2.head;
		while(temp->height!=t1.head->height)
			temp=temp->left;
		temp1=temp->parent;
		temp->parent=joint;
        temp1->left=joint;
		t1.head->parent=joint;
		joint->left=t1.head;
        joint->height=temp->height;
		joint->right=temp;
		joint->parent=temp1;
       z=calsize(t1.head);
        joint->leftsize=z;
        t2.lsupdate(joint,z+1);
        if(joint->parent->colour=='r')
        { 
          t2.propogate(joint->parent);
        }
		trans.head=t2.head;
	}
        
    else
    {
    joint->colour='b';
    joint->height=t1.head->height+1;
    joint->left=t1.head;
    joint->right=t2.head;
    joint->parent=NULL;
    t1.head->parent=joint;
    t2.head->parent=joint;
    joint->leftsize=calsize(t1.head);
    trans.head=joint;
    }
    t1.head=NULL;
    t2.head=NULL;
	return trans;    
}
		
void tree :: split(int k,tree &t1,tree &t2)
	{
		if(dsearch(head,k)==NULL)
		    insert(k);
        tree temp0;
		curr=head;
        
		while(1)
		{
			if(curr->num<k)
			{
				if(t1.head!=&sentinel)
                    {
					 temp0.head=curr->left;
                     t1=threewayjoin(temp->num,t1,temp0);
				    }
                else
                {
					t1.head=curr->left;
                    if(t1.head->colour=='r')
                    {
                     t1.head->colour='b';
                     t1.head->height+=1;
                    }
                }
				temp=curr;
				curr=curr->right;
			}
			else if (curr->num > k)
			{
				if(t2.head!=&sentinel)
				{
					temp0.head=curr->right;
					t2=threewayjoin(temp1->num,temp0,t2);
				}	
				else
				{
					t2.head=curr->right;
                    if(t2.head->colour=='r')
                    {
                     t2.head->colour='b';
                     t2.head->height+=1;
                    }
                }
				temp1=curr;
				curr=curr->left;
			}
			else
			{
				if(t1.head!=&sentinel)
				{
					temp0.head=curr->left;
					t1=threewayjoin(temp->num,t1,temp0);
				}
				else
				{
					t1.head=curr->left;
                    if(t1.head->colour=='r')
                    {
                     t1.head->colour='b';
                     t1.head->height+=1;
                    }
                }
				if(t2.head!=&sentinel)
				{	
					temp0.head=curr->right;
					t2=threewayjoin(temp1->num,temp0,t2);
				}
				else
				{
					t2.head=curr->right;
                    if(t2.head->colour=='r')
                    {
                     t2.head->colour='b';
                     t2.head->height+=1;
                    }
                }
				break;
			}
			
		}
	}
	
int main()
    {
    int i,nop,tno,ni,ip,j,k,t1,t2;
    string str;
    tree a[10000];
    cin>>nop;
    for(int i=0;i<nop;i++)
    {
		cin>>str;
		if(str=="insert")
		{
			cin>>tno;
			cin>>ni;
			for(j=0;j<ni;j++)
			{
				cin>>ip;
				a[tno].insert(ip);
			}
		}
		else if(str=="delete")
		{
			cin>>tno;
			cin>>ni;
			for(j=0;j<ni;j++)
			{
				cin>>ip;
				a[tno].deletion(ip);
			}
		}
		else if(str=="select")
		{
			cin>>tno;
			cin>>ip;
			a[tno].ksmallest(a[tno].head,ip);   
		}
       else if (str=="join")
       {  
          cin>>t1;
          cin>>k;
          cin>>t2;
          cin>>tno;
          a[tno]=threewayjoin(k,a[t1],a[t2]);
          a[tno].display();
       }
       else if (str=="split")
       {
       cin>>tno;
       cin>>k;
       cin>>t1;
       cin>>t2;
       a[tno].split(k,a[t1],a[t2]);    

		}
	}
  /*tree t[5];
    for(int i=0; i<200;i++)
            {
            t[0].insert(i);
            }
    for(int i=202;i<2500;i++)
            t[1].insert(i);  
    //a.insert(1);
  // a.deletion(0);
  
   for(int i=2600;i<3500;i++)
           t[2].insert(i);
  
   
    t[3]=threewayjoin(200,t[0],t[1]);
    t[4]=threewayjoin(2555,t[3],t[2]);
    /*a.ksmallest(a.head,2);/
   // t[2].display();
      //cout<<t[2].head->num;  
   t[4].ksmallest(t[4].head,202);
    */
   // a[2].display();
   // a[16]=threewayjoin(10000,a[0],a[1]);
   //a[tno].display();

    }
