

m = {
    (0,0): [(0,1), (1,0)],
    (0,1): [(0,0), (0,2)],
    (0,2): [(0,1), (0,3)],
    (0,3): [(0,2), (0,4), (1,3)],
    (0,4): [(0,3), (0,5)],
    (0,5): [(0,4), (0,6)],
    (0,6): [(0,5), (0,7)],
    (0,7): [(0,6), (1,7)],
    (1,0): [(0,0), (2,0)],
    (1,3): [(0,3), (2,3)],
    (1,7): [(0,7), (2,7)],
    (2,0): [(1,0), (3,0)],
    (2,3): [(1,3), (3,3)],
    (2,7): [(1,7), (3,7)],
    (3,0): [(2,0), (4,0), (3,1)],
    (3,1): [(3,0), (3,2)],
    (3,1): [(3,0), (3,2)],
    (3,2): [(3,1), (3,3)],
    (3,3): [(3,2), (3,4), (2,3), (4,3)],
}

def dijkstra(adj_matrix, start, end):

    explored = set()
    border = { start: [] }

    def get_closest_unexplored():
        min_distance = -1
        closest = None
        import pdb; pdb.set_trace()
        for n, p in border.items():
            if closest is None or len(p) < min_distance:
                closest = n
                try:
                    min_distance = len(p)
                except:
                    import pdb; pdb.set_trace()
                    x = 5

        return closest

    def expand_node(node):
        explored.add(node)
        neighbors = adj_matrix.pop(node)
        path = border[node]
        npath = path + [node]

        for n in neighbors:
            if n not in border:
                border[n] = npath

        return path

    while end not in explored:
        p = expand_node(get_closest_unexplored())
        print explored
        print border
        import time; time.sleep(3)

    return p



if __name__ == "__main__":
    print dijkstra(m, (0,0), (3,3))
