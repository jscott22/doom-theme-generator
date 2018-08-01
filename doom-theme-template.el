;;; doom-{{ theme["name"] }}-theme.el
(require 'doom-themes)

;;
(defgroup doom-{{ theme["name"] }}-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-{{ theme["name"] }}-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-{{ theme["name"] }}-theme
  :type 'boolean)

(defcustom doom-{{ theme["name"] }}-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-{{ theme["name"] }}-theme
  :type 'boolean)

(defcustom doom-{{ theme["name"] }}-comment-bg doom-{{ theme["name"] }}-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-{{ theme["name"] }}-theme
  :type 'boolean)

(defcustom doom-{{ theme["name"] }}-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-{{ theme["name"] }}-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-{{ theme["name"] }}
  "Doom {{ theme["name"] }} theme"

  ;; name        default   256       16
  ((bg         '("{{ theme["colors"]["bg"] }}" nil       nil            ))
   (bg-alt     '("{{ theme["colors"]["bg-alt"] }}" nil       nil            ))
   (base0      '("{{ theme["colors"]["base0"] }}" "black"   "black"        ))
   (base1      '("{{ theme["colors"]["base1"] }}" "#1e1e1e" "brightblack"  ))
   (base2      '("{{ theme["colors"]["base2"] }}" "#2e2e2e" "brightblack"  ))
   (base3      '("{{ theme["colors"]["base3"] }}" "#262626" "brightblack"  ))
   (base4      '("{{ theme["colors"]["base4"] }}" "#3f3f3f" "brightblack"  ))
   (base5      '("{{ theme["colors"]["base5"] }}" "#525252" "brightblack"  ))
   (base6      '("{{ theme["colors"]["base6"] }}" "#6b6b6b" "brightblack"  ))
   (base7      '("{{ theme["colors"]["base7"] }}" "#979797" "brightblack"  ))
   (base8      '("{{ theme["colors"]["base8"] }}" "#dfdfdf" "white"        ))
   (fg-alt     '("{{ theme["colors"]["fg-alt"] }}" "#fdfdfd" "brightwhite"  ))
   (fg         '("{{ theme["colors"]["fg"] }}" "#dfdfdf" "white"        ))

   (grey       base4)
   (red        '("{{ theme["colors"]["red"] }}" "#ff6655" "red"          ))
   (orange     '("{{ theme["colors"]["orange"] }}" "#dd8844" "brightred"    ))
   (green      '("{{ theme["colors"]["green"] }}" "#99bb66" "green"        ))
   (teal       '("{{ theme["colors"]["teal"] }}" "#44b9b1" "brightgreen"  ))
   (yellow     '("{{ theme["colors"]["yellow"] }}" "#ECBE7B" "yellow"       ))
   (blue       '("{{ theme["colors"]["blue"] }}" "#51afef" "brightblue"   ))
   (dark-blue  '("{{ theme["colors"]["dark-blue"] }}" "#2257A0" "blue"         ))
   (magenta    '("{{ theme["colors"]["magenta"] }}" "#c678dd" "magenta"      ))
   (violet     '("{{ theme["colors"]["violet"] }}" "#a9a1e1" "brightmagenta"))
   (cyan       '("{{ theme["colors"]["cyan"] }}" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("{{ theme["colors"]["dark-cyan"] }}" "#5699AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-{{ theme["name"] }}-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-{{ theme["name"] }}-brighter-comments dark-cyan base5) 0.25))
   (constants      red)
   (functions      teal)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        base7)
   (variables      base8)
   (numbers        magenta)
   (region         dark-blue)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-{{ theme["name"] }}-brighter-modeline)
   (-modeline-pad
    (when doom-{{ theme["name"] }}-padded-modeline
      (if (integerp doom-{{ theme["name"] }}-padded-modeline) doom-{{ theme["name"] }}-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ((line-number &override) :foreground fg-alt)
   ((line-number-current-line &override) :foreground fg)
   ((line-number &override) :background (doom-darken bg 0.025))

   (font-lock-comment-face
    :foreground comments
    :background (if doom-{{ theme["name"] }}-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id
    :foreground highlight)

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   (telephone-line-accent-active
    :inherit 'mode-line
    :background (doom-lighten bg 0.2))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-lighten bg 0.05))

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background base2)
   (org-block-begin-line :background base2 :foreground comments)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-{{ theme["name"] }}-theme.el ends here
