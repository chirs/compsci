# Lexical analysis of python.

# Besides NEWLINE, INDENT and DEDENT, the following categories of tokens exist:
# identifier ::=  (letter|"_") (letter | digit | "_")*
# letter     ::=  lowercase | uppercase
# lowercase  ::=  "a"..."z"
# uppercase  ::=  "A"..."Z"
# digit      ::=  "0"..."9"

# 0var = 1
# SyntaxError: invalid syntax

# Keywords:
# and       del       from      not       while
# as        elif      global    or        with
# assert    else      if        pass      yield
# break     except    import    print
# class     exec      in        raise
# continue  finally   is        return
# def       for       lambda    try

# and = False
# SyntaxError: invalid syntax


# Operators
# +       -       *       **      /       //      %
# <<      >>      &       |       ^       ~
# <       >       <=      >=      ==      !=      <>

