char [a-zA-Z]
digit [0-9]
special [$_@]
space " "
newline "\n"
SpacenNewline \n*.*\n*
Datatype "int"|"double"|"char"|"void"
Operator "="|"+"|"-"|"/"|"*"|"&"|"|"|"%"
Relational_Operator "<"|">"|"<="|">="|"&&"|"||"|"=="|"!="
Identifier ({char}|{digit}|{special})+

%{
    #include "prog.tab.h"
    #include <string.h>
    int yyparse();
    int yylex();
    int yyerror();
    FILE *yyout;
    void printtext();
    int singleline=0;
    int multiline=0;
    int line=0;
%}
%%
{newline} {line++;}
[/][/].* { singleline++;
    printf("Singleline comment found\n");
            fprintf(yyout,"Single line comment found %s\n",yytext);
            }
"/*"{SpacenNewline}*"*/" { multiline++;
            printf("Multiline comment found\n");
            fprintf(yyout,"Multi line comment found %s\n Comment ended\n",yytext); }
{newline} {
        printtext();
    }
{space} { 
        printtext();
    }
";" {

            printtext();
            return SM;
    }
"," {

            printtext();
            return CM;
    }
{digit}+ {
        printtext();
        fprintf(yyout,"lex 1:: %s\n",yytext);
        yylval.val = atoi(yytext);
        return NUM;
    }

"main" { 
        printtext();
        fprintf(yyout,"lex 2 --> %s\n",yytext);
        return MAIN;
        }
"println" { 
        printtext();
        fprintf(yyout,"lex 3 --> %s\n",yytext);
        return PRINTLN;
        }
"print" {
        printtext();
        fprintf(yyout,"lex 4 --> %s\n",yytext);
        return PRINT;
        }
"def_"({char}|{digit}|{special})+ {
        printtext();
        fprintf(yyout,"lex 5 --> %s\n",yytext);
        return FUNCTION;
        }
"var_"({char}|{digit}|{special})+ {
        printtext();
        fprintf(yyout,"lex 6 --> %s\n",yytext);
        strcpy(yylval.text,yytext);
        return ID;
        }

"int" {
        printtext();
        fprintf(yyout,"lex 7 --> %s\n",yytext);
        return INT;
        }
"double" {
        printtext();
        fprintf(yyout,"lex 8 --> %s\n",yytext);
        return DOUBLE;
        }
"char" {
        printtext();
        fprintf(yyout,"lex 9 --> %s\n",yytext);
        return CHAR;
        }

"for" {
        printtext();
        fprintf(yyout,"lex 10.1 --> %s\n",yytext);
        return FOR;
        }
"while" {
        printtext();
        fprintf(yyout,"lex 10.2 --> %s\n",yytext);
        return WHILE;
        }

"(" {
        printtext();
        fprintf(yyout,"lex 10 --> %s\n",yytext);
        return PB;
    }
")" {

            printtext();
            fprintf(yyout,"lex 11 --> %s\n",yytext);
            return PE;
        }
    

"{" {

            printtext();
            fprintf(yyout,"lex 12 --> %s\n",yytext);
            return BB;
    }
"}" {

            printtext();
            fprintf(yyout,"lex 13 --> %s\n",yytext);
            return BE;
        }

"<=" {

            printtext();
            fprintf(yyout,"lex 14 --> %s\n",yytext);
            return LE;
        }
">=" {

            printtext();
            fprintf(yyout,"lex 15 --> %s\n",yytext);
            return GE;
        }
"==" {

            printtext();
            fprintf(yyout,"lex 16 --> %s\n",yytext);
            return EQU;
        }
"!=" {

            printtext();
            fprintf(yyout,"lex 17 --> %s\n",yytext);
            return NEQU;
        }
"=" {

            printtext();
            fprintf(yyout,"lex 18 --> %s\n",yytext);
            return ASGN;
        }
"+" {

            printtext();
            fprintf(yyout,"lex 19 --> %s\n",yytext);
            return PLUS;
        }
"-" {

            printtext();
            fprintf(yyout,"lex 20 --> %s\n",yytext);
            return MINUS;
        }
"*" {

            printtext();
            fprintf(yyout,"lex 21 --> %s\n",yytext);
            return MULT;
        }
"/" {

            printtext();
            fprintf(yyout,"lex 22 --> %s\n",yytext);
            return DIV;
        }
"<" {

            printtext();
            fprintf(yyout,"lex 23 --> %s\n",yytext);
            return LT;
        }
">" {

            printtext();
            fprintf(yyout,"lex 24 --> %s\n",yytext);
            return GT;
            }

"else if" {

            printtext();
            fprintf(yyout,"lex 25 --> %s\n",yytext);
            return ELSEIF;
        }
    
"if" {

            printtext();
            fprintf(yyout,"lex 27 --> %s\n",yytext);
            return IF;
        }
    
"else" {

            printtext();
            fprintf(yyout,"lex 28 --> %s\n",yytext);
            return ELSE;
        }
    

"\""(.)*"\"" {
        printtext();
        fprintf(yyout,"lex 30 --> %s\n",yytext);
        strcpy(yylval.text,yytext+1);
        yylval.text[strlen(yylval.text)-1]='\n';
        return STR;
    }
"input" {
            printtext();
            fprintf(yyout,"lex 31 --> %s\n",yytext);
            return INPUT;
}

"calculate" {
            printtext();
            fprintf(yyout,"lex 31 --> %s\n",yytext);
            return CALCULATE;
}
%%

int yywrap()
{
    return 1;
}

int column  = 0;
void printtext()
{
    
}
int main(){
    freopen("sample.txt","r",stdin);
    yyout = fopen("lex_out.txt","w");

    yyparse();
    fclose(yyout);
}