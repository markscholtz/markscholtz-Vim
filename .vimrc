" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" I have copied a lot of Steve Francia's .vimrc file which can 
" be found here: http://spf13.com/post/ultimate-vim-config
"
" }

" Setup Bundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
	filetype off
	runtime! autoload/pathogen.vim
	silent! call pathogen#runtime_append_all_bundles()
	silent! call pathogen#helptags()
" }

" Basics {
    set nocompatible    " must be first line
    set background=dark " Assume a dark background
	set hidden          " Not sure what this does, but apparently it should be a default setting
" }

" General {
	filetype plugin indent on  	" Automatically detect file types.
	syntax on 					" syntax highlighting
	set mouse=a					" automatically enable mouse usage
	"set autochdir 				" always switch to the current file directory..
	" not every vim is compiled with this, use the following line instead
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
	scriptencoding utf-8
	"set autowrite
	"set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	"set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	"set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	" set spell 		 	     	" spell checking on

	" Setting up the directories {
		set backup 						" backups are nice ...
        " Moved to function at bottom of the file
		set backupdir=$HOME/.vim/backup//  " but not when they clog .
		set directory=$HOME/.vim/swap// 	" Same for swap files
		set viewdir=$HOME/.vim/view// 	" same but for view files

		"" Creating directories if they don't exist
		silent execute '!mkdir -p $HOME/.vim/backup'
		silent execute '!mkdir -p $HOME/.vim/swap'
		silent execute '!mkdir -p $HOME/.vim/view'
		autocmd BufWinEnter * silent! loadview 			"make vim load view (state) (folds, cursor, etc)
		autocmd BufWinLeave * silent! mkview  			"make vim save view (state) (folds, cursor, etc)
	" }
" }

" Vim UI {
	"let g:molokai_original = 1 	" slight modification to the molokai theme
	"color molokai     	       		" load a colorscheme
	"color ir_black     	       		" load a colorscheme
	color vividchalk     	       		" load a colorscheme
	"set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	set cursorline  						" highlight current line
	"set cursorcolumn  						" highlight current line
	"hi cursorline guibg=#333333 			" highlight bg color of current line
	hi cursorline guibg=darkred 			" highlight bg color of current line
	"hi cursorcolumn guibg=#333333   		" highlight cursor
	autocmd BufEnter * set cursorline 		" highlight current line when entering a buffer
	autocmd BufLeave * set nocursorline 	" remove highlight from current line when leaving a buffer

	if has('cmdline_info')
		set ruler                  	" show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
		set showcmd                	" show partial commands in status line and
									" selected characters/lines in visual mode
	endif

	if has('statusline')
		set laststatus=1           	" show statusline only if there are > 1 windows
		" Use the commented line if fugitive isn't installed
		"set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
		set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
	endif

	set backspace=indent,eol,start 	" backspace for dummys
	set linespace=0 				" No extra spaces between rows
	set number 						" Line numbers on
	set showmatch                  	" show matching brackets/parenthesis
	set incsearch 					" find as you type search
	set hlsearch 					" highlight search terms
	set ignorecase 					" case insensitive search
	set smartcase 					" case sensitive when uc present
	set winminheight=0 				" windows can be 0 line high
	set wildmenu 					" show list instead of just completing
	set wildmode=list:longest,full 	" comand <Tab> completion, list matches, then longest common part, then all.
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	"set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code
	set gdefault					" the /g flag on :s substitutions by default

	" Highlight any text that goes beyond the 80th character of a line
	highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	match OverLength /\%81v.\+/
" }

" Formatting {
	set nowrap                     	" turn text wrap off by default
	set autoindent                 	" indent at the same level of the previous line
	set shiftwidth=4               	" use indents of 4 spaces
	set tabstop=4 					" an indentation every four columns
	set noexpandtab 	       		" tabs are tabs, not spaces
	"set matchpairs+=<:>            	" match, to be used with %
	"set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	
	" Show all whitespace (from http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character)
	set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< " This shows spaces as ~ when using the 'set list" command 
" }

" Key Mappings {

	" Change mapleader key
	let mapleader = ","

	" Easier moving in tabs and windows
	map <C-J> <C-W>j<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <C-L> <C-W>l<C-W>_
	map <C-H> <C-W>h<C-W>_
	map <S-H> gT
	map <S-L> gt

	" Quickly jump between two most recent buffers
	map <Space> <C-^>

	" Easier moving between wrapped lines
	nmap <silent> j gj
	nmap <silent> k gk

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Toggle settings
	nnoremap <Leader>c :set cursorline!<CR>

	" Shortcut for commands
	nnoremap <silent> <Leader>b :FufBuffer<CR>
	nnoremap <silent> § :NERDTreeToggle<CR>
	nnoremap <silent> <Leader>t :TlistToggle<CR>

	" Shortcut to edit my .vimrc
	nmap <silent> <leader>ev :e $MYVIMRC<cr>

	" Reload my .vimrc to apply any changes made
	nmap <silent> <leader>sv :so $MYVIMRC<cr>

	" Call git blame on selected text (this seems to work, but the results don't hang around)
	vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
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
		set anti 								" antialias font
		set guioptions-=T          				" remove the toolbar
		set guioptions-=L						" turn off left scrollbar
		"set guioptions+=rb						" turn on right and horizontal scrollbars 
		set lines=40               				" 40 lines of text instead of 24,
		set columns=160             			" 160 columns
		"set guitablabel'%t guitabtooltip'%F 	" Tab headings 
	else
		color ir_black
	endif

	" Version specific settings {
		if has("gui_macvim")
			set guifont=Menlo:h12 				" set font
			set fuoptions=maxvert,maxhorz 		" fullscreen options (MacVim only), resized window when changed to fullscreen (max lines and columns)
			"autocmd GUIEnter * set fullscreen 		" enter fullscreen mode when GUI opens
		elseif has("gui_gtk2")
			set guifont=Monaco
		elseif has("x11")
		elseif has("gui_win32")
			set guifont=Monaco
			au GUIEnter * simalt ~x 			"Always open in maximized window state (Windows only I think)
		endif
	" }
" }
