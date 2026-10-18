; Outline / symbol navigation.
;
; List every header as a jump target (handy in a long message -- jump
; straight to Subject, Content-Type, a specific X- header, etc.), and
; every MIME boundary as a target too, so you can jump from part to part
; in a multipart message without scrolling through base64.

(header
  name: (header_name) @name) @item

(mime_part
  (mime_boundary) @name) @item
