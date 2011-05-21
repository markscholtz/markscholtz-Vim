" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
"
" I have copied a lot of Steve Francia's .vimrc file which can
" be found here: http://spf13.com/post/ultimate-vim-config
"
" }

set nocompatible " must be first line

" Setup Bundle Support (pathogen plugin) {
    " The next two lines ensure that the ~/.vim/bundle/ system works
    filetype off
    runtime! autoload/pathogen.vim
    silent! call pathogen#runtime_append_all_bundles()
    silent! call pathogen#helptags()
" }

" Basics {
    set hidden          " Not sure what this does, but apparently it should be a default setting
" }

" General {
    filetype plugin indent on                       " Automatically detect file types.
    syntax enable                                   " syntax highlighting
    scriptencoding utf-8
    set autowrite
    set shortmess+=filmnrxoOtT                      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore                         " allow for cursor beyond last character
    set history=1000                                " Store a ton of history (default is 20)
    set nospell                                     " spell checking off
    set visualbell                                  " don't beep
    set noerrorbells                                " don't beep

    " Setting up the directories {
        set backup                        " backups are nice ...
        set backupdir=$HOME/.vim/backup// " but not when they clog .
        set directory=$HOME/.vim/swap//   " Same for swap files
        set viewdir=$HOME/.vim/view//     " same but for view files

        " Creating directories if they don't exist
        silent execute '!mkdir -p $HOME/.vim/backup'
        silent execute '!mkdir -p $HOME/.vim/swap'
        silent execute '!mkdir -p $HOME/.vim/view'
        if has('autocmd') "remain compatible with older versions of Vim that do not have the autocmd functions
          autocmd BufWinEnter * silent! loadview      "make vim load view (state) (folds, cursor, etc)
          autocmd BufWinLeave * silent! mkview        "make vim save view (state) (folds, cursor, etc)
        endif
    " }
" }

" Filetype Specifics {
    if has('autocmd')
      autocmd BufRead *.json set filetype=json
    endif
" }

" Vim UI {
    set showmode                   " display the current mode

    set cursorline              " highlight current line

    if has('cmdline_info')
      set ruler                                          " show the ruler
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
      set showcmd                                        " show partial commands in status line and
    endif

    if has('statusline')
      set laststatus=2                                      " always show statusline
      " Use the commented line if fugitive isn't installed
      "set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P   " a statusline, also on steroids
      set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
    endif

    set backspace=indent,eol,start " backspace for dummys
    set linespace=0                " No extra spaces between rows
    set number                     " Line numbers on
    set showmatch                  " show matching brackets/parenthesis
    set incsearch                  " find as you type search
    set hlsearch                   " highlight search terms
    set ignorecase                 " case insensitive search
    set smartcase                  " case sensitive when uc present
    set winminheight=0             " windows can be 0 line high
    set wildmenu                   " show list instead of just completing
    set wildmode=list:longest,full " comand <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]  " backspace and cursor keys wrap to
    "set scrolljump=5              " lines to scroll when cursor leaves screen
    set scrolloff=3                " minimum lines to keep above and below cursor
    set foldenable                 " auto fold code
    set gdefault                   " the /g flag on :s substitutions by default

    " Highlight any text that goes beyond the 80th character of a line
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
" }

" Formatting {
    set nowrap                        " turn text wrap off by default
    set autoindent                    " indent at the same level of the previous line
    set shiftwidth=2                  " use indents of 2 spaces
    set tabstop=2                     " an indentation every two columns
    set expandtab                     " tabs are expanded to spaces
    "set matchpairs+=<:>              " match, to be used with %
    "set pastetoggle=<F12>            " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/   " auto format comment blocks

    " Show all whitespace (from http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character)
    set list
    set listchars=tab:>-,trail:~,nbsp:~,extends:#,precedes:< " This shows spaces as ~ when using the 'set list' command
    "set listchars+=eol:$                                    " uncomment this to enable displaying end of line characters
" }

" Key Mappings {
    " Change mapleader key
    let mapleader = ","

    " Easier moving in tabs and windows
    "map <C-J> <C-W>j<C-W>_
    "map <C-K> <C-W>k<C-W>_
    "map <C-L> <C-W>l<C-W>_
    "map <C-H> <C-W>h<C-W>_
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
    map <S-H> gT
    map <S-L> gt

    " Quickly jump between two most recent buffers
    map <Space> <C-^>

    " Easier moving between wrapped lines
    nmap <silent> j gj
    nmap <silent> k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$ "TODO: this doesn't work ... fix.

    " Clear the search buffer (http://nvie.com/posts/how-i-boosted-my-vim/)
    nmap <silent> <Leader><Space> :nohlsearch<CR>

    " Toggle settings
    nnoremap <Leader>c :set cursorline!<CR>

    " Shortcut for commands
    nnoremap <silent> <Leader>fb :FufBuffer<CR>
    nnoremap <silent> <Leader>ff :FufFile<CR>
    nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
    "nnoremap <silent> <Leader>t :TlistToggle<CR>

    " Shortcut to edit my .vimrc
    nmap <silent> <leader>ev :e $MYVIMRC<cr>

    " Reload my .vimrc to apply any changes made
    nmap <silent> <leader>sv :so $MYVIMRC<cr>
" }

" Functions {
    map ,s :call StripWhitespace ()<CR>
    function! StripWhitespace ()
        exec ':%s/ \+$//gc'
    endfunction

    map ,df :call DistractionFreeWriting ()<CR>
    function! DistractionFreeWriting ()
        exec ':set fuoptions='
        exec ':set fullscreen'
        exec ':set columns=80'
        exec ':set guioptions-=r'
        exec ':set textwidth=76'
        exec ':set nonumber'
        exec ':set norelativenumber'
    endfunction

    " Show syntax highlighting groups for word under cursor
    nmap <C-S-P> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
      if !exists("*synstack")
        return
      endif
      echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc
" }

" Plugins {

  " Taglist {
      let Tlist_Use_Right_Window = 1
  " }

  " NERDTree {
      let NERDTreeChDirMode = 2
  " }

  " Vimwiki {
      let wiki_index = {}
      let wiki_index.path = '~/Dropbox/Text\ Files/Vim\ Wikis/'

      let g:vimwiki_list = [wiki_index]
  " }

" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
      set background=light
      color solarized
      set anti                              " antialias font
      set guioptions-=T                     " remove the toolbar
      set guioptions-=L                     " turn off left scrollbar
      "set guioptions+=rb                    " turn on right and horizontal scrollbars
      set lines=50                           " 50 lines of text instead of 24,
      set columns=200                       " 200 columns
      "set guitablabel'%t guitabtooltip'%F  " Tab headings
    else
      set background=light
      color solarized                      " There is an issue with the background colour at the moment :(
      "color ironman
    endif

    " Version specific settings {
        if has("gui_macvim")
          set guifont=Menlo:h12                 " set font
          set fuoptions=maxvert,maxhorz         " fullscreen options (MacVim only), resized window when changed to fullscreen (max lines and columns)
          if has('autocmd')
            "autocmd GUIEnter * set fullscreen    " enter fullscreen mode when GUI opens
          endif
        elseif has("gui_gtk2")
          set guifont=Monaco
        elseif has("x11")
        elseif has("gui_win32")
          set guifont=Monaco
          au GUIEnter * simalt ~x               "Always open in maximized window state (Windows only I think)
        endif
    " }
" }
