#include <bits/stdc++.h>
using namespace std;

#define uid(a, b) uniform_int_distribution<int>(a, b)(rng)
mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());

void generate_graph() {
	vector<vector<array<int, 3>>> graph;
	bool weighted, directed, acyclic, one_indexed;
	int components, total_nodes, total_edges;
	components = 1;
	total_nodes = total_edges = 0;

	one_indexed = false;
	acyclic   	= false;
	weighted  	= false;
	directed  	= false;

	while (components--) {
		int num_nodes, num_edges, edges_min, edges_max, weight_min, weight_max;
		num_nodes = uid(1, 10);
		
		edges_min = num_nodes - 1;
		edges_max = num_nodes * (num_nodes - 1) / 2;

		if (directed) edges_max = num_nodes * (num_nodes - 1);
		if (acyclic) edges_max = num_nodes - 1;

		num_edges = uid(edges_min, edges_max);

		if (weighted) {
			weight_min = 1;
			weight_max = 100;
		}

		// {u, v, w}
		vector<array<int, 3>> edges;
		unordered_set<int> already_connected;

		for (int i = 1; i < num_nodes; i++) {
			int u = i;
			int v = uid(0, i - 1);
			int w = weighted ? uid(weight_min, weight_max) : 0;
			edges.push_back({u, v, w});
			already_connected.insert(u * num_nodes + v);
			if (directed == false) already_connected.insert(v * num_nodes + u);
		}

		for (int i = num_nodes - 1; i < num_edges; i++) {
			int u, v;
			bool flag;
			do {
				u = uid(0, num_nodes - 1);
				v = uid(0, num_nodes - 1);
				flag = (u == v || already_connected.count(u * num_nodes + v));
				if (directed == false) flag |= already_connected.count(v * num_nodes + u);
			} while (flag);
			int w = weighted ? uid(weight_min, weight_max) : 0;
			edges.push_back({u, v, w});
			already_connected.insert(u * num_nodes + v);
			if (directed == false) already_connected.insert(v * num_nodes + u);
		}

		graph.push_back(edges);
		total_nodes += num_nodes;
		total_edges += num_edges;	
	}

	cout << total_nodes << " " << total_edges << endl;
    // TODO: use offset because you have to increase the index of the vertices if we have muliple components
	for (auto &component : graph) {
		for (auto &[u, v, w] : component) {
			cout << u + one_indexed << " " << v + one_indexed << (weighted ? (" " + to_string(w) + "\n") : "\n");
		}
	}
}
