LEX = flex
CC = gcc
CFLAGS = -Wall

mylexer: lex.yy.c
	$(CC) $(CFLAGS) -o mylexer lex.yy.c -lfl

lex.yy.c: mylexer.l
	$(LEX) mylexer.l

clean:
	rm -f lex.yy.c mylexer
