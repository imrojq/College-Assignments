#include <stdio.h>
#define MAXINT 2000000000;
void matrix(int p[],int s[51][51],int m[51][51]){
        int i,j,l,k,q;
		int n=50;
        for (i=1;i<=50;i++){
	    m[i][i]=0;
	    }
	    for ( l=2; l<=n; l++) {
        for ( i=1; i<=n-l+1; i++) {
            j = i+l-1;
            m[i][j] = MAXINT;
            for ( k=i; k<=j-1; k++) {
                q = m[i][k] + m[k+1][j] + p[i-1]*p[k]*p[j];
                if (q < m[i][j]) {
                    m[i][j] = q;
                    s[i][j] = k;
                }
            }
        }
    }
}

void printparens(int s[51][51],int i,int j){
	if (i==j)
		printf("A%d",i);
	else {
		printf ("(");
		printparens(s,i,s[i][j]);
        printf("x");
		printparens(s,s[i][j]+1,j);
		printf (")");
		}
		}
		

int main(int argc,char *argv[]) {
	int m[51][51];
	int s[51][51];
	FILE *fin;
	if(argc<2)
	return ;
	fin=fopen(argv[1],"r");
	int i,p[51],num,counter=0;;
	while (fscanf(fin, "%d",&num) != EOF) 
    {             
           if(counter%2==0)
		   p[counter/2]=num;
		   if(counter==99)
		   p[50]=num;
		   counter=counter+1;
		   
     }
		
	
	int length=50;
	matrix(p,s,m);
	printparens(s,1,50);
    }

