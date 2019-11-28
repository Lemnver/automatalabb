/* scanner for a toy C-like language */

%option noyywrap

%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%%

#include	{printf("A import keyword: %s\n", yytext );}
{ID}*.h		{ printf( "A library: %s\n", yytext); }

{DIGIT}+    {	printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }



if|else|return|exit	 { printf( "A keyword: %s\n", yytext );	}

int|char	       { printf( "A type: %s\n", yytext ); }



"]"             printf( "End of range definition: %s\n", yytext );
"["             printf( "Start of range definition: %s\n", yytext );
"{"             printf( "Start of statement body: %s\n", yytext );
"}"             printf( "End of statement body: %s\n", yytext );
"("		printf("Start of domain: %s\n", yytext );
")"		printf("End of domain: %s\n", yytext );


";"		printf( "End of statement: %s\n", yytext );
","		printf("Seperator: %s\n", yytext );
"="|"+"|"-"|"*"|"/"|"%"|"&"|">"|"<"|"?"|"!"|"\\"   printf( "An operator: %s\n", yytext );
"\""	printf("String indicator: %s\n", yytext );
"\'"	printf("String indicator: %s\n", yytext );
\\t|\\n	    printf("Special string characters: %s\n", yytext);
{ID}+			{	printf("Variable:   %s\n", yytext ); }
[ \t\n]+          /* eat up whitespace */
.                 printf( "Unrecognized character: %s\n", yytext );

%%

int main(int argc, char **argv) {
 ++argv, --argc;                /* skip over program name */
 if (argc > 0)
  yyin = fopen(argv[0], "r");
 else
  yyin = stdin;
 yylex();
 return 0;
}

