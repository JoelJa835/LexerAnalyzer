%{
  #include <stdio.h>
  #include <string.h>
  #include "cgen.h"
  #include "myanalyzer.tab.h"
 

  int line_num = 1;

   void showError();
%}



ID      [a-zA-Z][0-9a-zA-Z_]*
DIGIT   [0-9]
CONST_INT [0]|([1-9]{DIGIT}*)
DECIMAL ("."{CONST_INT})|({CONST_INT}("."{CONST_INT}?)?)
CONST_FLOAT {DECIMAL}([eE][+-]?{CONST_INT})?
CONST_STRING (\"(([^\"\\]|\\[ntr\\"'])*)\")


%x line_comment


%%

"integer"                   {printf("Token KW_INTEGER: \t%s\n", yytext);return KW_INTEGER;};
"scalar"                    {printf("Token KW_SCALAR: \t%s\n", yytext);return KW_SCALAR;};
"str"                       {printf("Token KW_STR: \t%s\n", yytext);return KW_STR;};
"boolean"                   {printf("Token KW_BOOLEAN: \t%s\n", yytext);return KW_BOOLEAN;};
"True"                      {printf("Token KW_TRUE: \t%s\n", yytext);return KW_TRUE;};
"False"                     {printf("Token KW_FALSE: \t%s\n", yytext); return KW_FALSE;};
"const"                     {printf("Token KW_CONST: \t%s\n", yytext); return KW_CONST;};
"if"                        {printf("Token KW_IF: \t%s\n", yytext); return KW_IF;};
"else"                      {printf("Token KW_ELSE: \t%s\n", yytext);return KW_ELSE;};
"endif"                     {printf("Token KW_ENDIF: \t%s\n", yytext);return KW_ENDIF;};
"for"                       {printf("Token KW_FOR: \t%s\n", yytext);return KW_FOR;};
"in"                        {printf("Token KW_IN: \t%s\n", yytext);return KW_IN;};
"endfor"                    {printf("Token KW_ENDFOR: \t%s\n", yytext);return KW_ENDFOR;};
"while"                     {printf("Token KW_WHILE: \t%s\n", yytext);return KW_WHILE;};
"endwhile"                  {printf("Token KW_ENDWHILE: \t%s\n", yytext);return KW_ENDWHILE;};
"break"                     {printf("Token KW_BREAK: \t%s\n", yytext);return KW_BREAK;};
"continue"                  {printf("Token KW_CONTINUE: \t%s\n", yytext);return KW_CONTINUE;};
"not"                       {printf("Token KW_NOT: \t%s\n", yytext);return KW_NOT;};
"and"                       {printf("Token KW_AND: \t%s\n", yytext);return KW_AND;};
"or"                        {printf("Token KW_OR: \t%s\n", yytext);return KW_OR;};
"def"                       {printf("Token KW_DEF: \t%s\n", yytext);return KW_DEF;};
"enddef"                    {printf("Token KW_ENDDEF: \t%s\n", yytext);return KW_ENDDEF;};
"main"                      {printf("Token KW_MAIN: \t%s\n", yytext);return KW_MAIN;};
"return"                    {printf("Token KW_RETURN: \t%s\n", yytext);return KW_RETURN;};
"comp"                      {printf("Token KW_COMP: \t%s\n", yytext);return KW_COMP;};
"endcomp"                   {printf("Token KW_ENDCOMP: \t%s\n", yytext);return KW_ENDCOMP;};
"of"                        {printf("Token KW_OF: \t%s\n", yytext); return KW_OF;};




{ID}               { yylval.str = strdup(yytext); printf("Token IDENTIFIER:\t%s\n", yytext);return TK_IDENTIFIER;}
{CONST_INT}         { yylval.str = strdup(yytext); printf("Token INTEGER CONSTANT: \t%s\n", yytext);return TK_CONST_INT;}
{CONST_FLOAT}  { yylval.str = strdup(yytext); printf("Token FLOATING POINT CONSTANT: \t%s\n", yytext);return TK_CONST_FLOAT;}
{CONST_STRING}          { yylval.str = strdup(yytext); printf("Token STRING CONSTANT: \t%s\n", yytext);return TK_CONST_STRING;}


"+"                         {printf("Token ARITHMETIC_OPERATOR_PLUS: \t%s\n", yytext);return ARITHMETIC_OPERATOR_PLUS;};
"-"                         {printf("Token ARITHMETIC_OPERATOR_MINUS: \t%s\n", yytext);return ARITHMETIC_OPERATOR_MINUS;};
"*"                         {printf("Token ARITHMETIC_OPERATOR_MULT: \t%s\n", yytext);return ARITHMETIC_OPERATOR_MULT;};
"/"                         {printf("Token ARITHMETIC_OPERATOR_DIVISION: \t%s\n", yytext);return ARITHMETIC_OPERATOR_DIVISION;};
"%"                         {printf("Token ARITHMETIC_OPERATOR_MODULO: \t%s\n", yytext);return ARITHMETIC_OPERATOR_MODULO;};
"**"                        {printf("Token ARITHMETIC_OPERATOR_EXP: \t%s\n", yytext);return ARITHMETIC_OPERATOR_EXP;};

"=="                        {printf("Token RELATIONAL_OPERATOR_EQUALS: \t%s\n", yytext);return RELATIONAL_OPERATOR_EQUALS;};
"!="                        {printf("Token RELATIONAL_OPERATOR_NOTEQUALS: \t%s\n", yytext);return RELATIONAL_OPERATOR_NOTEQUALS;};
"<"                         {printf("Token RELATIONAL_OPERATOR_LESS: \t%s\n", yytext);return RELATIONAL_OPERATOR_LESS;};
"<="                        {printf("Token RELATIONAL_OPERATOR_LESS_EQUALS: \t%s\n", yytext);return RELATIONAL_OPERATOR_LESS_EQUALS;};
">"                         {printf("Token RELATIONAL_OPERATOR_MORE: \t%s\n", yytext);return RELATIONAL_OPERATOR_MORE;};
">="                        {printf("Token RELATIONAL_OPERATOR_MORE_EQUALS: \t%s\n", yytext);return RELATIONAL_OPERATOR_MORE_EQUALS;};

"="                         {printf("Token ASSIGNMENT_OPERATOR_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_ASSIGN;};
"#"                         {printf("Token ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN;};
"+="                        {printf("Token ASSIGNMENT_OPERATOR_PLUS_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_PLUS_ASSIGN;};
"-="                        {printf("Token ASSIGNMENT_OPERATOR_MINUS_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_MINUS_ASSIGN;};
"*="                        {printf("Token ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN;};
"/="                        {printf("Token ASSIGNMENT_OPERATOR_DIVISION_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_DIVISION_ASSIGN;};
"%="                        {printf("Token ASSIGNMENT_OPERATOR_MODULO_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_MODULO_ASSIGN;};
":="                        {printf("Token ASSIGNMENT_OPERATOR_COLON_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_COLON_ASSIGN;};
"->"                        {printf("Token ASSIGNMENT_OPERATOR_ARROW_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_ARROW_ASSIGN;};




";"                         {printf("Token D_SEMICOLON: \t%s\n", yytext);return D_SEMICOLON;};
"("                         {printf("Token D_LEFT_PARENTHESIS: \t%s\n", yytext);return D_LEFT_PARENTHESIS;};
")"                         {printf("Token D_RIGHT_PARENTHESIS: \t%s\n", yytext);return D_RIGHT_PARENTHESIS;};
","                         {printf("Token D_COMMA: \t%s\n", yytext);return D_COMMA;};
"["                         {printf("Token D_LEFT_BLOCK: \t%s\n", yytext);return D_LEFT_BLOCK;};
"]"                         {printf("Token D_RIGHT_BLOCK: \t%s\n", yytext);return D_RIGHT_BLOCK;};
":"                         {printf("Token D_COLON: \t%s\n", yytext);return D_COLON;};
"."                         {printf("Token D_DOT: \t%s\n", yytext);return D_DOT;};



[ \r\t]+    /* skip whitespace and return on start */
\n           ++line_num;


"--"         {BEGIN(line_comment);}
<line_comment>[^\n]*    /*Eat all one line comments*/
<line_comment>\n {++line_num;BEGIN(INITIAL);}


<<EOF>>   return EOF; /*Marks End of file*/
.           {showError();}


%%


void showError(){
  printf("Unrecognized token %s in line %d\n", yytext, line_num);
  exit(-1);
}