/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_MYANALYZER_TAB_H_INCLUDED
# define YY_YY_MYANALYZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ident = 258,                   /* ident  */
    TK_IDENTIFIER = 259,           /* TK_IDENTIFIER  */
    TK_CONST_INT = 260,            /* TK_CONST_INT  */
    TK_CONST_FLOAT = 261,          /* TK_CONST_FLOAT  */
    TK_CONST_STRING = 262,         /* TK_CONST_STRING  */
    ASSIGNMENT_OPERATOR_ARROW_ASSIGN = 263, /* ASSIGNMENT_OPERATOR_ARROW_ASSIGN  */
    KW_INTEGER = 264,              /* KW_INTEGER  */
    KW_SCALAR = 265,               /* KW_SCALAR  */
    KW_STR = 266,                  /* KW_STR  */
    KW_BOOLEAN = 267,              /* KW_BOOLEAN  */
    KW_TRUE = 268,                 /* KW_TRUE  */
    KW_FALSE = 269,                /* KW_FALSE  */
    KW_CONST = 270,                /* KW_CONST  */
    KW_IF = 271,                   /* KW_IF  */
    KW_ELSE = 272,                 /* KW_ELSE  */
    KW_ENDIF = 273,                /* KW_ENDIF  */
    KW_FOR = 274,                  /* KW_FOR  */
    KW_IN = 275,                   /* KW_IN  */
    KW_ENDFOR = 276,               /* KW_ENDFOR  */
    KW_WHILE = 277,                /* KW_WHILE  */
    KW_ENDWHILE = 278,             /* KW_ENDWHILE  */
    KW_BREAK = 279,                /* KW_BREAK  */
    KW_CONTINUE = 280,             /* KW_CONTINUE  */
    KW_NOT = 281,                  /* KW_NOT  */
    KW_DEF = 282,                  /* KW_DEF  */
    KW_ENDDEF = 283,               /* KW_ENDDEF  */
    KW_MAIN = 284,                 /* KW_MAIN  */
    KW_RETURN = 285,               /* KW_RETURN  */
    KW_COMP = 286,                 /* KW_COMP  */
    KW_ENDCOMP = 287,              /* KW_ENDCOMP  */
    KW_OF = 288,                   /* KW_OF  */
    D_SEMICOLON = 289,             /* D_SEMICOLON  */
    D_COMMA = 290,                 /* D_COMMA  */
    D_COLON = 291,                 /* D_COLON  */
    RELATIONAL_OPERATOR_MORE_EQUALS = 292, /* RELATIONAL_OPERATOR_MORE_EQUALS  */
    RELATIONAL_OPERATOR_LESS_EQUALS = 293, /* RELATIONAL_OPERATOR_LESS_EQUALS  */
    RELATIONAL_OPERATOR_EQUALS = 294, /* RELATIONAL_OPERATOR_EQUALS  */
    RELATIONAL_OPERATOR_NOTEQUALS = 295, /* RELATIONAL_OPERATOR_NOTEQUALS  */
    ASSIGNMENT_OPERATOR_PLUS_ASSIGN = 296, /* ASSIGNMENT_OPERATOR_PLUS_ASSIGN  */
    ASSIGNMENT_OPERATOR_MINUS_ASSIGN = 297, /* ASSIGNMENT_OPERATOR_MINUS_ASSIGN  */
    ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN = 298, /* ASSIGNMENT_OPERATOR_MULTIPLICATION_ASSIGN  */
    ASSIGNMENT_OPERATOR_DIVISION_ASSIGN = 299, /* ASSIGNMENT_OPERATOR_DIVISION_ASSIGN  */
    ASSIGNMENT_OPERATOR_MODULO_ASSIGN = 300, /* ASSIGNMENT_OPERATOR_MODULO_ASSIGN  */
    ASSIGNMENT_OPERATOR_COLON_ASSIGN = 301, /* ASSIGNMENT_OPERATOR_COLON_ASSIGN  */
    ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN = 302, /* ASSIGNMENT_OPERATOR_HASHTAG_ASSIGN  */
    ASSIGNMENT_OPERATOR_ASSIGN = 303, /* ASSIGNMENT_OPERATOR_ASSIGN  */
    ARITHMETIC_OPERATOR_EXP = 304, /* ARITHMETIC_OPERATOR_EXP  */
    not_sure = 305,                /* not_sure  */
    ARITHMETIC_OPERATOR_PLUS = 306, /* ARITHMETIC_OPERATOR_PLUS  */
    ARITHMETIC_OPERATOR_MINUS = 307, /* ARITHMETIC_OPERATOR_MINUS  */
    ARITHMETIC_OPERATOR_MULT = 308, /* ARITHMETIC_OPERATOR_MULT  */
    ARITHMETIC_OPERATOR_DIVISION = 309, /* ARITHMETIC_OPERATOR_DIVISION  */
    ARITHMETIC_OPERATOR_MODULO = 310, /* ARITHMETIC_OPERATOR_MODULO  */
    RELATIONAL_OPERATOR_LESS = 311, /* RELATIONAL_OPERATOR_LESS  */
    RELATIONAL_OPERATOR_MORE = 312, /* RELATIONAL_OPERATOR_MORE  */
    D_LEFT_PARENTHESIS = 313,      /* D_LEFT_PARENTHESIS  */
    D_RIGHT_PARENTHESIS = 314,     /* D_RIGHT_PARENTHESIS  */
    D_LEFT_BLOCK = 315,            /* D_LEFT_BLOCK  */
    D_RIGHT_BLOCK = 316,           /* D_RIGHT_BLOCK  */
    D_DOT = 317,                   /* D_DOT  */
    KW_AND = 318,                  /* KW_AND  */
    KW_OR = 319,                   /* KW_OR  */
    Else = 320                     /* Else  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "myanalyzer.y"

	char* str;

#line 133 "myanalyzer.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_MYANALYZER_TAB_H_INCLUDED  */
