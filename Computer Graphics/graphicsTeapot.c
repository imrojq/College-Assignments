#include <math.h>
#include <stdlib.h>
#include <GL/glut.h>
#include <stdio.h>
 
typedef struct point  //define structure for line ,it would be beneficial for file input
{
    int x,y;    //x,y coordinates
    float r,g,b,alpha; //color index
};

void swap (int *x, int *y) //swaps 2 variables
{
   int temp = *x;
   *x = *y; 
   *y = temp;
}

int min(int x,int y) //finds minimum of 2 variables
{ 
    if(x>y) return y;
    else  return x;
}

int max(int x,int y)//finds maximum of 2 variables
{ 
    if(x>y) return x;
    else return y;
}

//sort x coordinates
//brr[] has y corodinates
void sort(int arr[],int brr[])
{
    int p,q;
    for( q=2;q>0;q--){
        for(p=0;p<=q-1;p++){
            if(arr[p]>arr[p+1]){ 
                swap(&arr[p],&arr[p+1]);//swapping x coordinates
                swap(&brr[p],&brr[p+1]);//swapping y cordinates w.r.t x coordinates 
 }}}}

float area(int x1, int y1, int x2, int y2, int x3, int y3)//returns area of triangle with 3 vertices given
{
   return abs((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);//abs used as result may be negative
}


int interior(int x1, int y1, int x2, int y2, int x3, int y3, int x, int y)// checks whether a point lies in interior of triange or not 
{   
   float A = area (x1, y1, x2, y2, x3, y3);//total area
   float A1 = area (x, y, x2, y2, x3, y3);//area of subtriangles
   float A2 = area (x1, y1, x, y, x3, y3);
   float A3 = area (x1, y1, x2, y2, x, y);
   return (A == (A1 + A2 + A3));//if point lies inside returns 1 else 0
}

//Implements Triangle Rasterization
// triangle() takes x,y xoordinates along with their respective colors as arguments
void triangle(int tx1,int ty1,int tx2,int ty2,int tx3,int ty3,float r1,float g1,float b1,float alpha1,float r2,float g2,float b2,float alpha2,float r3,float g3,float b3,float alpha3){

    int arr[]={tx1,tx2,tx3}; //array of x coordinates
    int brr[]={ty1,ty2,ty3}; //array of y coordinates
    sort(arr,brr);  //sorts arr,would be helpful in finding xmin and xmax
    tx1=arr[0]; //value of tx1 changes to xmin
    tx2=arr[2];//value of tx2 changes to xmax
    tx3=arr[1];
    ty1=brr[0];
    ty2=brr[2];
    ty3=brr[1];

    int ystep; 
    int y0;
    if (ty3<=min(ty1,ty2)){  //3rd point is below the base 
        ystep=-1;
        y0=max(ty1,ty2);
    }
    else{         //3rd point is above the base
        ystep=1;
        y0=min(ty1,ty2);
    }
    int x;
 
    glBegin(GL_POINTS);
    int y=y0;
            
    for(x=tx1;x<=tx2;x++){ //traverses from xmin to xmax
        y=y0;
        while(y!=ty3) //traverses from ymin to ty3
          {
             if((interior(tx1,ty1,tx2,ty2,tx3,ty3,x,y))){ //if point lies in interior of triangle
                float perc3=area(tx1,ty1,tx2,ty2,x,y)/area(tx1,ty1,tx2,ty2,tx3,ty3);//
                float perc2=area(tx1,ty1,tx3,ty3,x,y)/area(tx1,ty1,tx2,ty2,tx3,ty3);
                float perc1=area(tx2,ty2,tx3,ty3,x,y)/area(tx1,ty1,tx2,ty2,tx3,ty3);
                float percr=perc3*r3+perc2*r2+perc1*r1;  //percentage of color red at present point
                float percg=perc3*g3+perc2*g2+perc1*g1;  //percentage of color green at present point
                float percb=perc3*b3+perc2*b2+perc1*b1; //percentage of color blue at present point
                float percalpha=perc3*alpha3+perc2*alpha2+perc1*alpha1;   
                glColor4f(percr,percg,percb,percalpha);
                glVertex2f(x,y); //plots point (x,y)
                }
                if(y==ty3) //loop breaks at ymax or ymin(depends on 3rd point)
                   break;
             y=y+ystep;                   
            //cout<<y;             
          }
    }
    glEnd();
    glFlush();
}

void MidPointLine(struct point p0, struct point p1,float slope)
{
    float x0,x1,y0,y1,x,y;
	x0=p0.x;
	y0=p0.y;
	x1=p1.x;
	y1=p1.y;
    float dx = x1 - x0;
    float dy = abs(y1 - y0);
    float incrE=2*dy;    //if point above the line is chosen,calculates increment in d required 
    float incrNE=(dy-dx)*2;//if point below the line is chosen,calculates increment in d required
    float d=dy*2-dx;
    int incry;
    if(y1>y0)
	incry=1;
    else
	incry=-1;
    glBegin(GL_POINTS);
    y=y0;
    float length=x1-x0; //length of segment     
    for(x=x0;x<x1;x++) {

        float perct1=(x-x0)/length;
        float perct2=(x1-x)/length;
        float t1=perct1*p0.r+perct2*p1.r;//percentage of red color at that point
        float t2=perct1*p0.g+perct2*p1.g;//percentage of green color at that point
        float t3=perct1*p0.b+perct2*p1.b;//percentage of blue color at that point
        float t4=perct1*p0.alpha+perct2*p1.alpha;//percentage of alpha at that point
        glColor4f(t1,t2,t3,t4);
        if (fabs(slope)<=1)
            glVertex2f(x, y); //if slope is greater than 1,it swaps variables 
        else 
            glVertex2f(y, x);
      
        if ( d <= 0 ) { //midpoint lies below the line
            d += incrE;
        } 
        else {//midpoint lies above the line

            d += incrNE;
            y=y+incry;    
         }
    }
    glEnd();
}

//Implements line segment rasterization using the Bresenham algorithm
void line(struct point p0, struct point p1)
{
    float slope = ((p0.y-p1.y)*1.0f)/(p0.x-p1.x); //checks whether slope of line is less than 1 or more than 1
    
    if (fabs(slope)>1) //if greater than 1,swaps variable
   {
	swap(&p0.x,&p0.y);
	swap(&p1.x,&p1.y);
   }
   
    if (p0.x > p1.x)
    {
	struct point temp;
	temp=p0;
	p0=p1;
	p1=temp;
    }
    MidPointLine(p0,p1,slope);
}



void display( void )
{
    glClear( GL_COLOR_BUFFER_BIT );
    int n;
    FILE *fp;
    fp=fopen("input1.txt","r");
    fscanf(fp,"%d",&n);
    struct point p[2*n];
    int i;
    for(i=0;i<2*n;i++)
        fscanf(fp,"%d%d%f%f%f%f",&p[i].x,&p[i].y,&p[i].r,&p[i].g,&p[i].b,&p[i].alpha);
    for(i=0;i<2*n-1;i=i+2)  
        line(p[i],p[i+1]);  

    fscanf(fp,"%d",&n);
    struct point t[3*n]; 
    for(i=0;i<3*n;i++)
        fscanf(fp,"%d%d%f%f%f%f",&t[i].x,&t[i].y,&t[i].r,&t[i].g,&t[i].b,&t[i].alpha);

    for(i=0;i<3*n-2;i=i+3)  
        triangle(t[i].x,t[i].y,t[i+1].x,t[i+1].y,t[i+2].x,t[i+2].y,t[i].r,t[i].g,t[i].b,t[i].alpha,t[i+1].r,t[i+1].g,t[i+1].b,t[i+1].alpha,t[i+2].r,t[i+2].g,t[i+2].b,t[i+2].alpha);  

    glFlush();
}

void reshape( int w, int h )
{
    if  ( h == 0 ) h = 1;
        glMatrixMode( GL_PROJECTION );
    glLoadIdentity();

    glOrtho(-1000.0f,1000.0f,-1000.0f,1000.0f,0.0f,1.0f);
 // glViewport( 0, 0, w, h );

    int win_width = w;
    int win_height = h;

    glutPostRedisplay();
}



int main (int argc, char *argv[]) 
{
    glutInit( &argc, argv );
    glutInitDisplayMode( GLUT_RGBA| GLUT_SINGLE);//|GLUT_DOUBLE );
    glutInitWindowSize(500,500);
    glutCreateWindow( "line" );
    glutDisplayFunc( display );
    glutReshapeFunc( reshape );
    glutMainLoop();
}
