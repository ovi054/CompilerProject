bison -d prog.y
flex prog.l 
gcc lex.yy.c prog.tab.c -o app
app