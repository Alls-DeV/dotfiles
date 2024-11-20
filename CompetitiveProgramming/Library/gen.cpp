#include <bits/stdc++.h>
#ifdef ALE
	#include "/home/alls/CompetitiveProgramming/Library/debug.h"
#else
	#define dbg(...)
#endif
using namespace std;
#define uid(a, b) uniform_int_distribution<int>(a, b)(rng)
mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
template<typename T>
void print(vector<T> v) {
	auto sz = v.size();
	// cout << sz << "\n";
	for (int i = 0; i < sz; ++i) {
		cout << v[i] << " \n"[i == sz - 1];
	}
}
template<typename T>
vector<T> gen_vector(size_t sz, T low, T high) {
	vector<T> ans;
	for (int i = 0; i < sz; i++) {
		ans.push_back(uid(low, high));
	}
	return ans;
}
string gen_string(size_t sz) {
	string alpha = "abcdefghijklmnopqrstuvwxyz";
	string ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	string num = "0123456789";
	string characters;
	characters += alpha;
	characters += ALPHA;
	characters += num;
	string ans;
	for (int i = 0; i < sz; i++) {
		ans.push_back(characters[uid(0, characters.size() - 1)]);
	}
	return ans;
}
vector<int> gen_permutation(size_t sz) {
	vector<int> ans(sz);
	iota(ans.begin(), ans.end(), 1);
	shuffle(ans.begin(), ans.end(), rng);
	return ans;
}
string gen_RBS(size_t sz) {
	assert(sz % 2 == 0);
	string ans, brackets = "()";
	int cnt = 0;
	for (int i = 0; i < sz; i++) {
		if (cnt == 0) {
			ans.push_back(brackets[0]);
			cnt++;
		} else if (sz - i == cnt) {
			ans += string(cnt, brackets[1]);
			break;
		} else {
			int x = uid(0, 1);
			if (x == 0) {
				ans.push_back(brackets[0]);
				cnt++;
			} else {
				ans.push_back(brackets[1]);
				cnt--;
			}
		}
	}
	return ans;
}
int32_t main() {
    cout << 1 << "\n"; // testcase
}
