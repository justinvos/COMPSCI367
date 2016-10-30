class Stack:
    def __init__(items):
        self.items = items

    def push(self, item):
        items += [item]

    def peek(self):
        return items[-1]

    def pop(self):
        return self.items.pop()

class Queue:
    def __init__(items=[]):
        self.items = items

    def enqueue(self, item):
        items += [item]

    def peek(self):
        return items[0]

    def dequeue(self, item):
        return items.pop(0)

class Vertex:
    def __init__(self, data=""):
        self.data = data

    def __repr__(self):
        return self.data

class Edge:
    def __init__(self, v1, v2, cost=1):
        self.vertices = [v1, v2]
        self.cost = cost

    def __repr__(self):
        return str(self.vertices[0]) + " to " + str(self.vertices[1]) + ". Cost:" + str(self.cost)

    def getOther(self, vertex):
        if vertex == self.vertices[0]:
            return self.vertices[1]
        if vertex == self.vertices[1]:
            return self.vertices[0]
        return None

    def getConnector(self, e2):
        if self.getOther(self.vertices[0]) in e2.vertices:
            return self.vertices[0]
        if self.getOther(self.vertices[1]) in e2.vertices:
            return self.vertices[1]

class Path:
    def __init__(self, vertices=[], cost=0):
        self.vertices = vertices
        self.cost = cost

    def getStart(self):
        return self.vertices[0]

    def getEnd(self):
        return self.vertices[-1]

    def __repr__(self):
        output = str(self.cost) + ": ["
        for vertex in self.vertices:
            output += str(vertex) + ", "
        output = output[:-2] + "]"
        return output

class Graph:
    def __init__(self, vertices, edges):
        self.vertices = vertices
        self.edges = edges

    def getEdges(self, vertex):
        vertex_edges = []
        for edge in self.edges:
            other = edge.getOther(vertex)
            if other != None:
                vertex_edges += [edge]
        return vertex_edges


auckland = Vertex("Auckland")
hamilton = Vertex("Hamilton")
whangarei = Vertex("Whangarei")
tauranga = Vertex("Tauranga")
rotorua = Vertex("Rotorua")
taupo = Vertex("Taupo")
gisborne = Vertex("Gisborne")

vertices = [auckland, hamilton, whangarei, tauranga, rotorua, gisborne]
edges = [Edge(auckland, whangarei, 158), Edge(auckland, hamilton, 125), Edge(auckland, tauranga, 201), Edge(hamilton, tauranga, 105), Edge(hamilton, rotorua, 106), Edge(rotorua, gisborne, 274), Edge(tauranga, gisborne, 273), Edge(tauranga, rotorua, 64), Edge(rotorua, taupo, 82), Edge(taupo, gisborne, 328)]

g = Graph(vertices, edges)

#auckland_edges = g.getEdges(auckland)
#for edge in auckland_edges:
    #print(edge)

def depth_first_search(graph, start, goal, stack=None):
    if stack == None:
        stack = [Path([start])]

    path = stack[-1]
    end = path.getEnd()
    if end == goal:
        return path

    edges = graph.getEdges(end)
    for edge in edges:
        next_vertex = edge.getOther(end)
        if next_vertex not in path.vertices:
            stack += [Path(path.vertices + [next_vertex], path.cost + edge.cost)]
            output = depth_first_search(graph, start, goal, stack)
            if output != None:
                return output

    print(stack[-1])
    stack.pop()
    return None

def breadth_first_search(graph, start, goal):
    i = 0
    queue = [Path([start])]
    while len(queue) > 0:
        path = queue[0]
        end = path.getEnd()
        if end == goal:
            return path
        for edge in graph.getEdges(end):
            next_vertex = edge.getOther(end)
            if next_vertex not in path.vertices:
                queue += [Path(path.vertices + [next_vertex], path.cost + edge.cost)]
        queue.pop(0)
        i += 1
        print(str(i) + ". " + str(queue))


print(depth_first_search(g, auckland, gisborne))
print(breadth_first_search(g, auckland, gisborne))
