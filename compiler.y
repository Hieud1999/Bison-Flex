%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror (char const *s);
int yylex();
int checkVarName(char *s);
char var[20];
int value;
%}

%union {
    char varName[20];
    int val;
}

%token NUMBER
%token VAR
%token EQUAL PLUS MINUS MULT DIV
%token NEWLINE

%type<val> NUMBER Declaration Expression
%type<varName> VAR

%start Input
%%

Input:
	| Input Line
;

Line:
	Declaration Expression { printf("%d", value); exit(0); }
;

Declaration:
	VAR EQUAL NUMBER NEWLINE {sscanf($1, "%s", var); value = $3;}
;

Expression:
	VAR PLUS NUMBER { checkVarName($1); value = value + $3; }
	| VAR MINUS NUMBER { checkVarName($1); value = value - $3; }
	| VAR MULT NUMBER { checkVarName($1); value = value * $3; }
    | VAR DIV NUMBER { 
        checkVarName($1); 
        if ($3 == 0) {
            printf("INFINITY");
            exit(1);
        };
        value = value / $3; }
;
;
%%

int checkVarName(char *s){
	if (strcmp(s, var)) {
		printf("Variable \"%s\" is not declared", s);
		exit(1);
    };
}

void yyerror (char const *s) {
	fprintf (stderr, "%s\n", s);
}


int main() {
    yyparse();
//   if (yyparse())
//      fprintf(stderr, "Successful parsing.\n");
//   else
//      fprintf(stderr, "error found.\n");
}