const long long INF = LLONG_MAX;
void dijkstra(int source,
              vector<long long> &distance,
              vector<int> &parent,
              vector<vector<pair<long long, int>>> &adj) {
    int n = adj.size();
    distance.assign(n, INF);
    parent.assign(n, -1);
    set<pair<long long, int>> q;
    distance[source] = 0;
    q.insert({0, source});
    while (!q.empty()) {
        int from = q.begin()->second;
        q.erase(q.begin());
        for (auto &[len, to] : adj[from])
            if (distance[from] + len < distance[to]) {
                q.erase({distance[to], to});
                distance[to] = distance[from] + len;
                q.insert({distance[from] + len, to});
                parent[to] = from;
            }
    }
}
vector<int> restore_path(int source, int destination, vector<int> &parent) {
    vector<int> path;
    for (int node = destination; node != -1 && node != source; node = parent[node])
        path.push_back(node);
    path.push_back(source);
    reverse(path.begin(), path.end());
    return path;
}

