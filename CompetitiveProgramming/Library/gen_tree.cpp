#include <bits/stdc++.h>
#ifdef ALE
	#include "/home/alls/CompetitiveProgramming/Library/debug.h"
#else
	#define dbg(...)
#endif
using namespace std;
#define uid(a, b) uniform_int_distribution<int>(a, b)(rng)
mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());

struct UF {
	vector<int> e;
	UF(int n) : e(n, -1) {}
	bool sameSet(int a, int b) { return find(a) == find(b); }
	int size(int x) { return -e[find(x)]; }
	int find(int x) { return e[x] < 0 ? x : e[x] = find(e[x]); }
	bool join(int a, int b) {
		a = find(a), b = find(b);
		if (a == b) return false;
		if (e[a] > e[b]) swap(a, b);
		e[a] += e[b]; e[b] = a;
		return true;
	}
};

void generate_tree(int sz) {
    cout << sz << '\n';
    auto uf = UF(sz);
    for (int cnt = 0; cnt < sz - 1; cnt++) {
        auto a = uid(0, sz - 1);
        auto b = uid(0, sz - 1);
        if (uf.sameSet(a, b)) {
            cnt--;
        } else {
            uf.join(a, b);
            a++, b++;
            cout << a << ' ' << b << '\n';
        }
    }
}

int32_t main() {
    cout << 1 << "\n"; // testcase
    generate_tree(uid(1, 7));
}
