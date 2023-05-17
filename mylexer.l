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

"integer"                   {printf("Token KEYWORD_INTEGER: \t%s\n", yytext);return KEYWORD_INTEGER;};
"scalar"                    {printf("Token KEYWORD_SCALAR: \t%s\n", yytext);return KEYWORD_SCALAR;};
"str"                       {printf("Token KEYWORD_STR: \t%s\n", yytext);return KEYWORD_STR;};
"boolean"                   {printf("Token KEYWORD_BOOLEAN: \t%s\n", yytext);return KEYWORD_BOOLEAN;};
"True"                      {printf("Token KEYWORD_TRUE: \t%s\n", yytext);return KEYWORD_TRUE;};
"False"                     {printf("Token KEYWORD_FALSE: \t%s\n", yytext); return KEYWORD_FALSE;};
"const"                     {printf("Token KEYWORD_CONST: \t%s\n", yytext); return KEYWORD_CONST;};
"if"                        {printf("Token KEYWORD_IF: \t%s\n", yytext); return KEYWORD_IF;};
"else"                      {printf("Token KEYWORD_ELSE: \t%s\n", yytext);return KEYWORD_ELSE;};
"endif"                     {printf("Token KEYWORD_ENDIF: \t%s\n", yytext);return KEYWORD_ENDIF;};
"for"                       {printf("Token KEYWORD_FOR: \t%s\n", yytext);return KEYWORD_FOR;};
"in"                        {printf("Token KEYWORD_IN: \t%s\n", yytext);return KEYWORD_IN;};
"endfor"                    {printf("Token KEYWORD_ENDFOR: \t%s\n", yytext);return KEYWORD_ENDFOR;};
"while"                     {printf("Token KEYWORD_WHILE: \t%s\n", yytext);return KEYWORD_WHILE;};
"endwhile"                  {printf("Token KEYWORD_ENDWHILE: \t%s\n", yytext);return KEYWORD_ENDWHILE;};
"break"                     {printf("Token KEYWORD_BREAK: \t%s\n", yytext);return KEYWORD_BREAK;};
"continue"                  {printf("Token KEYWORD_CONTINUE: \t%s\n", yytext);return KEYWORD_CONTINUE;};
"not"                       {printf("Token KEYWORD_NOT: \t%s\n", yytext);return KEYWORD_NOT;};
"and"                       {printf("Token KEYWORD_AND: \t%s\n", yytext);return KEYWORD_AND;};
"or"                        {printf("Token KEYWORD_OR: \t%s\n", yytext);return KEYWORD_OR;};
"def"                       {printf("Token KEYWORD_DEF: \t%s\n", yytext);return KEYWORD_DEF;};
"enddef"                    {printf("Token KEYWORD_ENDDEF: \t%s\n", yytext);return KEYWORD_ENDDEF;};
"main"                      {printf("Token KEYWORD_MAIN: \t%s\n", yytext);return KEYWORD_MAIN;};
"return"                    {printf("Token KEYWORD_RETURN: \t%s\n", yytext);return KEYWORD_RETURN;};
"comp"                      {printf("Token KEYWORD_COMP: \t%s\n", yytext);return KEYWORD_COMP;};
"endcomp"                   {printf("Token KEYWORD_ENDCOMP: \t%s\n", yytext);return KEYWORD_ENDCOMP;};
"of"                        {printf("Token KEYWORD_OF: \t%s\n", yytext); return KEYWORD_OF;};




{ID}               { yylval.crepr = strdup(yytext); printf("Token IDENTIFIER:\t%s\n", yytext);return TK_IDENTIFIER;}
{CONST_INT}         { yylval.crepr = strdup(yytext); printf("Token INTEGER CONSTANT: \t%s\n", yytext);return TK_CONST_INT;}
{CONST_FLOAT}  { yylval.crepr = strdup(yytext); printf("Token FLOATING POINT CONSTANT: \t%s\n", yytext);return TK_CONST_FLOAT;}
{CONST_STRING}          { yylval.crepr = strdup(yytext); printf("Token STRING CONSTANT: \t%s\n", yytext);return TK_CONST_STRING;}


"+"                         {printf("Token ARITHMETIC_OPERATOR_PLUS: \t%s\n", yytext);return ARITHMETIC_OPERATOR_PLUS;};
"-"                         {printf("Token ARITHMETIC_OPERATOR_MINUS: \t%s\n", yytext);return ARITHMETIC_OPERATOR_MINUS;};
"*"                         {printf("Token ARITHMETIC_OPERATOR_MULT: \t%s\n", yytext);return};
"/"                         {printf("Token ARITHMETIC_OPERATOR_DIVISION: \t%s\n", yytext);return};
"%"                         {printf("Token ARITHMETIC_OPERATOR_MODULO: \t%s\n", yytext);return};
"**"                        {printf("Token ARITHMETIC_OPERATOR_EXP: \t%s\n", yytext);return};

"=="                        {printf("Token RELATIONAL_OPERATOR_EQUALS: \t%s\n", yytext);return};
"!="                        {printf("Token RELATIONAL_OPERATOR_NOTEQUALS: \t%s\n", yytext);return};
"<"                         {printf("Token RELATIONAL_OPERATOR_LESS: \t%s\n", yytext);return};
"<="                        {printf("Token RELATIONAL_OPERATOR_LESS_EQUALS: \t%s\n", yytext);return};
">"                         {printf("Token RELATIONAL_OPERATOR_MORE: \t%s\n", yytext);return};
">="                        {printf("Token RELATIONAL_OPERATOR_MORE_EQUALS: \t%s\n", yytext);return};

"="                         {printf("Token ASSIGNMENT_OPERATOR_ASSIGN: \t%s\n", yytext);return};
"#"                         {printf("Token ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN: \t%s\n", yytext);return ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN;};
"+="                        {printf("Token ASSIGNMENT_OPERATOR_PLUS_ASSIGN: \t%s\n", yytext);return};
"-="                        {printf("Token ASSIGNMENT_OPERATOR_MINUS_ASSIGN: \t%s\n", yytext);return};
"*="                        {printf("Token ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN: \t%s\n", yytext);return};
"/="                        {printf("Token ASSIGNMENT_OPERATOR_DIVISION_ASSIGN: \t%s\n", yytext);return};
"%="                        {printf("Token ASSIGNMENT_OPERATOR_MODULO_ASSIGN: \t%s\n", yytext);return};
":="                        {printf("Token ASSIGNMENT_OPERATOR_COLON_ASSIGN: \t%s\n", yytext);return};
"->"                        {printf("Token ASSIGNMENT_OPERATOR_ARROW_ASSIGN: \t%s\n", yytext);return};

[-+]                        { return *yytext == '-' ? TK_MINUS_SIGN : TK_PLUS_SIGN; }



";"                         {printf("Token DELIMITER_SEMICOLON: \t%s\n", yytext);return};
"("                         {printf("Token DELIMITER_LEFT_PARENTHESIS: \t%s\n", yytext);return};
")"                         {printf("Token DELIMITER_RIGHT_PARENTHESIS: \t%s\n", yytext);return};
","                         {printf("Token DELIMITER_COMMA: \t%s\n", yytext);return};
"["                         {printf("Token DELIMITER_LEFT_BLOCK: \t%s\n", yytext);return};
"]"                         {printf("Token DELIMITER_RIGHT_BLOCK: \t%s\n", yytext);return};
":"                         {printf("Token DELIMITER_COLON: \t%s\n", yytext);return};
"."                         {printf("Token DELIMITER_DOT: \t%s\n", yytext);return};



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