#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int main(int argc,char **argv){
    FILE *p=fopen(argv[1],"w");
    int n=atoi(argv[2]);
    int i;
    srand(time(NULL));
    for(i=0;i<n;i++)
        fprintf(p,"%d\n",rand());
    fclose(p);
    return 0;
}
