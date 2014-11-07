#include <iostream>

using namespace std;

int main()
{
    int startx,endx, y;
    bool done=false,start=false;
    while(!start){
     cout << "Enter a starting value for x: " << endl;
     cin >> startx;
     cout << "Enter an ending value for x: " << endl;
     cin >> endx;
    // Check the start < the end.
     if(startx>endx){
        cout<<"x should be less than y;" <<endl;
     }else start=true;
    }

    // Program logic
    while(!done){
     if(startx==endx)break;
     // Calculate y
     y =(startx * startx * startx) - (3*startx) +1;
     cout << "y=" << y <<endl;
     startx++;
    }
    return 0;
}
