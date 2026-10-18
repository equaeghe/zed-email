; Syntax highlighting for RFC 5322 / MIME email messages.
;
; The mapping from node -> capture name follows the same choices Vim's
; mail.vim and KDE's email.xml make (see tree-sitter-email's README for
; the full node-by-node table); comments below just call out the specific
; source for anything non-obvious.

; --- mbox envelope -----------------------------------------------------
(envelope_line) @comment

; --- headers -------------------------------------------------------------

; Every header name gets a baseline @property styling (it's a field name),
; then the common/known header names (Vim's mailHeaderKey alternation;
; Kate's header-names keyword list) are re-styled as @keyword since they
; come from a closed, meaningful vocabulary -- this second pattern is
; listed after the first specifically so it wins for names that match.
(header_name) @property
((header_name) @keyword
  (#match? @keyword "(?i)^(Authentication-Results|Bcc|Cc|Comments|Content-Description|Content-Disposition|Content-Transfer-Encoding|Content-Type|Date|Delivered-To|DKIM-Signature|Errors-To|From|In-Reply-To|Keywords|Lines|Message-Id|List-Archive|List-Id|List-Help|List-Post|List-Unsubscribe|List-Subscribe|MIME-Version|Newsgroups|Organization|Precedence|Received|Received-SPF|References|Replied|Reply-To|Resent-Bcc|Resent-Cc|Resent-Date|Resent-From|Resent-Message-Id|Resent-Reply-To|Resent-Sender|Resent-To|Return-Path|Sender|Supersedes|To|User-Agent|Xref|X-Mailer|X-Priority|Followup-To|Control):$"))

; Subject gets its own emphasis (Vim links mailSubject to Title).
((header_name) @markup.heading
  (#match? @markup.heading "(?i)^Subject:$"))

; Header-value substructure (structured headers only -- see grammar README
; for why Subject doesn't get this).
(quoted_string) @string
(escaped_char) @string.escape
(comment) @comment
(address) @link_uri

; --- MIME multipart -------------------------------------------------------
(mime_boundary) @comment.special

; --- body: quoting, signatures, verbatim ----------------------------------

; Vim's mailQuoted1-6 / mailQuoteExp1-6, collapsed to one depth-agnostic
; quote scope (see grammar README). `content` is optional (a bare ">"
; line has none), so it's captured separately from the marker.
(quote_marker) @punctuation.special
(quote_content) @comment

(signature) @comment
(signature_marker) @punctuation.special

(verbatim_marker) @punctuation.special
(verbatim_line) @text.literal

; --- inline links in body / signature / quotes ---------------------------
(url) @link_uri
(email) @link_uri
