#include <bits/stdc++.h>
#ifdef ALE
	#include "/home/alls/CompetitiveProgramming/Library/debug.h"
#else
	#define dbg(...)
#endif
using namespace std;
#define uid(a, b) uniform_int_distribution<int>(a, b)(rng)
mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
void gen_vector(int sz, int low, int high) {
	// cout << sz << "\n";
	for (int i = 0; i < sz; i++) {
		cout << uid(low, high) << " \n"[i == sz - 1];
	}
}
void gen_string(int sz) {
	string alpha = "abcdefghijklmnopqrstuvwxyz";
	string ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	string num = "0123456789";
	string characters = alpha + ALPHA + num;
	// cout << sz << "\n";
	for (int i = 0; i < sz; i++) {
		cout << characters[uid(0, characters.size() - 1)];
	}
	cout << "\n";
}
void gen_permutation(int sz) {
	vector<int> v(sz);
	iota(v.begin(), v.end(), 1);
	shuffle(v.begin(), v.end(), rng);
	// cout << sz << "\n";
	for (int i = 0; i < sz; i++) {
		cout << v[i] << " \n"[i == sz - 1];
	}
}
void gen_RBS(int sz) {
	assert(sz % 2 == 0);
	string s = "()";
	// cout << sz << "\n";
	int cnt = 0;
	for (int i = 0; i < sz; i++) {
		if (cnt == 0) {
			cout << s[0];
			cnt++;
		} else if (sz - i == cnt) {
			cout << string(cnt, s[1]);
			break;
		} else {
			int x = uid(0, 1);
			if (x == 0) {
				cout << s[0];
				cnt++;
			} else {
				cout << s[1];
				cnt--;
			}
		}
	}
	cout << "\n";
}
int32_t main() {
    cout << 1 << "\n"; // testcase
	// cout << endl;
}
