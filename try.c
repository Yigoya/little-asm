#include <stdio.h>
int add(int x,int y){
    int z = x+y;
    return z;
}
int main(){
    int x=add(2,4);
    printf("%d",x);
}