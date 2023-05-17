%{
  #include <stdio.h>
  #include "cgen.h"
	
	extern int yylex(void);
%}

%union {
	char* str;
}



%token KEYWORD_INTEGER
%token KEYWORD_SCALAR
%token KEYWORD_STR
%token KEYWORD_BOOLEAN
%token KEYWORD_TRUE
%token KEYWORD_FALSE
%token KEYWORD_CONST
%token KEYWORD_IF
%token KEYWORD_ELSE
%token KEYWORD_ENDIF
%token KEYWORD_FOR
%token KEYWORD_IN
%token KEYWORD_ENDFOR
%token KEYWORD_WHILE
%token KEYWORD_ENDWHILE
%token KEYWORD_BREAK
%token KEYWORD_CONTINUE
%token KEYWORD_NOT
%token KEYWORD_AND
%token KEYWORD_OR
%token KEYWORD_DEF
%token KEYWORD_ENDDEF
%token KEYWORD_MAIN
%token KEYWORD_RETURN
%token KEYWORD_COMP
%token KEYWORD_ENDCOMP
%token KEYWORD_OF



%token <str> TK_IDENTIFIER
%token <str> TK_CONST_INT
%token <str> TK_CONST_FLOAT
%token <str> TK_CONST_STRING


%token ARITHMETIC_OPERATOR_PLUS
%token ARITHMETIC_OPERATOR_MINUS
%token ARITHMETIC_OPERATOR_MULT
%token ARITHMETIC_OPERATOR_DIVISION
%token ARITHMETIC_OPERATOR_MODULO 
%token RITHMETIC_OPERATOR_EXP


%token RELATIONAL_OPERATOR_EQUALS
%token RELATIONAL_OPERATOR_NOTEQUALS
%token RELATIONAL_OPERATOR_LESS
%token RELATIONAL_OPERATOR_LESS_EQUALS
%token RELATIONAL_OPERATOR_MORE
%token RELATIONAL_OPERATOR_MORE_EQUALS

%token ASSIGNMENT_OPERATOR_ASSIGN
%token ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN
%token ASSIGNMENT_OPERATOR_PLUS_ASSIGN
%token ASSIGNMENT_OPERATOR_MINUS_ASSIGN
%token ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN
%token ASSIGNMENT_OPERATOR_DIVISION_ASSIGN
%token ASSIGNMENT_OPERATOR_MODULO_ASSIGN
%token ASSIGNMENT_OPERATOR_COLON_ASSIGN
%token ASSIGNMENT_OPERATOR_ARROW_ASSIGN



%token DELIMITER_SEMICOLON
%token DELIMITER_LEFT_PARENTHESIS
%token DELIMITER_RIGHT_PARENTHESIS
%token DELIMITER_COMMA
%token DELIMITER_LEFT_BLOCK
%token DELIMITER_RIGHT_BLOCK
%token DELIMITER_COLON
%token DELIMITER_DOT

%token TK_PLUS_SIGN
%token TK_MINUS_SIGN


%left ARITHMETIC_OPERATOR_PLUS
%left ARITHMETIC_OPERATOR_MINUS
%left ARITHMETIC_OPERATOR_MULT
%left ARITHMETIC_OPERATOR_DIVISION
%left ARITHMETIC_OPERATOR_MODULO 
%left RELATIONAL_OPERATOR_EQUALS
%left RELATIONAL_OPERATOR_NOTEQUALS
%left RELATIONAL_OPERATOR_LESS
%left RELATIONAL_OPERATOR_LESS_EQUALS
%left RELATIONAL_OPERATOR_MORE
%left RELATIONAL_OPERATOR_MORE_EQUALS
%left DELIMITER_LEFT_PARENTHESIS
%left DELIMITER_RIGHT_PARENTHESIS
%left DELIMITER_LEFT_BLOCK
%left DELIMITER_RIGHT_BLOCK
%left DELIMITER_DOT
%left KEYWORD_AND
%left KEYWORD_OR

%right TK_PLUS_SIGN
%right TK_MINUS_SIGN
%right ARITHMETIC_OPERATOR_EXP
%right ASSIGNMENT_OPERATOR_ASSIGN
%right ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN
%right ASSIGNMENT_OPERATOR_PLUS_ASSIGN
%right ASSIGNMENT_OPERATOR_MINUS_ASSIGN
%right ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN
%right ASSIGNMENT_OPERATOR_DIVISION_ASSIGN
%right ASSIGNMENT_OPERATOR_MODULO_ASSIGN
%right ASSIGNMENT_OPERATOR_COLON_ASSIGN
%right KEYWORD_NOT









%%
int main() {

  if ( yyparse() != 0 )
      printf("/* Rejected! */\n");
 else {
    printf("/* Accepted! */\n");
 } 

}