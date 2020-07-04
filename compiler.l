%option noyywrap
%{
#include "compiler.tab.h"
#include <stdlib.h>
#include <stdio.h>
#define YY_DECL int yylex()
%}

newline [\n]
whitespace [ \t]+
variable [_a-zA-Z][_a-zA-Z0-9]{0,30}
integer [0-9]+

%%

{newline} {return NEWLINE;}
{whitespace}
{variable} {sscanf(yytext, "%s", yylval.varName); return(VAR);}
{integer} { yylval.val=atoi(yytext);
 return NUMBER;
}
"=" {return EQUAL;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULT;}
"/" {return DIV;}
.   {printf("Operation does not exist\n"); exit(1);}
%%

