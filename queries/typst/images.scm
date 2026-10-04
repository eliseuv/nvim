; Overrides snacks.nvim's typst images query (no `; extends`) to skip math that
; is the body of a `#let` definition: those are templates, not equations, and
; function bodies like `#let dW(k) = $dd W_t^#k$` fail to render without args.

(call
  (ident) @ident
  (#eq? @ident "image")
  (group (string) @image.src)
  (#offset! @image.src 0 1 0 -1)
) @image

((math
  (#set! image.ext "math.typ")) @image.content @image
  (#not-has-ancestor? @image "let"))
