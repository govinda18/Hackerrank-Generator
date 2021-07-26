#include "testlib.h"
#include<bits/stdc++.h>
using namespace std;


void writeTest(int test)
{
    startTest(test);
    if(test==1)
    {
        cout<<3<<endl;
        return;
    }
    if(test==2)
    {
        cout<<2<<endl;
        return;
    }
    if(test==3)
    {
        cout<<1<<endl;
        return;
    }
    int n;
    if(test<=7)
        n=rnd.next(1,100);
    else
        n=rnd.next(100,1000);
    cout<<n<<endl;
}


int main(int argc, char* argv[])
{
    int tests = atoi(argv[1]);
    for (int i = 0; i < tests; i++)
        writeTest(i);
    return 0;
}
