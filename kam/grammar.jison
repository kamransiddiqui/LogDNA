* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

" "                   return 'AND'
")"                   /**/
\s+                   /* skip whitespace */
"\" "  /* */
"\""   return 'QT'
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"OR "                  return 'OR'
"AND "                 return 'AND'
"false"               return false
"true"                return true
"len("                return 'LEN'
[A-Za-z]+              return 'CHAR'
"<"                   return 'LT'
">"                   return 'GT'
">="                  return 'GTE'
"<="                  return 'LTE'
"="                   return 'EQ'
          
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"!"                   return '!'
"%"                   return '%'
"("                   return '('
")"                   return ')'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left 'OR' 'AND'
%right 'LT' 'GT' 'LTE' 'GTE' 'LEN' 'EQ' 'QT'
%left '^'
%right '!'
%right '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    | 'AND' 'OR'
        { return 'OR' }
    | OR AND
        { return 'OR' }
    ;

e
    : e '+' e
        {$$ = $1+$3;}
    | e '-' e
        {$$ = $1-$3;}
    | e 'OR' e
        {$$ = {$or:[$1, $3]}; }
    | e 'AND' e
        {$$ = {$and:[$1, $3]}; }
    |'LEN' e
        {$$ = {$len: $2 }; }
    |'QT' e
        {$$ = {$quoted:$2}; }
    |'GT' e
        {$$ = {$gt:$2}; }
    |'EQ' e
        {$$ = {$eq:$2}; }
    |'GTE' e
        {$$ = {$gte:$2}; }
    |'LT' e
        {$$ = {$lt:$2}; }
    |'LTE' e
        {$$ = {$lte:$2}; }
    | e '*' e
        {$$ = $1*$3;}
    | e '/' e
        {$$ = $1/$3;}
    | e '^' e
        {$$ = Math.pow($1, $3);}
    |'!' e
        {{
          $$ = {$not:$2};
        }}
    | e '%'
        {$$ = $1/100;}
    | '-' e %prec UMINUS
        {$$ = -$2;}
    | '(' e ')'
        {$$ = $2;}
    | NUMBER
        {$$ = Number(yytext);}
    | CHAR
        {$$ = yytext}
    ;

