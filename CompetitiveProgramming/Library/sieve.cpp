int n;
vector<bool> is_prime(n + 1, true);
is_prime[0] = is_prime[1] = false;
for (int i = 4; i <= n; i += 2) is_prime[i] = false;
//vector<int> primes;
//primes.push_back(2);
for (int i = 3; i * i <= n; i += 2) {
    if (is_prime[i]) {
        //primes.push_back(i);
        for (int j = i * i; j <= n; j += i) {
            is_prime[j] = false;
        }
    }
}
