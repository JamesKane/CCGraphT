CCGraphT is a quick port of jgrapht to Objective-C using Cocoa APIs
available to both OS X and iOS.   Emphasis is placed on getting the
library working and available over removing the Java smells from the
design.  Once all functionality is complete, a fork will be created
to leverage Cocoa better and make the API more Apple-like.

The code remains largely incomplete at the moment, and represents
what one could call a Rube Goldberg solution to Dijkstra's algorithm
backed with a Fibonacci heap.  Documentation is sorely lacking, so 
any one chosing to use this code at the moment will need to rely on
reading the test units, and the jgrapht documentation to infer proper use.

Like jgrapht the code is placed under the GNU LESSER GENERAL PUBLIC LICENSE
Version 2.1, February 1999.  See license-lgpl.txt for more information.
