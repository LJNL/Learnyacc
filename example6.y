%{
int yydebug=1;
//#define YYSTYPE char*
#include<stdio.h>

void yyerror(const char *str){
    fprintf(stderr,"error: %s\n",str);
}
int yywrap(){
    return 1;
}
int main(){
    yyparse();
    return 0;
}

%}

%token ZONETOK FILETOK QUOTE OBRACE EBRACE SEMICOLON
%union{
    int number;
    char * string;
}
%token <string>FILENAME
%token <string>WORD
%type <string>quotedname
%%
commands:
|
commands command SEMICOLON
;

command:
zone_set
;

zone_set:
ZONETOK quotedname zonecontent
{
    printf("Complete zone for '%s' found\n",$2);
}
;

zonecontent:
OBRACE zonestatements EBRACE
;

quotedname:
QUOTE FILENAME QUOTE
{
    $$=$2; //My valuea $$ 
}
;

zonestatements:
|
zonestatements zonestatement SEMICOLON
;
zonestatement:
statements
|FILETOK quotedname
{
    printf("A zonefile name '%s' was encountered\n",$2);
}
;

block:
    OBRACE zonestatements EBRACE SEMICOLON
;

statements:
    | statements statement
;
statement: WORD|block|quotedname
;

