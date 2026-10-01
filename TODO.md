# ctender.nvim — TODO

> tender silencioso, agora com versão clara. Strings em bege, funções em lima, tipos em azul-céu, constantes em âmbar, vermelho só para erro.

## Filosofia
- [x] Base: paleta do [tender](https://github.com/jacoborus/tender.vim) (fundo, texto e acentos).
- [x] Código: uma única cor de texto, exceto **strings (bege)**, **funções (lima)**, **tipos (azul-céu)** e **constantes/literais (âmbar)**, as mesmas cores do tender com treesitter e as mesmas dos kinds do LSP. Keywords em negrito; comentários em itálico e num tom mais apagado que o código (`c.comment`, ainda WCAG AA).
- [x] Opção `mono = true` para monocromático puro (todo o código no fg).
- [x] **Vermelho = erro.** Só em diagnósticos, mensagens de erro, `FIXME`/`BUG`, SpellBad, git delete e modo Replace. Teste garante.
- [x] **Sem roxo, sem rosa.** Fora da paleta; ANSI magenta e ícones roxos do mini.icons viram azure (teal do tender).
- [x] Cor apenas onde carrega significado: git, diagnósticos, kinds do LSP, ícones, busca, TODO/FIXME.

## Paleta
- [x] Dark: `#282828` (bg do tender) / `#dadada` (pearl do tender). Acentos do tender sem alteração, exceto red e teal, clareados o mínimo para WCAG AA.
- [x] Light (nova): `#f2f2f2` / `#4b4b4b`, cinza neutro como o tender. Acentos com os tons do tender, escurecidos o mínimo para passar WCAG AA; lima e âmbar deslocados alguns graus para não se confundirem com o bege.
- [x] Superfícies neutras (como o chrome do tender); só a seleção puxa para o azul (como o `Visual` do tender).
- [x] Accent de UI em lima (WildMenu/PmenuSel/TabLineSel do tender).
- [x] `c.code.{string,func,type,constant}` configurável via `on_colors`.
- [x] Script de validação de contraste (`scripts/contrast.lua`).

## Core (herdado do onemono.nvim)
- [x] Compilação para bytecode em cache, chaveado por hash da config + versão.
- [x] `ctender`, `ctender-light`, `ctender-dark`; troca automática via `background`.
- [x] `:CtenderCompile` / `:CtenderClearCache` / `:CtenderExtras`.

## Integrações
- [x] blink.cmp, mini.icons/pick/extra/files/tabline, gitsigns, dropbar, grug-far, mason, lazy.nvim, nvim-treesitter, semantic tokens.

## Extras
- [x] Ghostty, Kitty, Lazygit (light/dark) gerados da paleta.

## Documentação
- [x] README, `doc/ctender.txt`, banner e preview gerados da paleta.
