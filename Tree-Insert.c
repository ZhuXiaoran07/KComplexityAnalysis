// P294

/*struct treeNode {
	int key;
	//int height;
	struct treeNode left;
	struct treeNode right
	// node root
};*/

int TREEINSERT(tree T, node z)
node y;
node x;
//int NIL
y=NIL;
 x=T.root;
 //y=T.root
 while x!=NIL{
 	y=x;
 	if z.key<x.key
 		x=x.left
 	else x=x.right};
 z.p=y;
 if y==NIL
 	T.root=z //tree T was empty
 elseif z.key<y.key
 	y.left=z
else y.right=z;
return (T)
|

/*int TREESEARCH(node x, int k)
if x==NIL or k==x.key
 	return (x)
 if k<x.key
 	return (TREESEARCH(x.left,k))
else return (TREESEARCH(x.right,k))
 
/* |
 void INORDERTREEWALK(node x)
 {if x!=NIL{
	INORDERTREEWALK(x.left)
	print (x.key)
 INORDERTREEWALK(x.right)}}
|
void ITERATIVETREESEARCH(node x, int k)
while x!=NIL and k!=x.key
	if k<x.key
		x=x.left
	else x=x.right
return (x)
 |*/

 main()
 { 
	  tree T1;
	 node A;
	 node B;
	 node C;
	 A.key=10;
	B.key=11;
     C.key=9; 
	T1= TREEINSERT(T1,A);
	 T1= TREEINSERT(T1,B);
     T1= TREEINSERT(T1,C)
	
	// INORDERTREEWALK(root)
	// ITERATIVETREESEARCH(A,B.key)
	 //TREESEARCH(A,B.key)
	
 }