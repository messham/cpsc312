# cpsc312
CPSC312 Project 1
Laura Barton
n4v9a
90229113

JM Messham
p1k0b
22307152


**Installation**

To use SyntaxValidator with emacs, save syntax-validator.el and syntax.pl in the path ~/.emacs.d/lisp/syntaxvalidator/ and add the following lines to your emacs configuration ```(add-to-list 'load-path "~/.emacs.d/lisp/syntaxvalidator/")
(require 'syntax-validator)```

**Use**

By default SyntaxValidator will not be assigned to a keybinding and must be called ```M-x syntax-validator``` while the current buffer is a .cpp file you wish to check correct syntax for. Calling this function will open up a new buffer showing the results.