PROMPT="%{%B%F{#{{ accent_strip }}}%}[ %{%b%F{#{{ color6_strip }}}%}%t %{%B%F{#{{ accent_strip }}}%}] %{%B%F{#{{ accent_strip }}}%} [ %{%b%F{#{{ color6_strip }}}%}%n@%m:%~$(git_prompt_info)%{%f%F{#{{ color3_strip }}}%}$(ruby_prompt_info)%{%B%F{#{{ accent_strip }}}%} ]%{%f%b%}
$ "

ZSH_THEME_GIT_PROMPT_PREFIX="%{%B%F{#{{ color2_strip }}}%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{%f%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"
