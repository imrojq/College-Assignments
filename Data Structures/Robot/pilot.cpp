#include <iostream.h>
#include <limits.h>

int pathsize=0;
int nov;
int *path;

class vertices
{
	public:
		int nbour[100];
		int size;
        vertices()
        {
        size=0;
        }
		void add(int n)
		{
			nbour[size]=n;
			size++;
		}
		void deletion(int n)
		{
			int i,j;
			for (i=0;i<size;i++)
			{
				if (nbour[i]==n)
				{
					for(j=i;j<size;j++)
						nbour[j]=nbour[j+1];
					size--;
					return ;
				}
			}
		}
};

class nodes
{	
	public:
	int min;
	int num;
	int flag;
	int prev;
	nodes()
	{
		flag=0;
		min=INT_MAX;
	}
};

vertices *v;


void relax(nodes n[],int u,vertices *v,int weights[100][100])
{
	int i=0,temp;
	n[u].flag=1;
	for (i=0;i<v[u].size;i++)
	{
		temp=v[u].nbour[i];
		if (n[temp].min > n[u].min + weights[u][temp] && n[temp].flag==0)
		{
		n[temp].min=n[u].min + weights[u][temp];
		n[temp].prev=u;
		}
	}
}

int minimum(nodes n[],int nov)
	{
		int min=INT_MAX,i,index,temp;
		for (i=0;i<nov;i++)
		{   
            //temp=v[u].nbour[i];
			if (n[i].min < min && n[i].flag==0)
			{
				index=i;
				min=n[i].min;
			}
		}
		return index;
	}
			
		
bool dijkstra(vertices *v,int start,int end,int weights[100][100],int nov)
{
    int u,temp,i;
	nodes n[nov];
	n[start].min=0;
	relax(n,start,v,weights);
	u=minimum(n,nov);
    if (n[u].min==INT_MAX)
		return false;
       
    //cout<<u<<" ";
	while (u!=end)
	{
		relax(n,u,v,weights);
		u=minimum(n,nov);
		if (n[u].min==INT_MAX)
			return false;
       // cout<<u<<"  ";
	//	path[pathsize++]=u;
	}
/*	for(i=0;i<pathsize;i++)
		cout<<i<<"->";*/
    path[pathsize++]=end;
    temp=n[end].prev;
    while(temp!=start)
	{
		path[pathsize++]=temp;
		temp=n[temp].prev;
	}
	path[pathsize++]=start;
    cout<<"Found new path from "<<start<<" of length "<<n[end].min<<" :\n";
	for(i=pathsize-1;i>-1;i--)
		cout<<path[i]<<" " ;
	cout<<"\n";
	return true;
}
		
	
void deletion(vertices *v,int u)
{
	int i,j,temp;
	for (i=0;i<v[u].size;i++)
		v[v[u].nbour[i]].deletion(u);
}
		

int main()
{
	int nov,start,end,nlinks,i,j,ip1,ip2,u,temp,bno;
	cin>>temp;
    nov=temp;
	v = new vertices[nov];
	path=new int[100];
    bool blocked[nov],test=false,a;
    for (i=0;i<nov;i++)
        blocked[i]=false;
    
	//vertices v[nov];

    int weights[100][100];
	cin>>start;
	cin>>end;
//	path[pathsize++]=start;
	
	for (i=0;i<nov;i++)
	{
		cin>>nlinks;
		for (j=0;j<nlinks;j++)
		{
			cin>>ip1;
			v[i].add(ip1);
			cin>>ip2;
			weights[i][ip1]=ip2;
		}
	}
    cin>>bno;
    for (i=0;i<bno;i++)
    {
        cin>>ip1;
        blocked[ip1]=true;
    }
    while(test==false)
    {
		a=dijkstra(v,start,end,weights,nov);
		if (a==false)
		{
			cout<<"No path to goal exists";
			return 0;
		}
		for (i=pathsize-1;i>-1;i--)
		{
			if (blocked[path[i]])
			{
				cout<<"Found blocked vertex at "<<path[i]<<"\n";
				break;
			}
		}
		if (i==-1)
		{
			cout<<"Reached goal";
			return 1;
		}
		deletion(v,path[i]);
		start=path[++i];
		pathsize=0;
	}
}
	
	
	
	
	
