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
%token ARITHMETIC_OPERATOR_EXP


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



%type <str> Bdatatype
%type <str> variable_declaration
%type <str> constant_declaration
%type <str> variable_list
%type <str> constant_value
%type <str> functions
%type <str> input_declaration
%type <str> comp_type_declaration
%type <str> comp_body
%type <str> arithmetic_expression
%type <str> relational_expression
%type <str> assignment_expression
%type <str> expressions



%%

// =====================================================Programs====================================================================
//not done yet



// =====================================================Data Types and Identifiers===================================================
//not done yet

Bdatatype: KEYWORD_INTEGER { $$ = template("%s", "int"); }
        | KEYWORD_SCALAR { $$ = template("%s", "double"); }
        | KEYWORD_STR { $$ = template("%s", "char*"); }
        | KEYWORD_BOOLEAN { $$ = template("%s", "int"); }
        ;




// =====================================================Variables====================================================================
//not done yet
variable_declaration: variable_list DELIMITER_COLON Bdatatype DELIMITER_SEMICOLON
      { $$ = template("%s %s;", $3, $1); }
                     ;
                     

variable_list: TK_IDENTIFIER {$$ = $1;}
             | variable_list DELIMITER_COMMA TK_IDENTIFIER {$$ = template("%s, %s", $1,$3);}
             ;



// =====================================================Constants====================================================================
//not done yet
constant_declaration: KEYWORD_CONST variable_list ASSIGNMENT_OPERATOR_ASSIGN constant_value DELIMITER_COLON Bdatatype
        { $$ = template("const %s %s = %s;", $5, $2, $4); }
                     ;

constant_value: TK_CONST_INT
              | TK_CONST_FLOAT
              | TK_CONST_STRING
              | TK_IDENTIFIER
              ;




// =====================================================Functions====================================================================
//not done yet
functions:  KEYWORD_DEF TK_IDENTIFIER  DELIMITER_LEFT_PARENTHESIS input_declaration DELIMITER_RIGHT_PARENTHESIS DELIMITER_COLON KEYWORD_ENDDEF DELIMITER_SEMICOLON
          |KEYWORD_DEF TK_IDENTIFIER  DELIMITER_LEFT_PARENTHESIS input_declaration DELIMITER_RIGHT_PARENTHESIS ASSIGNMENT_OPERATOR_ARROW_ASSIGN Bdatatype DELIMITER_COLON KEYWORD_ENDDEF DELIMITER_SEMICOLON


//input_declaration:





// =====================================================Complex types================================================================
//not done yet
comp_type_declaration:  KEYWORD_COMP TK_IDENTIFIER DELIMITER_COLON comp_body KEYWORD_ENDCOMP DELIMITER_SEMICOLON



//comp_body:

// =====================================================Expressions==================================================================
//Propably more will be added here
arithmetic_expression: 
                      TK_CONST_INT { $$ =  $1;  }
                     | TK_CONST_FLOAT { $$ =  $1; }
                     | arithmetic_expression ARITHMETIC_OPERATOR_PLUS arithmetic_expression { $$ = template("%s + %s", $1, $3); }
                     | arithmetic_expression ARITHMETIC_OPERATOR_MINUS arithmetic_expression{ $$ = template("%s - %s", $1, $3); }
                     | arithmetic_expression ARITHMETIC_OPERATOR_MULT arithmetic_expression { $$ = template("%s * %s", $1, $3); }
                     | arithmetic_expression ARITHMETIC_OPERATOR_DIVISION arithmetic_expression { $$ = template("%s / %s", $1, $3); }
                     | arithmetic_expression ARITHMETIC_OPERATOR_MODULO arithmetic_expression { $$ = template("%s %% %s", $1, $3); }
                     | arithmetic_expression ARITHMETIC_OPERATOR_EXP arithmetic_expression { $$ = template("pow(%s, %s)", $1, $3); }
                     ;

relational_expression: 
                      relational_expression RELATIONAL_OPERATOR_LESS relational_expression { $$ = template("%s < %s", $1, $3); }
                     | relational_expression RELATIONAL_OPERATOR_MORE relational_expression { $$ = template("%s > %s", $1, $3); }
                     | relational_expression RELATIONAL_OPERATOR_LESS_EQUALS  relational_expression { $$ = template("%s <= %s", $1, $3); }
                     | relational_expression RELATIONAL_OPERATOR_MORE_EQUALS relational_expression { $$ = template("%s >= %s", $1, $3); }
                     | relational_expression RELATIONAL_OPERATOR_EQUALS  relational_expression { $$ = template("%s == %s", $1, $3); }
                     | relational_expression RELATIONAL_OPERATOR_NOTEQUALS relational_expression { $$ = template("%s != %s", $1, $3); }
                     | KEYWORD_NOT relational_expression { $$ = template("not %s", $2); }
                     | relational_expression KEYWORD_AND relational_expression { $$ = template("%s and %s", $1, $3); }
                     | relational_expression KEYWORD_OR relational_expression { $$ = template("%s or %s", $1, $3); }
                     ;

assignment_expression: TK_IDENTIFIER ASSIGNMENT_OPERATOR_ASSIGN assignment_expression { $$ = template("%s = %s", $1, $3); }
                     | TK_IDENTIFIER ASSIGNMENT_OPERATOR_PLUS_ASSIGN assignment_expression { $$ = template("%s += %s", $1, $3); }
                     | TK_IDENTIFIER ASSIGNMENT_OPERATOR_MINUS_ASSIGN assignment_expression { $$ = template("%s -= %s", $1, $3); }
                     | TK_IDENTIFIER ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN assignment_expression { $$ = template("%s *= %s", $1, $3); }
                     | TK_IDENTIFIER ASSIGNMENT_OPERATOR_DIVISION_ASSIGN assignment_expression { $$ = template("%s /= %s", $1, $3); }
                     | TK_IDENTIFIER ASSIGNMENT_OPERATOR_MODULO_ASSIGN assignment_expression { $$ = template("%s %%= %s", $1, $3); }
                     | TK_IDENTIFIER ASSIGNMENT_OPERATOR_COLON_ASSIGN assignment_expression { $$ = template("%s := %s", $1, $3); }
                     ;

expressions: arithmetic_expression { $$ = $1; }
          | relational_expression { $$ = $1; }
          | assignment_expression { $$ = $1; }
          ;


// =====================================================Statements===================================================================
statement: assignment_statement
         | if_statement
         | for_statement
         | array_comprehension_statement
         | array_comprehension_with_array_statement
         | while_statement
         | break_statement
         | continue_statement
         | return_statement
         | function_call_statement
         | empty_statement
         ;

assignment_statement: TK_IDENTIFIER ASSIGNMENT_OPERATOR_ASSIGN expression DELIMITER_SEMICOLON
                     { printf("Assignment: %s = %s;\n", $1, $3); }
                     ;

if_statement: KEYWORD_IF DELIMITER_LEFT_PARENTHESIS expressions DELIMITER_RIGHT_PARENTHESIS DELIMITER_COLON statements  KEYWORD_ENDIF {$$ = template("if (%s) {\n%s\n}", $3, $6);}
            | KEYWORD_IF DELIMITER_LEFT_PARENTHESIS expressions DELIMITER_RIGHT_PARENTHESIS DELIMITER_COLON statements KEYWORD_ELSE DELIMITER_COLON statements KEYWORD_ENDIF{$$ = template("if (%s) {\n%s\n} else {\n%s\n}", $3, $6, $9);}
            ;

for_statement: KEYWORD_FOR TK_IDENTIFIER KEYWORD_IN DELIMITER_LEFT_BLOCK start_expression DELIMITER_COLON stop_expression DELIMITER_COLON optional_step_expression DELIMITER_RIGHT_BLOCK DELIMITER_COLON statements KEYWORD_ENDFOR {$$ = template("for (int %s = %s; %s < %s; %s++) {\n%s\n}", $2, $5, $2, $7, $2, $12);}
              ;

//array_comprehension_statement: TK_IDENTIFIER ASSIGNMENT_OPERATOR_ASSIGN DELIMITER_LEFT_BLOCK  expression 'for' TK_IDENTIFIER DELIMITER_COLON size_expression ']' DELIMITER_COLON new_type_statement DELIMITER_SEMICOLON
                             // { printf("Array Comprehension: %s = [%s for %s in %s];\n", $1, $4, $6, $8); }
                              //;

//array_comprehension_with_array_statement: TK_IDENTIFIER ASSIGNMENT_OPERATOR_ASSIGN '[' expression 'for' TK_IDENTIFIER DELIMITER_COLON TYPE_IDENTIFIER 'in' TK_IDENTIFIER 'of' size_expression ']' DELIMITER_COLON new_type_statement DELIMITER_SEMICOLON
                                         //{ printf("Array Comprehension with Array: %s = [%s for %s in %s of %s];\n", $1, $4, $6, $8, $12); }
                                         //;

while_statement: KEYWORD_WHILE DELIMITER_LEFT_PARENTHESIS expression DELIMITER_RIGHT_PARENTHESIS DELIMITER_COLON statements KEYWORD_ENDWHILE {$$ = template("while (%s) {\n%s\n}", $3, $6);}
                ;

break_statement: KEYWORD_BREAK {$$ = template("break");}
                ;

continue_statement: KEYWORD_CONTINUE {$$ = template("continue");}
                   ;

return_statement: KEYWORD_RETURN optional_expression DELIMITER_SEMICOLON {$$ = template("return");}
                 ;

//function_call_statement: TK_IDENTIFIER '(' expression_list ')' DELIMITER_SEMICOLON
                        //{ printf("Function Call: %s(%s);\n", $1, $3); }
                        //;

//empty_statement: DELIMITER_SEMICOLON
                //{ printf("Empty Statement: ;\n"); }
                //;




%%
int main(void) {

  if ( yyparse() != 0 )
      printf("/* Rejected! */\n");
  else {
    printf("/* Accepted! */\n");
 } 

}