%{
#include<stdio.h>
/*
logging {
        category lame-servers { null; };
        category cname { null; };
};

zone "." {
        type hint;
        file "/etc/bind/db.root";
};
*/
%}

%%
[a-zA-Z][a-zA-Z0-9]*    printf("WORD ");
[a-zA-Z0-9\/.-]+    printf("FILENAME ");
\"  printf("QUOTE ");
\{  printf("OBRACE ");
\}  printf("EBRACE ");
;   printf("SEMICOLON ");
\n  printf("\n");
%%