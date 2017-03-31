module TREE-SPEC
imports ALG4
rule 
<k>
 (while x!=NIL{
 	y=x;
 	if z.key<x.key
 		x=x.left
 	else x=x.right}
=>
.K)
...
</k>
<env>
...
x|->object(I1:Int)
y|->object(I2:Int)
z|->object(I3:Int)
...
</env>
<store>
...
object(I1)|->((value |->I1':Int left |->I2':Int right |->I3':Int )=> (value |->?_:Int left |->?_:Int right |->?_:Int ))
object(I2)|->((value |->I4:Int left |->I5:Int right |->I6:Int) => (value |->?_:Int left |->?_:Int right |-> ?_:Int ))
object(I3)|-> (value |->I7:Int left |->?_:Int right |->?_:Int )
...
</store>
<time>T:Int=>T1</time>
//requires I2'=/=Int NULL andBool I3'=/=Int NULL*/

/*rule
<k>
TREEINSERT(object(I1:Int),object(I2:Int))
=>
object(?I3:Int)
...
</k>
<env>
ENV:Map=>M2:Map
</env>
<store>
STORE:Map=>M1:Map
</store>
<fun> 
 ...
 FUN:Map
 ...
 </fun>
 <nextLoc>N:Int=>N':Int</nextLoc>
<time>T2:Int=>T1:Int</time> 
ensures T1>Int T2*/
 endmodule