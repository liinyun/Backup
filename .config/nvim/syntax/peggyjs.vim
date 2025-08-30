if exists("b:current_syntax")
    finish
endif

syntax match	peggyLineComment		"\v//.*$" contains=@Spell





highlight def link	peggyLineComment		Comment
