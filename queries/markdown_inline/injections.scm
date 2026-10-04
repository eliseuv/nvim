; Overrides the upstream markdown_inline injections (no `; extends`) so that
; `$…$` math is typst instead of LaTeX. snacks.image then renders it through
; its typst math query, and typst highlighting applies inside it.

((html_tag) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))

; Typst's own syntax: `$x$` is inline, `$ x $` (spaces inside) is display.
; `$$…$$` is deliberately left uninjected: stripping one `$` for typst leaves
; the outer pair on the line, and snacks then renders it inline between them.
((latex_block) @injection.content
  (#not-lua-match? @injection.content "^%$%$")
  (#set! injection.language "typst")
  (#set! injection.include-children))
