/* bibdb.filter.l
 *
 * Simplistic LaTeX command cleaner for flex or lex.
 *
 * version 0.1
 * 
 * Sylvain Schmitz <schmitz@i3s.unice.fr>
 * Copyright (c) Laboratoire I3S -- http://www.i3s.unice.fr
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
%{
char
accent (char accent, char letter)
{
  switch (accent)
    {
    case '\'': switch (letter)
        {
        case 'A': return '�';
        case 'E': return '�';
        case 'I': return '�';
        case 'O': return '�';
        case 'U': return '�';
        case 'a': return '�';
        case 'e': return '�';
        case 'i': return '�';
        case 'o': return '�';
        case 'u': return '�';
        default: return letter;
        }
    case '`': switch (letter)
        {
        case 'A': return '�';
        case 'E': return '�';
        case 'I': return '�';
        case 'O': return '�';
        case 'U': return '�';
        case 'a': return '�';
        case 'e': return '�';
        case 'i': return '�';
        case 'o': return '�';
        case 'u': return '�';
        default: return letter;
        }
    case '^': switch (letter)
        {
        case 'A': return '�';
        case 'E': return '�';
        case 'I': return '�';
        case 'O': return '�';
        case 'U': return '�';
        case 'a': return '�';
        case 'e': return '�';
        case 'i': return '�';
        case 'o': return '�';
        case 'u': return '�';
        default: return letter;
        }
    case '\"': switch (letter)
        {
        case 'A': return '�';
        case 'E': return '�';
        case 'I': return '�';
        case 'O': return '�';
        case 'U': return '�';
        case 'a': return '�';
        case 'e': return '�';
        case 'i': return '�';
        case 'o': return '�';
        case 'u': return '�';
        default: return letter;
        }
    case '.': switch (letter)
        {
        case 'A': return '�';
        case 'a': return '�';
        default: return letter;
        }
    case '~': switch (letter)
        {
        case 'N': return '�';
        case 'n': return '�';
        default: return letter;
        }
    case ',': switch (letter)
        {
        case 'C': return '�';
        case 'c': return '�';
        default: return letter;
        }
    default: return letter;
    }
}
%}

%option noyywrap

%s CMD

alpha       [A-Za-z]
name        {alpha}+
blank       [ \t\r\n]

acc         \\[\'\^\`\"~,.]
acccmd      \{{acc}{alpha}\}|{acc}\{{alpha}\}|{acc}{alpha}
command     \\{name}[@\*]?{blank}*(\[.*\])*{blank}*

comment     %[^\n]*\n

symbol      [\_\%\#\@\{\}\|\$\[\]]
nsymbol     [^\\\[\{\}\|\[\]\$\&\#\_\%\~']
text        ({nsymbol})+

ignore      {command}\{|\{{command}|{comment}|{symbol}

%%

\\AE                      printf("%s", "AE");
\\ae                      printf("%s", "ae");
\\OE                      printf("%s", "OE");
\\oe                      printf("%s", "oe");
\\ss                      printf("%c", '�');
{acc}{blank}*\{{alpha}\}  printf("%c", accent(yytext[1], yytext[yyleng - 2]));
\{{acc}{blank}*{alpha}\}  printf("%c", accent(yytext[2], yytext[yyleng - 2]));
{acc}{blank}*{alpha}      printf("%c", accent(yytext[1], yytext[yyleng - 1]));

"''"                      printf("%c", '\"');
"'"                       printf("%c", '\'');
\\,                       printf("%c", ',');
~                         printf("%c", ' ');
\\&                       printf("%s", "&amp;");
\\{symbol}                printf("%s", yytext+1);
{text}                    printf("%s", yytext);
{ignore}                  ;


%%

int
main ()
{
  return yylex();
}
