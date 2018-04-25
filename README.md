# Implementation of a threaded linked list

This script is an implementation of a threaded linked list in Ruby. The linked list will be storing Books, Albums, and Movies. 
The user will pass in a file that contains the information about Books, Albums and Movies. The script will parse the file 
and store the file's content in the threaded linked list. 

# Why threaded linked list?
If, for instance, there is a movie and book with the same author/director, the threaded linked list won't create a separate
node for the author/director instead it'd continue from the old node and add a thread for the new information. This example can 
be extended to year as well. 

```
|_Direcror/Author
                  |_ Book      # Instead of having two different nodes for the director/author,
                  |_ Movie     # we just branch out from the previous one and that reduces node poulltion

```
