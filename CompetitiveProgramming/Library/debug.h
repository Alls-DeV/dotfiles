#include <bits/stdc++.h>
#define RESET "\033[0m"
std::vector<std::string> colors = {"\033[0;31m", "\033[0;32m", "\033[0;33m", "\033[0;34m", "\033[0;35m", "\033[0;36m", "\033[0;37m"};
std::size_t index_color = 0;
void __print(int x) { std::cerr << x; }
void __print(long x) { std::cerr << x; }
void __print(long long x) { std::cerr << x; }
void __print(unsigned x) { std::cerr << x; }
void __print(unsigned long x) { std::cerr << x; }
void __print(unsigned long long x) { std::cerr << x; }
void __print(float x) { std::cerr << x; }
void __print(double x) { std::cerr << x; }
void __print(long double x) { std::cerr << x; }
void __print(char x) { std::cerr << '\'' << x << '\''; }
void __print(const char *x) { std::cerr << '\"' << x << '\"'; }
void __print(const std::string &x) { std::cerr << '\"' << x << '\"'; }
void __print(bool x) { std::cerr << (x ? "true" : "false"); }
//void __print(bool x) { std::cerr << (x ? "1" : "0"); }
void _print() { std::cerr << std::endl; }
template <typename T>
void __print(const T &x);
template <typename T, typename... V>
void _print(T t, V... v);
template <typename T, typename V>
void __print(const std::pair<T, V> &x);
// uncomment the next two lines to print vector of vector as matrix
template <typename T>
void __print(std::vector<std::vector<T>> x);
template <typename T>
void __print(std::queue<T> x);
template <typename T>
void __print(std::stack<T> x);
template <typename T>
void __print(std::priority_queue<T> x);

template <typename T>
void __print(const T &x)
{
    int f = 0;
    std::cerr << "{";
    for (auto i : x)
        std::cerr << (f++ ? ", " : ""), __print(i);
    std::cerr << "}";
}

template <typename T, typename... V>
void _print(T t, V... v)
{
    std::cerr << colors[index_color];
    __print(t);
    std::cerr << RESET;
    if (sizeof...(v))
        std::cerr << "  ";
    index_color = (index_color + 1) % colors.size();
    _print(v...);
}

template <typename T, typename V>
void __print(const std::pair<T, V> &x)
{
    std::cerr << "(";
    __print(x.first);
    std::cerr << ", ";
    __print(x.second);
    std::cerr << ")";
}

template <typename T>
void __print(std::vector<std::vector<T>> x)
{
    std::cerr << "\n";
    for (int i = 0; i < (int)x.size(); i++)
    {
        if (x[i].size() == 0)
            std::cerr << "{}\n";
        else
            for (int j = 0; j < (int)x[i].size(); j++)
            {
                __print(x[i][j]);
                std::cerr << (j != (int)x[i].size() - 1 ? " " : "\n");
            }
    }
}

template <typename T>
void __print(std::queue<T> x)
{
    std::cerr << "{";
    // The front of the std::queue is the most left element
    while (!x.empty())
    {
        __print(x.front());
        std::cerr << (x.size() != 1 ? " " : "");
        x.pop();
    }
    std::cerr << "}";
}

template <typename T>
void __print(std::stack<T> x)
{
    std::cerr << "{";
    while (!x.empty())
    {
        __print(x.top());
        std::cerr << (x.size() != 1 ? " " : "");
        x.pop();
    }
    std::cerr << "}";
}

template <typename T>
void __print(std::priority_queue<T> x)
{
    std::cerr << "{";
    while (!x.empty())
    {
        __print(x.top());
        std::cerr << (x.size() != 1 ? " " : "");
        x.pop();
    }
    std::cerr << "}";
}

void _print_name(std::string names)
{
    std::cerr << " ";
    std::size_t index = 0;
    std::cerr << colors[index];
    bool flag = false;
    for (int i = 0; i < (int)names.size(); i++)
    {
        if (names[i] == '(')
            flag = true;
        if (names[i] == ')')
            flag = false;
        if (flag == false && names[i] == ',')
        {
            index = (index + 1) % colors.size();
            std::cerr << colors[index] << "  ";
            i++;
        }
        else
            std::cerr << names[i];
    }
    std::cerr << RESET << " : ";
}
#define dbg(x...) index_color = 0; std::cerr << colors[3] << __LINE__ << RESET; _print_name(#x); _print(x);
