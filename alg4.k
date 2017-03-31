module ALG4-SYNTAX

syntax MainId ::= "main"   [token]
syntax Id::= "top"	| "tail" | "head" | "length" | "next" | "key" | "prev" | "NIL" | "left" | "right" | "root" |  "p" | "height" | "value"

syntax MyInt ::= Int | "NULL"
	syntax ReturnVal::= MyInt | Id | DotId
 	syntax DotId::=Id"."DotId
			  | Id
			   | "&" Id
			   | "*" Id
	syntax Symbol::= FunctionCall
				> MyInt | String | Id |DotId
 syntax AExp  ::=   String | "read" "(" ")"  
				 >  AriExp "mod" AriExp              [left, seqstrict]
				 | AriExp "*" AriExp              [left, seqstrict]
				|  AriExp "/" AriExp              [left, seqstrict]
				 >  AriExp "-" AriExp              [left, seqstrict]
				 | AriExp "+" AriExp		[left, seqstrict]
				 
				| AriExp "=" AriExp                [seqstrict(2)]
				| Param "=" AriExp
				
syntax BExp  ::= Bool 
				// | Symbol "<" Symbol
				 | AriExp "!=" AriExp             [seqstrict, latex({#1}\leq{#2})]
				  | AriExp "==" AriExp             [seqstrict, latex({#1}\leq{#2})]
				 | AriExp ">" AriExp             [seqstrict, latex({#1}\leq{#2})]
				 | AriExp "<" AriExp             [seqstrict, latex({#1}\leq{#2})]
				  | BExp "and" BExp      [left, strict(1)]
				 | BExp "or" BExp       [left, strict(1)]

  syntax Block ::="{" Stmts "}"

  syntax Stmt  ::= Block 
				  | AExp
				| FunctionCall 
				 | Param
				 
				 | "if"  BExp Stmt       [strict(1)]
				 | "if"  BExp Stmt "elseif" BExp Stmt "else" Stmt      [strict(1, 3)]
				 > "if"  BExp Stmt "else" Stmt         [strict(1), avoid]
				 | "while" BExp Stmt
			//	 | "return" "("Id "(" AriExp"," AriExp ")"")"  [seqstrict(2,3)]
				//| "return" "(" FunctionCall")" // [seqstrict(2)]
				 | "return" "(" AriExp ")" [strict]

				
			 

 syntax Stmts ::= List{Stmt,";"}
  // syntax Ids   ::= List{Id,","} 
syntax AriExp::=AExp | Symbol
syntax AriExps::=List{AriExp, ","} [seqstrict]
syntax FunctionDef::= Type Id "("Params ")" // [seqstrict(3)]
syntax Type::="int" | "void" | "bool" | "struct" Id | "tree" | "node" | "Troot"
syntax Param::=Type Id
syntax Params::=List{Param, ","}
//syntax VariDecls::=List{Param, ";"}
//syntax FunctionCall::= Id "(" AriExps ")"  //[seqstrict(2)]
//syntax FunctionCall::= Id "(" AriExps")" [seqstrict(2)]	
syntax FunctionCall::= Id "(" AriExp"," AriExp ")" [seqstrict(2,3)]		
syntax MyInts::=List{MyInt, ","}				 

syntax Sep::= "|"
	syntax MainPgm::=MainId "(" ")" Block	
syntax FunPgm::=FunctionDef Stmts
syntax FunPgms::=List{FunPgm, "|"}

//syntax StructDeclaration ::= "struct" Id "{" VariDecls "}" 


syntax Pgm ::= FunPgms Sep MainPgm
            // | StructDeclaration
			 //| FunPgms

syntax Id::="a"   [token]
		   | "b"  [token]
		   | "t"   [token]
		   | "m"  [token]
		   | "n"  [token]
		   | "x"  [token]
		   | "y"  [token]
		   | "z"  [token]
		   | "GCD" [token]
		   | "EUCLID" [token]
		   | "TreeNode" [token]
		   | "TREEINSERT" [token]
		  // | "main" [token]
				  
endmodule



module ALG4
  imports ALG4-SYNTAX
 // imports ALG-CONFIGURATION
   syntax KResult ::= MyInt | Bool | String

  
  configuration <T color="yellow">
  // thread
 
  <k> $PGM:Pgm</k>
  <env>.Map</env>
  <tid>.K</tid>
  <struct> .Map </struct>

	  <fun>.Map</fun>
	
	   <fstack color="blue"> .List </fstack>
	  //global
	  <store>.Map</store>
     <nextLoc>0</nextLoc>
       //Standard input and output
	   <in color="magenta" stream="stdin"> .List </in>
       <out color="Orchid" stream="stdout"> .List </out> 
		<time>0</time>
		 
                </T>
  

  syntax KItem::="(" KItem "," Map ")"
				//| "(" Map "," MyInt ")"
				| "(" Type "," MyInt ")"
			//	| "<" Map ">"
	syntax MyInt::= "object" "(" MyInt ")"
	             | "&" "object" "(" MyInt ")"
				 | "NULL"
				  | "<" Map ">"
  rule NIL=> NULL  [macro]
  rule <k>  tree X:Id=>. ...</k>
     <env> M1:Map(.Map=>X:Id|->object(N:Int))</env>
     <store> M:Map=>M(object(N:Int)|->(height|->0 root|->NULL)) </store>
	   <nextLoc>N:Int=>N+Int 1</nextLoc>
	 
  rule <k> node X:Id=>. ...</k>
   <env> M1:Map(.Map=>X:Id|->object(N:Int))</env>
       <store> ... .Map=>object(N)|->(value|->NULL left|->NULL right|->NULL) ...</store>
	    <nextLoc>N:Int=>N+Int 1</nextLoc>
	
  rule <k> X.root=>I1 ...</k>
       <env> ... X:Id|->object(I:Int) ...</env>
       <store> ...(object(I)|->(height|->0 root|->I1:MyInt)) ...</store>
	   //when M=/=K NULL
  

  
  rule <k> X.key=>I1:MyInt ...</k>
  <env> ... X:Id|->object(I:Int) ...</env>
      <store> ... (object(I)|->(value|->I1 left|->I2:MyInt right|->I3:MyInt ))...</store>
	  

		
   rule <k> X.right=>I3 ...</k>
        <env> ... X:Id|->object(I:MyInt) ...</env>
         <store> ... (object(I)|->(value|->I1:MyInt left|->I2:MyInt right|->I3:MyInt))  ...</store>
		 
   rule <k> X.left=>I2 ...</k>
        <env> ... X:Id|->object(I:MyInt) ...</env>
         <store> ... (object(I)|->(value|->I1:MyInt left|->I2:MyInt right|->I3:MyInt))  ...</store>
  
    
		 
	
		
   rule <k> X.right=I:MyInt =>. ...</k>
	<env> ... X:Id|->object(I1:MyInt) ...</env>
	<store> ...(object(I1)|->(value|->I3:MyInt left|->I2:MyInt right|->(_=>I)))  ...</store>
	
	
	   rule <k> X.left=I:MyInt =>. ...</k>
	<env> ... X:Id|->object(I1:MyInt) ...</env>
	<store> ...(object(I1)|->(value|->I3:MyInt left|->(_=>I) right|->I2:MyInt))  ...</store>
	
	
		
 	rule <k>X.root=I:MyInt =>. ...</k>
	     <env> ... X:Id|->object(I1:MyInt) ...</env>
	     <store> ... (object(I1)|->(height|->0 root|->(_=>I)))...</store>
  
  rule <k> X:Id=object(I)=>. ... </k>
       <env> ... X:Id|->object(I1:MyInt) ...</env>
      <store> ... (object(I)|->K) (object(I1)|->(_=>K))...</store>

 rule 	<k> *X=> &object(I) ... </k>
        <env> ... X:Id|->object(I:MyInt) ...</env>
		
rule <k> X:Id=&object(I)=>. ... </k>

       <env> ... X:Id|->object(I1:MyInt) ...</env>
	   <store> ... ((object(I1)|->_)=>.Map) (object(I=>I1)|->_) ...</store>
	  
	  
  rule <k> X:Id=NULL=>. ...</k>
        <env> ... X:Id|->object(I1:MyInt) ...</env>
       <store> ... object(I1)|->(_=>(value|->NULL left|->NULL right|->NULL))...</store>
	   
	rule <k>X:Id=>NULL ...</k>
	<env> ... X:Id|->object(I1:MyInt) ...</env>
	     <store> ... object(I1)|->(value|->NULL left|->NULL right|->NULL) ...</store>
		// when object(X) in keys(M)
		
		rule <k>X:Id=>object(I1) ...</k>
		<env> ... X|->object(I1:MyInt) ...</env>
	     <store> ... object(I1)|->(value|->I2:MyInt left|->I3:MyInt right|->I4:MyInt) ...</store> 
		 when I2=/=K NULL
		 
		 rule <k>X:Id=>object(I1) ...</k>
		<env> ... X|->object(I1:MyInt) ...</env>
	     <store> ... object(I1)|->(height|->0 root|->I2:MyInt) ...</store> 
		 
	rule X:Id.p=I:MyInt=>.	
		 
		 
	rule <k> X.key=I:MyInt=>. ...</k>
	<env> ... X:Id|->object(I1:MyInt) ...</env>
	    <store> ... object(I1)|->(value|->(_=>I) left|->I2:MyInt right|->I3:MyInt) ...</store>
		 
	//rule <k> 
  
syntax KItem ::= mkDecls(Params,AriExps)  [function]

  rule mkDecls((T:Type X:Id, Ps:Params), (V:AriExp, Vs:AriExps))
    => T X~>X=V~> mkDecls(Ps,Vs)
	
  rule mkDecls(.Params,.AriExps) => .K

 /* rule <k>X:Id=>I:MyInt...</k>
	   <env>...X|->N...</env>
	   <store>...N|->I...</store>*/
  
 rule <k> int X:Id=>. ...</k>
        <env> Rho => Rho[X <- !N:MyInt] </env>
       <store>... .Map => !N |-> 0 ...</store>
	
  /* rule <k>X:Id=>?N1:MyInt...</k>
	   <env>Rho=>Rho[X<-!N:MyInt]</env>
	   <store>M:Map=>M[!N<-?N1:MyInt]</store>	
	   when notBool (X in keys(Rho))*/
	   
 
  rule I1 - I2 => I1 -Int I2
  rule I1 mod I2 => I1 %Int I2
  
 /*rule <k> X:Id = I:MyInt => .K ...</k>
       <env>... X |-> N ...</env>
       <store>... N |-> (_ => I) ...</store>*/
         
	  
 /*rule <k>	X:Id = I:MyInt =>I; ...</k>
	   <env>Rho=>Rho[X<-!N:MyInt]</env>
	  <store>M:Map=>M[!N<-I]</store>
	   when notBool (X in keys(Rho))*/
	   
   rule <k> read() => I ...</k>
     <in> (ListItem(I:MyInt) => .List) ...</in>  
	 [read]
	   
// BExp
 
  rule I1 != I2 => I1 =/=Int I2
 rule I1 == I2 => I1 ==Int I2
  rule I1 > I2 => I1 >Int I2
  rule I1 < I2 => I1 <Int I2
  rule true or _ => true
 rule false or B:BExp=>B
  rule true and B => B
  rule false and _ => false

  
  
 //Stmt
 syntax KItem::= MyInt ";"
 rule  _:MyInt; => .
 //rule ;=>.
 
  rule if true  S else _ => S
  rule if false _ else S => S
  rule if true S=>S
  rule if false _=>.Stmts
   rule if true S elseif B _ else _=>S
  rule if false _ elseif true S else _=>S
  rule if false _ elseif false _ else S=>S
  rule <k>while B S => if B {S; while B S} else {.Stmts} ...</k> <time>T:Int=>T+Int 1</time>  [structural]
 
   rule <k> {Ss:Stmts} => Ss ...</k>   [structural]
  // Stmts
  rule .Stmts => .                 [structural]
  rule S:Stmt; Ss:Stmts => S ~> Ss  [structural]

/*  syntax Map ::= "makeMemberMap""("VariDecls")"    [function]
  rule makeMemberMap(T:Type X:Id; VDs:VariDecls)
    => X |-> T makeMemberMap(VDs)
  rule makeMemberMap(.VariDecls) => .Map

  rule
    <k> struct S:Id { VDs:VariDecls } => .K ...</k>
    <struct>... .Map => S |-> makeMemberMap(VDs) ...</struct>
    [structural]*/

  
  
  
//functionDefinition  
syntax KItem ::= "functionBody""(" Param"," Param"," Type"," Stmts")"
			   //| "execute"




rule <k>(T:Type F:Id(P1:Param, P2:Param) Ss:Stmts |F1:MainId() B:Block=>F1:MainId() B:Block)</k>
   //  <funs>(FB:Bag=>FB<fun><fun-id>F</fun-id> <funBody> Ss</funBody><para>Ps</para></fun>)</funs>
	 <fun> ... .Map=>F|->functionBody(P1, P2, T, Ss) ...</fun>
	requires F=/=K main

rule <k>(T:Type F:Id(P1:Param, P2:Param) Ss:Stmts | FP:FunPgms |MP:MainPgm)=>(FP |MP)</k>
    // <funs>(FB:Bag=>FB<fun><fun-id>F</fun-id> <funBody> Ss</funBody><para>Ps</para><returns>.K</returns></fun>)</funs>
	<fun> ... .Map=>F|->functionBody(P1, P2, T, Ss) ...</fun> 
	requires F=/=K main		
	rule .FunPgms | F1:MainId() B:Block =>F1:MainId() B:Block
rule <k> F:MainId() B:Block=>B ...</k>
     <tid>_=>F</tid>
    requires F==K main
	

rule .FunPgms=>.
rule .AriExps=>.

	
// Function Call

syntax KItem::="(" Map "," Map "," K ")"
			  | "clearEnv"
syntax Map::= "delete" "("Map "," Map ")" [function]
			  
rule delete((I1|->I2) M1:Map, I1|->I2 M:Map)=>delete(M1, M)
rule delete(M:Map, .Map)=>M


rule T:Type A1:Id=A2:AriExp =>T A1~>A1=A2


rule <k>(F1:Id(A1:MyInt, A2:MyInt)~>K) =>(P1:Param=A1~>P2:Param=A2~>Ss)</k>
<fstack> .List => ListItem((Env, .Map, K)) ...</fstack>
	//rule <k>(F1:Id(Vs:AriExps) =>mkDecls(Ps, Vs)~>B)... </k>
     <tid>F</tid>
	// <fid>_=>F1</fid>
	 <fun> ...F1|->functionBody(P1, P2, _:Type, Ss:Stmts)
    ...</fun>
	 <env> Env:Map=>.Map </env>
	 <store> STORE:Map</store>
	// <gstore>_=>STORE:Map </gstore>
	 <time>T:Int =>T+Int 1</time>
	requires F==K main

/*rule <k>clearEnv=>.K ...</k>
     <fstack>ListItem((Env, STORE, K))</fstack>
     <env>M:Map=>delete(M, Env:Map)</env>
	 <store>M1:Map=>delete(M1, STORE:Map)</store>*/

/*	rule <k>((F1:Id(Is:AriExps)~>K) =>mkDecls(Ps, Is)~>Ss)</k>
	//rule <k>(F1:Id(Is:MyInt) =>mkDecls(Ps, Vs)~>B)... </k>
      <fstack> .List => ListItem((Env, STORE, K)) ...</fstack>
	 <tid>F</tid>
	 <fid>_=>F1</fid>
	// <fun><fun-id>F1</fun-id> <funBody> B</funBody><para>Ps:Params</para></fun>
	 <fun> ...F1|->functionBody(Ps:Params, _:Type, Ss:Stmts)
    ...</fun>
	 <env> Env:Map=>.Map </env>
	 <store> STORE:Map=>.Map</store>
	 <time>T:MyInt=>T+MyInt 1</time>
	requires F==K main*/
	
/*	rule <k>(return (F1:Id(Vs:AriExps))=>mkDecls(Ps, Vs)~>B)...</k>
		 <tid>F</tid>
	 <fid>_=>F1</fid>
	 <fun><fun-id>F1</fun-id> <funBody> B</funBody><para>Ps</para></fun>
	 <env> Env:Map </env>
	 <time>T:MyInt=>T+MyInt 1</time>
	requires F==K main*/

rule <k>(return (F1:Id(A1:MyInt, A2:MyInt)))~>_=>F1:Id(A1:MyInt, A2:MyInt)~>K</k>
<env>_=>Env</env>
//<store> _=>STORE </store>
	 <fstack> ListItem((Env, STORE:Map, K)) => .List ...</fstack>
	

	syntax KItem::="tv" "(" MyInt")" 
				  | "tv" "(" Id ")"
	
rule <k>(return (I:MyInt))~>_ =>I~>K</k>
  //   <fid>F</fid>
	 <env>_=>Env</env>
	// <store> _=>STORE </store>
	// <gstore> _=>STORE:Map </gstore>
	 <fstack> ListItem((Env, STORE:Map, K)) => .List ...</fstack>
    
	 
rule <k>tv(I:Id)=> .K ... </k>
     <tid>_=>.K</tid>
	// <fid>_=>.K </fid>
	 <env>M:Map=>.Map</env>
	 <store>M1:Map=>.Map</store>
	//  <fstack> _:List => .List</fstack>

endmodule
