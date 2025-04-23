#include <bits/stdc++.h>
#ifdef ALE
#include "/home/alls/CompetitiveProgramming/Library/debug.h"
#else
#define dbg(...)
#endif
using namespace std;

/*
n  sett : 2  {"123"}
n  sett : 3  {"1124"}
n  sett : 4  {"11125", "11133", "11222"}
n  sett : 5  {"111126"}
n  sett : 6  {"1111127", "1111134"}
n  sett : 7  {"11111128", "11111223"}
n  sett : 8  {"111111129", "111111135"}
n  sett : 9  {"1111111144"}
*/

#define int long long
void solve() {
	for (int n = 2; n < 13; n++) {
		set<string> sett;
		for (int i = pow(10, n); i < pow(10, n + 1); i++) {
			auto ss = to_string(i);
			sort(ss.begin(), ss.end());
			int p = 1, s = 0;
			for (auto c : ss) {
				p *= (c - '0');
				s += (c - '0');
			}
			if (p == s) {
				sett.insert(ss);
			}
		}
		dbg(n, sett);
	}
}

int32_t main() {
	cin.tie(0)->sync_with_stdio(0);
	int t = 1;
	/*cin >> t;*/
	for (int TEST_CASE = 1; TEST_CASE <= t; TEST_CASE++) {
		dbg(TEST_CASE);
		solve();
	}
}
