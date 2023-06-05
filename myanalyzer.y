%{
    #include <stdlib.h>
    #include <stdio.h>	
    #include "cgen.h"

	extern int yylex(void);
%}


%union {
	char* str;
}

%nonassoc ident

%token <str> TK_IDENTIFIER
%token <str> TK_CONST_INT
%token <str> TK_CONST_FLOAT
%token <str> TK_CONST_STRING

%token ASSIGNMENT_OPERATOR_ARROW_ASSIGN
%token KW_INTEGER
%token KW_SCALAR
%token KW_STR
%token KW_BOOLEAN
%token KW_TRUE
%token KW_FALSE
%token KW_CONST
%token KW_IF
%token KW_ELSE
%token KW_ENDIF
%token KW_FOR
%token KW_IN
%token KW_ENDFOR
%token KW_WHILE
%token KW_ENDWHILE
%token KW_BREAK
%token KW_CONTINUE
%token KW_NOT
%token KW_DEF
%token KW_ENDDEF
%token KW_MAIN
%token KW_RETURN
%token KW_COMP
%token KW_ENDCOMP
%token KW_OF

%token D_SEMICOLON
%token D_COMMA
%token D_COLON

%token RELATIONAL_OPERATOR_MORE_EQUALS 
%token RELATIONAL_OPERATOR_LESS_EQUALS 
%token RELATIONAL_OPERATOR_EQUALS 
%token RELATIONAL_OPERATOR_NOTEQUALS 
%token ASSIGNMENT_OPERATOR_PLUS_ASSIGN 
%token ASSIGNMENT_OPERATOR_MINUS_ASSIGN 
%token ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN 
%token ASSIGNMENT_OPERATOR_DIVISION_ASSIGN 
%token ASSIGNMENT_OPERATOR_MODULO_ASSIGN 
%token ASSIGNMENT_OPERATOR_COLON_ASSIGN 
%token ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN
%token ASSIGNMENT_OPERATOR_ASSIGN

%token ARITHMETIC_OPERATOR_EXP
%nonassoc not_sure

%right ARITHMETIC_OPERATOR_EXP ASSIGNMENT_OPERATOR_ARROW_ASSIGN ASSIGNMENT_OPERATOR_PLUS_ASSIGN ASSIGNMENT_OPERATOR_MINUS_ASSIGN ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN ASSIGNMENT_OPERATOR_DIVISION_ASSIGN ASSIGNMENT_OPERATOR_MODULO_ASSIGN ASSIGNMENT_OPERATOR_COLON_ASSIGN
%right KW_NOT

%left ARITHMETIC_OPERATOR_PLUS ARITHMETIC_OPERATOR_MINUS
%left ARITHMETIC_OPERATOR_MULT
%left ARITHMETIC_OPERATOR_DIVISION
%left ARITHMETIC_OPERATOR_MODULO 
%left RELATIONAL_OPERATOR_EQUALS
%left RELATIONAL_OPERATOR_NOTEQUALS
%left RELATIONAL_OPERATOR_LESS
%left RELATIONAL_OPERATOR_LESS_EQUALS
%left RELATIONAL_OPERATOR_MORE
%left RELATIONAL_OPERATOR_MORE_EQUALS
%left D_LEFT_PARENTHESIS
%left D_RIGHT_PARENTHESIS
%left D_LEFT_BLOCK
%left D_RIGHT_BLOCK
%left D_DOT
%left KW_AND
%left KW_OR

%start input

%type <str> input
%type <str> main_func
%type <str> program_template
%type <str> comp_decl
%type <str> const_decl
%type <str> var_decl
%type <str> func_decl
%type <str> single_comp
%type <str> single_const
%type <str> single_var
%type <str> comp_var_decl
%type <str> single_function
%type <str> single_argument
%type <str> declarations
%type <str> assign_vars
%type <str> expression
%type <str> logic_expression 
%type <str> arithmetic_expression
%type <str> complex_expression 
%type <str> statement
%type <str> assignment_statement
%type <str> if_statement
%type <str> for_statement
%type <str> while_statement
%type <str> else_clause
%type <str> code
%type <str> func_call
%type <str> function_input
%type <str> func_arguments
%type <str> return
%type <str> func_code
%type <str> statements


%nonassoc Else
%nonassoc KW_ELSE

%%

// =====================================================Top level====================================================================
input: program_template
    {
    FILE* outputFile = fopen("correct2.c", "w");
        if (yyerror_count == 0) {
            // Print the contents of c_prologue to the file
            fputs(c_prologue, outputFile);

            // Print the value of $1 to the file
            fprintf(outputFile, "%s", $1);
        } else {
            // Print the error message and yyerror_count to the file
            fprintf(outputFile, "Error num: %d", yyerror_count);
        }

        // Close the output file
        fclose(outputFile);
    }
;

program_template:
    main_func     {$$=template("%s\n",$1);}
|   comp_decl main_func    {$$=template("%s\n%s\n",$1,$2);}   
|   const_decl main_func   {$$=template("%s\n%s\n",$1,$2);}
|   var_decl main_func     {$$=template("%s\n%s\n",$1,$2);}
|   func_decl main_func    {$$=template("%s\n%s\n",$1,$2);}
|   comp_decl const_decl var_decl func_decl main_func   {$$=template("%s\n%s\n%s\n%s\n%s\n",$1,$2,$3,$4,$5);}
|   comp_decl const_decl var_decl main_func    {$$=template("%s\n%s\n%s\n%s\n",$1,$2,$3,$4);}
|   comp_decl const_decl func_decl main_func   {$$=template("%s\n%s\n%s\n%s\n",$1,$2,$3,$4);}
|   comp_decl var_decl func_decl main_func     {$$=template("%s\n%s\n%s\n%s\n",$1,$2,$3,$4);}
|   const_decl var_decl func_decl main_func    {$$=template("%s\n%s\n%s\n%s\n",$1,$2,$3,$4);}
|   comp_decl const_decl main_func  {$$=template("%s\n%s\n%s\n",$1,$2,$3);}
|   comp_decl var_decl main_func    {$$=template("%s\n%s\n%s\n",$1,$2,$3);}
|   comp_decl func_decl main_func   {$$=template("%s\n%s\n%s\n",$1,$2,$3);}
|   const_decl var_decl main_func   {$$=template("%s\n%s\n%s\n",$1,$2,$3);}
|   const_decl func_decl main_func  {$$=template("%s\n%s\n%s\n",$1,$2,$3);}
|   var_decl func_decl main_func    {$$=template("%s\n%s\n%s\n",$1,$2,$3);}
;


main_func:
    KW_DEF KW_MAIN D_LEFT_PARENTHESIS D_RIGHT_PARENTHESIS D_COLON code KW_ENDDEF D_SEMICOLON {$$=template("void main(){\n%s}",$6);}
;

comp_decl:
    single_comp {$$=template("%s", $1);}
|   comp_decl single_comp {$$=template("%s\n%s", $1,$2);}
;

single_comp:
    KW_COMP TK_IDENTIFIER D_COLON comp_var_decl KW_ENDCOMP D_SEMICOLON  {$$=template("typedef struct %s{\n%s \n} %s ;\n",$2,$4,$2);}
|   KW_COMP TK_IDENTIFIER D_COLON func_decl KW_ENDCOMP D_SEMICOLON  {$$=template("typedef struct %s{\n%s \n} %s ;\n",$2,$4,$2);}
|   KW_COMP TK_IDENTIFIER D_COLON comp_var_decl func_decl KW_ENDCOMP D_SEMICOLON   {$$=template("typedef struct %s{\n%s \n%s \n} %s ;\n",$2,$4,$5,$2);}
;

comp_var_decl:
    single_var  {$$=template("%s", $1);}
|   comp_var_decl single_var  {$$=template("%s\n%s", $1,$2);}
;

var_decl:
    single_var   {$$=template("%s", $1);}
|   var_decl single_var    {$$=template("%s \n%s", $1,$2);}
;

single_var:
    declarations D_COLON KW_INTEGER D_SEMICOLON   {$$=template("int %s;", $1);}
|   declarations D_COLON KW_SCALAR D_SEMICOLON    {$$=template("double %s;", $1);}  
|   declarations D_COLON KW_STR D_SEMICOLON       {$$=template("char* %s;", $1);}  
|   declarations D_COLON KW_BOOLEAN D_SEMICOLON   {$$=template("int %s;", $1);}
|   declarations D_COLON TK_IDENTIFIER D_SEMICOLON   {$$=template("struct %s %s;",$3,$1);}
|   declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_INTEGER D_SEMICOLON {$$=template("int %s[%s];",$1,$3);}
|   declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_SCALAR D_SEMICOLON {$$=template("double %s[%s];",$1,$3);}
|   declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_STR D_SEMICOLON {$$=template("char* %s[%s];",$1,$3);}
|   declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_BOOLEAN D_SEMICOLON {$$=template("int %s[%s];",$1,$3);}
|   declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON TK_IDENTIFIER D_SEMICOLON {$$=template("struct[%s] %s;",$3,$1);}
;


const_decl:
    single_const {$$=template("%s",$1);}
|   const_decl single_const {$$=template("%s\n%s",$1,$2);}
;

single_const:
    KW_CONST declarations D_COLON KW_INTEGER D_SEMICOLON {$$=template("const int %s;",$2);}
|   KW_CONST declarations D_COLON KW_SCALAR D_SEMICOLON {$$=template("const double %s;",$2);}
|   KW_CONST declarations D_COLON KW_STR D_SEMICOLON {$$=template("const char* %s;",$2);}
|   KW_CONST declarations D_COLON KW_BOOLEAN D_SEMICOLON {$$=template("const int %s;",$2);}
|   KW_CONST declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_INTEGER D_SEMICOLON {$$=template("const int %s[%s];",$2,$4);}    
|   KW_CONST declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_SCALAR D_SEMICOLON {$$=template("const double %s[%s];",$2,$4);}    
|   KW_CONST declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_STR D_SEMICOLON {$$=template("const char* %s[%s];",$2,$4);}    
|   KW_CONST declarations D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_BOOLEAN D_SEMICOLON {$$=template("const int %s[%s];",$2,$4);} 

declarations:
    assign_vars                                      {$$=template("%s", $1);}
|   ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN assign_vars                                  {$$=template("%s", $2);}
|   assign_vars D_COMMA declarations       {$$=template("%s,%s",$1,$3);}
|   ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN assign_vars D_COMMA declarations   {$$=template("%s,%s",$2,$4);}

assign_vars:
    TK_IDENTIFIER                        {$$=template("%s",$1);}    %prec not_sure
|   TK_IDENTIFIER D_LEFT_BLOCK expression D_RIGHT_BLOCK     {$$=template("%s[(int)(%s)]",$1,$3); } 
|   TK_IDENTIFIER ASSIGNMENT_OPERATOR_ASSIGN expression    {$$=template("%s = %s",$1,$3);}
;

expression:
    logic_expression  {$$=template("%s",$1);}
;

logic_expression:
    arithmetic_expression   {$$=template("%s",$1);}
|   logic_expression RELATIONAL_OPERATOR_EQUALS arithmetic_expression  {$$=template("%s == %s",$1,$3);}
|   logic_expression RELATIONAL_OPERATOR_NOTEQUALS arithmetic_expression   {$$=template("%s != %s",$1,$3);}
|   logic_expression RELATIONAL_OPERATOR_MORE arithmetic_expression      {$$=template("%s > %s",$1,$3);}
|   logic_expression RELATIONAL_OPERATOR_LESS arithmetic_expression  {$$=template("%s < %s",$1,$3);}
|   logic_expression RELATIONAL_OPERATOR_MORE_EQUALS arithmetic_expression     {$$=template("%s >= %s",$1,$3);}
|   logic_expression RELATIONAL_OPERATOR_LESS_EQUALS arithmetic_expression    {$$=template("%s <= %s",$1,$3);}
|   logic_expression KW_AND arithmetic_expression              {$$=template("%s && %s",$1,$3);}
|   logic_expression KW_OR arithmetic_expression               {$$=template("%s || %s",$1,$3);}
|   KW_NOT arithmetic_expression                        {$$=template("!%s",$2);}
;

arithmetic_expression:
    complex_expression                      {$$=template("%s",$1);}
|   arithmetic_expression ARITHMETIC_OPERATOR_PLUS complex_expression   {$$ = template("%s + %s", $1, $3); } 
|   arithmetic_expression ARITHMETIC_OPERATOR_MINUS complex_expression        {$$ = template("%s - %s", $1, $3); }
|   arithmetic_expression ARITHMETIC_OPERATOR_MULT complex_expression        {$$ = template("%s * %s", $1, $3); }
|   arithmetic_expression ARITHMETIC_OPERATOR_DIVISION complex_expression        {$$ = template("%s / %s", $1, $3); }
|   arithmetic_expression ARITHMETIC_OPERATOR_MODULO complex_expression        {$$ = template("fmod(%s,%s)", $1, $3); }
|   arithmetic_expression ARITHMETIC_OPERATOR_EXP complex_expression   {$$ = template("pow((double)%s,(double)%s)", $1, $3); }
;

complex_expression :
    TK_IDENTIFIER    {$$=template("%s",$1);}    %prec ident
|   TK_CONST_INT      {$$=template("%s",$1);}     
|   TK_CONST_FLOAT     {$$=template("%s",$1);} 
|   TK_CONST_STRING   {$$=template("%s",$1);}
|   KW_TRUE     {$$=template("1");}
|   KW_FALSE    {$$=template("0");}
|   D_LEFT_PARENTHESIS expression D_RIGHT_PARENTHESIS     {$$=template("(%s)",$2);}
|   ARITHMETIC_OPERATOR_MINUS arithmetic_expression      {$$=template("-%s",$2);} 
|   ARITHMETIC_OPERATOR_PLUS arithmetic_expression      {$$=template("+%s",$2);} 
|   TK_IDENTIFIER D_LEFT_BLOCK expression D_RIGHT_BLOCK    {$$  = template("%s[(int)(%s)]",$1,$3); }
|   TK_IDENTIFIER D_LEFT_PARENTHESIS function_input D_RIGHT_PARENTHESIS  {$$=template("%s(%s)",$1,$3);}


statement:
    assignment_statement                       {$$=template("%s",$1);}
|   if_statement                    {$$=template("%s",$1);}
|   while_statement                 {$$=template("%s",$1);}
|   for_statement                   {$$=template("%s",$1);}
|   func_call                 {$$=template("%s",$1);}
|   KW_BREAK D_SEMICOLON                {$$=template("break;");}
|   KW_CONTINUE D_SEMICOLON              {$$=template("continue;");}
|   KW_RETURN D_SEMICOLON              {$$=template("return;");}
|   KW_RETURN expression D_SEMICOLON    {$$=template("return %s;",$2);}
;

assignment_statement:
    TK_IDENTIFIER ASSIGNMENT_OPERATOR_ASSIGN expression D_SEMICOLON {$$=template("%s=%s;",$1,$3);}
|   TK_IDENTIFIER D_LEFT_BLOCK expression D_RIGHT_BLOCK ASSIGNMENT_OPERATOR_ASSIGN expression D_SEMICOLON    {$$=template("%s[(int)(%s)]=%s;",$1,$3,$6);}
;

if_statement:
    KW_IF D_LEFT_PARENTHESIS expression D_RIGHT_PARENTHESIS D_COLON code KW_ENDIF D_SEMICOLON             {$$ = template("if(%s){\n\t%s\n\t}",$3,$6); }  %prec Else 
|   KW_IF D_LEFT_PARENTHESIS expression D_RIGHT_PARENTHESIS D_COLON code else_clause KW_ENDIF D_SEMICOLON  {$$ = template("if(%s){\n\t%s\t}%s",$3,$6,$7); }
;

for_statement:
    KW_FOR TK_IDENTIFIER KW_IN D_LEFT_BLOCK arithmetic_expression D_COLON arithmetic_expression D_RIGHT_BLOCK D_COLON code KW_ENDFOR D_SEMICOLON                         {$$=template("for(int %s=%s;%s<=%s && %s>=-%s;%s+=1){\n%s\n}",$2,$5,$2,$7,$2,$7,$2,$10); }
|   KW_FOR TK_IDENTIFIER KW_IN D_LEFT_BLOCK arithmetic_expression D_COLON arithmetic_expression D_COLON arithmetic_expression D_RIGHT_BLOCK D_COLON code KW_ENDFOR D_SEMICOLON           {$$=template("for(int %s=%s;%s<=%s && %s>=-%s;%s+=%s){\n%s\n}",$2,$5,$2,$7,$2,$7,$2,$9,$12); }    
;

while_statement:
   KW_WHILE D_LEFT_PARENTHESIS expression D_RIGHT_PARENTHESIS D_COLON code KW_ENDWHILE D_SEMICOLON   {$$ = template("while(%s){\n\t%s\t}",$3,$6);}
;

else_clause:
    KW_ELSE D_COLON code   {$$ = template("else{\n\t%s\n}",$3); } 
;

code:
    statement code   {$$ = template("\t%s\n%s",$1,$2);}
|   single_var code      {$$ = template("\t%s\n%s",$1,$2);}
|   single_const code     {$$ = template("\t%s\n%s",$1,$2);}
|   %empty                      {$$ = template("");}
;


func_call:
    TK_IDENTIFIER D_LEFT_PARENTHESIS function_input D_RIGHT_PARENTHESIS D_SEMICOLON   {$$=template("%s(%s);",$1,$3);}
;

function_input:
    %empty                              {$$=template("");}
|   function_input D_COMMA expression       {$$ = template("%s , %s", $1,$3);}
|   expression                          {$$ = template("%s", $1);}
;

func_decl:
    single_function                        {$$=template("%s",$1);}
|   func_decl single_function      {$$=template("%s\n%s",$1,$2);}
;

single_function:
    KW_DEF TK_IDENTIFIER D_LEFT_PARENTHESIS func_arguments D_RIGHT_PARENTHESIS return D_COLON func_code  KW_ENDDEF D_SEMICOLON    {$$=template("%s %s(%s){\n%s\n}",$6,$2,$4,$8);} 
;

func_arguments:
    single_argument                        {$$=template("%s",$1);}
|   single_argument D_COMMA func_arguments     {$$=template("%s,%s",$1,$3);}
;

single_argument:
    %empty                              {$$=template("");}
|   TK_IDENTIFIER D_COLON KW_INTEGER             {$$=template("int %s",$1);}
|   TK_IDENTIFIER D_COLON KW_SCALAR             {$$=template("double %s",$1);}
|   TK_IDENTIFIER D_COLON KW_STR               {$$=template("char* %s",$1);}
|   TK_IDENTIFIER D_COLON KW_BOOLEAN             {$$=template("int %s",$1);}
|   TK_IDENTIFIER D_LEFT_BLOCK D_RIGHT_BLOCK D_COLON KW_INTEGER      {$$=template("int %s[]",$1);}
|   TK_IDENTIFIER D_LEFT_BLOCK D_RIGHT_BLOCK D_COLON KW_SCALAR      {$$=template("double %s[]",$1);}
|   TK_IDENTIFIER D_LEFT_BLOCK D_RIGHT_BLOCK D_COLON KW_STR         {$$=template("char* %s[]",$1);}
|   TK_IDENTIFIER D_LEFT_BLOCK D_RIGHT_BLOCK D_COLON KW_BOOLEAN     {$$=template("int %s[]",$1);}
|   TK_IDENTIFIER D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_INTEGER {$$=template("int %s[%s]",$1,$3);}
|   TK_IDENTIFIER D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_SCALAR  {$$=template("double %s[%s]",$1,$3);}
|   TK_IDENTIFIER D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_STR     {$$=template("char* %s[%s]",$1,$3);}
|   TK_IDENTIFIER D_LEFT_BLOCK TK_CONST_INT D_RIGHT_BLOCK D_COLON KW_BOOLEAN {$$=template("int %s[%s]",$1,$3);}
;

return:    
    %empty                      {$$=template("void");}
|   ASSIGNMENT_OPERATOR_ARROW_ASSIGN KW_INTEGER           {$$=template("int");}
|   ASSIGNMENT_OPERATOR_ARROW_ASSIGN KW_STR               {$$=template("char*");}
|   ASSIGNMENT_OPERATOR_ARROW_ASSIGN KW_SCALAR            {$$=template("double");}
|   ASSIGNMENT_OPERATOR_ARROW_ASSIGN KW_BOOLEAN           {$$=template("int");}
;

func_code:
    var_decl const_decl statements    {$$=template("\t%s\n\t%s\n\t%s",$1,$2,$3);}
|   var_decl statements                       {$$=template("\t%s\n\t%s",$1,$2);}
|   const_decl statements                     {$$=template("\t%s\n%\ts",$1,$2);}
|   statements                                        {$$=template("\t%s",$1);}
;

statements:
    statement                       {$$=template("%s",$1);}
|   statement statements      {$$=template("%s\n\t%s",$1,$2);}  
;

%%
int main(void) {

  if ( yyparse() != 0 )
      printf("/* Rejected! */\n");
  else {
    printf("/* Accepted! */\n");
 } 

}