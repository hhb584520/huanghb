// string::substr
#include <iostream>
#include <string>
#include <vector>

using namespace std;
int main ()
{
  vector <int> a;

  for (int i=0; i<10; i++)
  {
	  a.push_back(i);
  }
  a.resize(100);
  a[90]=100;

  cout << a[90] << endl;

  return 0;
}
