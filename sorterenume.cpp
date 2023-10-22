#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
using namespace std;
bool isfete(string inp)
{
    if (((inp[inp.length() - 2] == 'n') || inp[inp.length() - 2] == 'l' || inp[inp.length() - 2] == 'c' || inp[inp.length() - 2] == 'e' || inp[inp.length() - 2] == 'i') && (inp[inp.length() - 1] == 'a'))
    {
        return true;
    }
    else
    {
        return false;
    }
}
bool biger(string inp1, string inp2)
{
    for (int i = 0; i < ((inp1.length() < inp2.length())?inp1.length():inp2.length()) - 1; i++)
    {
        if (inp1[i]>inp2[i])
        {
            return true;
        }
        else if (inp1[i]<inp2[i])
        {
            return false;
        }

        
    }
    if (inp1.length() > inp2.length())
    {
        return false;
    }
    else
    {
        return true;
    }
    
}
int main()
{
    string nume, prenume;
    vector<string> fete;
    vector<string> baieti;
    fstream in, out;
    in.open("Lista.in", ios::in);
    out.open("ListaSortata.out", ios::out);
    
    while (in >> nume)
    {
        in >> prenume;
        if (isfete(prenume))
        {
            string str = nume + ' ' + prenume;
            fete.push_back(str);
        }
        else
        {
            string str = nume + ' ' + prenume;
            baieti.push_back(str);
        }
        
    }
    
    for (int i = 0; i < fete.size()-2; i++)
    {
        for (int j = 0; j < fete.size()-2-i; j++)
        {
            if (biger(fete[j], fete[j+1]))
            {
                swap(fete[j], fete[j+1]);
            }
            
        }
        
    }

    out << "Fete: " <<'\n';
    for (int i = 0; i < fete.size()-1; i++)
    {
        out << i+1 << ". " << fete[i] << '\n';
    }
    
    for (int i = 0; i < baieti.size()-2; i++)
    {
        for (int j = 0; j < baieti.size()-2-i; j++)
        {
            if (biger(baieti[j], baieti[j+1]))
            {
                swap(baieti[j], baieti[j+1]);
            }
            
        }
        
    }
    out  << '\n'<< "Băieți: " <<'\n';

    for (int i = 0; i < baieti.size()-1; i++)
    {
        out << i+1 << ". " << baieti[i] << '\n';
    }
    
    return 0;
}
