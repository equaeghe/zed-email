; Foldable regions.
;
; Signature blocks and verbatim (#v+ ... #v-) blocks are the two body
; constructs that are genuinely worth collapsing -- they're the parts of
; a message you usually want out of the way while reading the actual
; reply.
;
; MIME parts aren't included here: `mime_part` only wraps a boundary line
; plus that part's own headers (see the grammar README for why), not the
; part's actual body content, so folding it wouldn't collapse the
; base64/quoted-printable noise the way you'd want -- there's nothing
; useful to fold there with the grammar as it stands.

(signature) @fold

(verbatim) @fold
