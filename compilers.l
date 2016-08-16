%{
#include "y.tab.h"
extern void yyerror(char *s);
%}

%%

"salir"						{return salir;}
[x]							{return x;}
"fx"						{return start;}
[1-9][0-9]*[.]?[0-9]*		{yylval.num = atof(yytext); return number;}
[ \t\n]           			;
[-+*\/^;\(\)=]         		{return yytext[0];}
.                 			{ECHO; yyerror("Caracter inesperado");}

%%
int yywrap (void) {return 1;}