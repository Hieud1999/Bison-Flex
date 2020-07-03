bison -d compiler.y
flex compiler.l
gcc -o compiler compiler.tab.c lex.yy.c