## Graph Neighbors

A sketchpad for playing with some graph-based algorithms for procedural map-generation in Processing. Currently includes just a basic graph implementation of a 2D map for finding neighbors of a given cell. Plus some basic cell marking to expand out a map from seeds.

<img src="http://33.media.tumblr.com/720600b16334d4a4dca68dc5815f1337/tumblr_nkzf3yGhlb1tdqpqgo2_500.gif" />

Ideas:

* Use Djikstra Maps/A* to determine when the two starting seeds are connected to stop expanding
* Use 2D perlin noise instead of pure random to choose which adjacent square to expand to so shapes have more directionality

