if exists("b:current_syntax")
    finish
endif

" the sentence above the syn-priority clarifies why gourp name can be the same 
"
"Several syntax ITEMs can be put into one syntax GROUP.	For a syntax group
" you can give highlighting attributes.  For example, you could have an item
" to define a `/* .. */` comment and another one that defines a "// .." comment,
" and put them both in the "Comment" group.  You can then specify that a
" "Comment" will be in bold font and have a blue color.  You are free to make
" one highlight group for one syntax item, or put all items into one group.
" This depends on how you want to specify your highlighting attributes.  Putting
" each item in its own group results in having to specify the highlighting
" for a lot of groups.
"
" Note that a syntax group and a highlight group are similar.  For a highlight
" group you will have given highlight attributes.  These attributes will be used
" for the syntax group with the same name.
"
" In case more than one item matches at the same position, the one that was
" defined LAST wins.  Thus you can override previously defined syntax items by
" using an item that matches the same text.  But a keyword always goes before a
" match or region.  And a keyword with matching case always goes before a
" keyword with ignoring case.


" here monkeyCString is the syntax group name  
" start=/\v"/ skip=/\v\\./ end=/\v"/    is the syntax item name 
" syntax region	monkeyCString		start=/\v"/ skip=/\v\\./ end=/\v"/

syn region  monkeyCString	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	
syntax match	monkeyCCharacter	"L\='[^\\]'"
syntax keyword	monkeyCBoolean		false true
syntax keyword	monkeyCConditional	if else

syn keyword monkeyCRepeat		while for do 
syn keyword monkeyCBranch   break continue

" syntax match	monkeyCInclude		"Toybox.\w\+"
syntax keyword	monkeyCInclude		import 
syntax keyword	monkeyCKeyword		using extends
" syntax keyword	monkeyCStatement	new return continue hidden
" this highlights keywords and highlight the variable name 
syntax keyword	monkeyCStatement	new function nextgroup=monkeyCFunctionName skipwhite

" to override new with another highlight
syn keyword monkeyCOperator		new instanceof as or
syntax keyword monkeyCStatement class nextgroup=monkeyCClassName skipwhite
" syntax keyword monkeyCStatement return nextgroup=monkeyCReturnMethodName skipwhite
syntax keyword monkeyCStatement return

" syntax keyword	monkeyCStorageClass	var const

syn match	monkeyCFunction	"\<function\>"
" syn keyword monkeyCFunction	function
syn match monkeyCFunctionName "\h\w*" display contained
syn match monkeyCClassName "\h\w*" display contained
" syn match monkeyCReturnMethodName "/\<\w\+\.\w\+\>" display contained
" highlight method
syn match monkeyCFunctionName "\.\h\w*\ze(" nextgroup=monkeyCFunctionParathensis 
" hithlight ()
syn match monkeyCFunctionParathensis "[()]" 
" hithlight {}
syn match monkeyCFunctionParathensis "[{}]" 
" highlight []
syn match monkeyCFunctionParathensis "[][]" 
" highlight <>
syn match monkeyCFunctionAngleParathensis "[<>]" 

" syntax keyword	monkeyCStructure	class function
" syntax keyword	monkeyCStructure	class

" syntax keyword	monkeyCType			Gfx System Lang Ui Timer Attention 
syntax match	monkeyCType			"/\<Lang\>" 
syntax keyword	monkeyCType			Void
" syntax keyword	monkeyCType			String Numeric Array Float Long Double
syntax keyword	monkeyCType			interface
syntax keyword monkeyCReserved  const enum has module self using hidden private static var case default if protexted switch catch public throw else me try 


syntax keyword	monkeyCConstant		COLOR_WHITE COLOR_LT_GRAY COLOR_DK_GRAY COLOR_BLACK COLOR_RED COLOR_DK_RED COLOR_ORANGE COLOR_YELLOW COLOR_GREEN COLOR_DK_GREEN COLOR_BLUE COLOR_DK_BLUE COLOR_PURPLE COLOR_PINK COLOR_TRANSPARENT
syntax keyword	monkeyCConstant		FONT_XTINY FONT_TINY FONT_SMALL FONT_MEDIUM FONT_LARGE FONT_NUMBER_MILD FONT_NUMBER_MEDIUM FONT_NUMBER_HOT FONT_NUMBER_THAI_HOT FONT_SYSTEM_XTINY FONT_SYSTEM_TINY FONT_SYSTEM_SMALL FONT_SYSTEM_MEDIUM FONT_SYSTEM_LARGE FONT_SYSTEM_NUMBER_MILD FONT_SYSTEM_NUMBER_MEDIUM FONT_SYSTEM_NUMBER_HOT FONT_SYSTEM_NUMBER_THAI_HOT
syntax keyword	monkeyCConstant		TEXT_JUSTIFY_RIGHT TEXT_JUSTIFY_CENTER TEXT_JUSTIFY_LEFT TEXT_JUSTIFY_VCENTER
syntax keyword	monkeyCConstant		ARC_COUNTER_CLOCKWISE ARC_CLOCKWISE

syntax match	monkeyCOperator		"\v\*"
syntax match	monkeyCOperator		"\v/"
syntax match	monkeyCOperator		"\v\+"
syntax match	monkeyCOperator		"\v-"
syntax match	monkeyCOperator		"\v\?"
syntax match	monkeyCOperator		"\v\:"
syntax match	monkeyCOperator		"\v\%"
syntax match	monkeyCOperator		"\v\*\="
syntax match	monkeyCOperator		"\v/\="
syntax match	monkeyCOperator		"\v\+\="
syntax match	monkeyCOperator		"\v-\="
syntax match	monkeyCOperator		"\v\="
syntax match	monkeyCNumber		"\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syntax match	monkeyCNumber		"\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syntax match	monkeyCNumber		"\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syntax match	monkeyCNumber		"\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"


" syntax match	monkeyCLabel		":\w\+"
syn keyword monkeyCLabel		case default
syntax match	monkeyCLineComment		"\v//.*$" contains=@Spell
syn region  monkeyCComment	       start="/\*"  end="\*/" contains=@Spell

highlight def link	monkeyCString		String
highlight def link	monkeyCCharacter	Character
highlight def link	monkeyCBoolean		Boolean
highlight def link	monkeyCConditional	Conditional
highlight def link	monkeyCRepeat     Repeat
highlight def link	monkeyCBranch     Conditional
highlight def link	monkeyCInclude		Include
highlight def link	monkeyCKeyword		Keyword
highlight def link	monkeyCStatement	Statement
highlight def link	monkeyCStructure	Structure
" highlight def link	monkeyCStorageClass	StorageClass
highlight def link	monkeyCClassName	StorageClass
highlight def link	monkeyCType			Type
highlight def link	monkeyCConstant		Constant
highlight def link	monkeyCFunction		Keyword
highlight def link	monkeyCFunctionName		Function
highlight def link	monkeyCReturnMethodName		Function
highlight def link	monkeyCFunctionParathensis		Special
highlight def link	monkeyCFunctionAngleParathensis		Operator
highlight def link	monkeyCOperator		Operator
highlight def link	monkeyCNumber		Number
highlight def link	monkeyCLabel		Label
highlight def link	monkeyCLineComment		Comment
highlight def link	monkeyCComment		Comment
highlight def link	monkeyCReserved   Keyword

let b:current_syntax = "monkeyc"
