%{
void yyerror (char *s);
int yylex(void);
#include <stdio.h>
#include <stdlib.h>
float exponentiate(float n, float e);
float X;
%}

%union {float num;} 
%start S
%token start
%token salir
%token  x
%token <num> number
%type <num> S exp   a b c val

%%

S 	: 	salir ';'			{exit(1);}	
		| exp ';' 			{printf("%f\n",$1);}
		| S exp ';'			{printf("%f\n",$2);}
		| void '=' exp ';' 	{printf("Para x = %f, res = %f\n",X,$3);}
		| S void '=' exp ';'{printf("Para x = %f, res = %f\n",X,$4);}
		| S salir ';' 		{;}
		;

void: 	start '(' number ')' {X = $3;};


exp : 	a 					{$$ = $1;}
		| exp '+' a 		{$$ = $1 + $3;}
		| exp '-' a 		{$$ = $1 - $3;}
		;

a 	: 	b 					{$$ = $1;}
		| a '*' b 			{$$ = $1 * $3;}
		| a '/' b {			$$ = $1 / $3;}
		;

b 	: 	c 					{$$ = $1;}
		|b c				{$$ = $1 * $2;}
		;

c 	: 	val 				{$$ = $1;}
		| c '^' val 		{$$ = exponentiate($1,$3);}
		;

val :	x 					{$$ = X;}
		|number 			{$$ = $1;}
		|'(' exp ')'		{$$ = $2;}
		;


%%                     

float exponentiate(float n, float e)
{
	int result = 1;
	for(int i = 0;i<e;i++)
	{
		result *= n;
	}
	return result;
} 


int main (void) {	
	return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 