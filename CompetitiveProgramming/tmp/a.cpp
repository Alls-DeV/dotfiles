#include <bits/stdc++.h>
#ifdef ALE
	#include "/home/alls/CompetitiveProgramming/Library/debug.h"
#else
	#define dbg(...)
#endif
using namespace std;

void solve() {
	int n; cin >> n;
	vector<int> a(2 * n); for (auto &_ : a) cin >> _;
	sort(a.rbegin(), a.rend());

	int x = 0;
	for (int i = 
}
 
int32_t main() {
    cin.tie(0)->sync_with_stdio(0);
    int t = 1;
    cin >> t;
    for (int TEST_CASE = 1; TEST_CASE <= t; TEST_CASE++) {
        dbg(TEST_CASE);
        solve();
    }
}
