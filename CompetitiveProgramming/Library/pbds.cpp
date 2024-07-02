#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
// we can use custom cmp
//auto cmp = [](const auto &a, const auto &b) { return ...; };
template<typename T> using ordered_set = __gnu_pbds::tree<T, __gnu_pbds::null_type, less<T>/*decltype(cmp)*/, __gnu_pbds::rb_tree_tag, __gnu_pbds::tree_order_statistics_node_update>;
template<typename K, typename V> using ordered_map = __gnu_pbds::tree<K, V, less<K>, __gnu_pbds::rb_tree_tag, __gnu_pbds::tree_order_statistics_node_update>;
// os.find_by_order();  iterator to the k-th largest element (counting from zero)
// os.order_of_key();   number of items in a set that are strictly smaller than our item
