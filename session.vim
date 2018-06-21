let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
map! <F1> <F1>
map! <F2> <F2>
map! <F3> <F3>
map! <F4> <F4>
map! <S-F1> <S-F1>
map! <S-F2> <S-F2>
map! <S-F3> <S-F3>
map! <S-F4> <S-F4>
map! <End> <End>
map! <Home> <Home>
map  :bp
map  :bn
nmap ;p :call DiffPacnew()
nmap ;d :call DiffBuffers()
map Q gq
vmap [% [%m'gv``
vmap ]% ]%m'gv``
vmap a% [%v]%
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
map <F1> <F1>
map <F2> <F2>
map <F3> <F3>
map <F4> <F4>
map <S-F1> <S-F1>
map <S-F2> <S-F2>
map <S-F3> <S-F3>
map <S-F4> <S-F4>
map <End> <End>
map <Home> <Home>
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set backup
set backupdir=~/.bdir
set backupskip=/tmp/*,/var/spool/cron/*
set diffopt=filler,iwhite
set helplang=en
set hidden
set history=300
set incsearch
set langnoremap
set laststatus=2
set mouse=a
set ruler
set runtimepath=~/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vim74/pack/dist/opt/matchit,/usr/share/vim/vimfiles/after,~/.vim/after
set shiftwidth=4
set statusline=#\ %-2n\ %y\ %m\ %r\ %f%=0x%02.2B\ %7(%3c%-3V%)\ x\ %l/%L\ %P
set tabstop=4
set undofile
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/music
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +2 app/controllers/application_controller.rb
badd +4 app/controllers/music_controller.rb
badd +1 app/controllers/api/v1/albums_controller.rb
badd +40 app/controllers/api/v1/artists_controller.rb
badd +50 app/controllers/api/v1/tracks_controller.rb
badd +13 app/views/music/index.html.erb
badd +11 app/views/api/v1/albums/_form.html.erb
badd +2 app/views/api/v1/albums/edit.html.erb
badd +10 app/views/api/v1/albums/index.html.erb
badd +2 app/views/api/v1/albums/new.html.erb
badd +5 app/views/api/v1/albums/show.html.erb
badd +26 app/views/api/v1/artists/_form.html.erb
badd +4 app/views/api/v1/artists/edit.html.erb
badd +10 app/views/api/v1/artists/index.html.erb
badd +10 app/views/api/v1/artists/new.html.erb
badd +6 app/views/api/v1/artists/show.html.erb
badd +21 app/views/api/v1/tracks/_form.html.erb
badd +6 app/views/api/v1/tracks/edit.html.erb
badd +13 app/views/api/v1/tracks/index.html.erb
badd +1 app/views/api/v1/tracks/new.html.erb
badd +5 app/views/api/v1/tracks/show.html.erb
badd +37 config/routes.rb
badd +1 config/application.rb
badd +9 config/initializers/mime_types.rb
badd +18 app/assets/stylesheets/music.scss
badd +6 app/models/track.rb
badd +81 app/assets/stylesheets/scaffolds.scss
badd +22 app/views/layouts/application.html.erb
badd +16 app/assets/javascripts/application.js
badd +14 config/initializers/assets.rb
badd +12 public/js/music.js
badd +25 app/controllers/search_controller.rb
badd +29 public/js/search.js
badd +3 public/js/delete.js
argglobal
silent! argdel *
argadd app/controllers/application_controller.rb
argadd config/application.rb
argadd config/routes.rb
argadd app/views/api/v1/tracks/show.html.erb
argadd app/views/api/v1/tracks/new.html.erb
argadd app/views/api/v1/tracks/index.html.erb
argadd app/views/api/v1/tracks/edit.html.erb
argadd app/views/api/v1/tracks/_form.html.erb
argadd app/views/api/v1/artists/show.html.erb
argadd app/views/api/v1/artists/new.html.erb
argadd app/views/api/v1/artists/index.html.erb
argadd app/views/api/v1/artists/edit.html.erb
argadd app/views/api/v1/artists/_form.html.erb
argadd app/views/api/v1/albums/show.html.erb
argadd app/views/api/v1/albums/new.html.erb
argadd app/views/api/v1/albums/index.html.erb
argadd app/views/api/v1/albums/edit.html.erb
argadd app/views/api/v1/albums/_form.html.erb
argadd app/views/music/index.html.erb
argadd app/controllers/api/v1/tracks_controller.rb
argadd app/controllers/api/v1/artists_controller.rb
argadd app/controllers/api/v1/albums_controller.rb
argadd app/controllers/music_controller.rb
edit public/js/search.js
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
edit public/js/search.js
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,!^F,o,O,e,0]
setlocal cinoptions=j1,J1
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 41 - ((40 * winheight(0) + 43) / 87)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
41
normal! 053|
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
