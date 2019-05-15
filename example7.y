%{
#include<stdio.h>
#include<string.h>
char * heater=0;
void yyerror(const char *str){
    fprintf(stderr,"error: %s\n",str);
}
int yywrap(){
    return 1;//yyin->stdin yyout->stdout
}
int main(){
    yyparse();
    return 0;
}

%}

%token TOKHEATER TOKHEAT TOKTARGET TOKTEMPERATURE
%union
{
    int number;
    char *string;
}
%token <number> STATE
%token <number> NUMBER
%token <string> WORD
%%

commands:
        | commands command
        ;

command:
        heat_switch
        |
        target_set
        |
        heater_select
        ;

heat_switch:
        TOKHEAT STATE
        {
                if($2)
                    printf("\tHeat turned on\n");
                else
                    printf("\tHeat turned off\n");
        }
        ;

target_set:
        TOKTARGET TOKTEMPERATURE NUMBER
        {
                printf("\tHeater '%s'  Temperature set to %d\n",heater,$3); //number 3 value
        }
        ;

heater_select:
    TOKHEATER WORD
    {
        printf("\tSelected heater '%s'\n",$2);
        heater=$2;
    }