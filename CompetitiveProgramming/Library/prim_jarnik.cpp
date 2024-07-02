const long long INF = LONG_LONG_MAX;
pair<long long, vector<vector<pair<int, long long>>>> prim(const vector<vector<pair<int, long long>>>& adj) {
	int n = (int)adj.size();
	vector<vector<pair<int, long long>>> mst(n);
	vector<bool> chosen(n);
	vector<pair<int, long long>> min_edge(n, {-1, INF});
	min_edge[0].second = 0LL;
	set<pair<long long, int>> s;
	s.insert({0LL, 0});

	long long sum = 0;
	while (n--) {
		if (s.empty()) return {-1, {}};
		int u = s.begin()->second;
		chosen[u] = true;
		s.erase(s.begin());
		if (min_edge[u].first != -1) {
			mst[u].push_back(min_edge[u]);
			mst[min_edge[u].first].push_back({u, min_edge[u].second});
			sum += min_edge[u].second;
		}
		for (auto [v, d] : adj[u])
			if (!chosen[v] && d < min_edge[v].second) {
				s.erase({min_edge[v].second, v});
				min_edge[v] = {u, d};
				s.insert({d, v});
			}
	}

	return {sum, mst};
}
