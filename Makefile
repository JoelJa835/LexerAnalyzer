LEX = flex
CC = gcc
CFLAGS = -Wall

mycompiler: myanalyzer.tab.c lex.yy.c cgen.c
	$(CC) $(CFLAGS) -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl

myanalyzer.tab.c: myanalyzer.y
	bison -d -v -r all myanalyzer.y

lex.yy.c: mylexer.l
	$(LEX) mylexer.l


clean:
	rm -f lex.yy.c myanalyzer.tab.c mycompiler
