"'-------------------------
" Базовые настройки
"-------------------------
" Включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible

" Показывать положение курсора всё время.
set ruler

" Показывать незавершённые команды в статусбаре
set showcmd

" Включаем нумерацию строк
set nu

" Текст вставляется с сохранением отступа
"set nopaste
set paste

" Фолдинг
set foldmethod=manual

"Колоночка, чтобы показывать плюсики для скрытия блоков кода:
"set foldcolumn=1

" Использование иксового клипборда
set clipboard+=unnamed

" Поиск по набору текста (очень полезная функция)
set incsearch

" Отключаем подстветку найденных вариантов, и так всё видно.
set hlsearch

" Игнорировать регистр поиска
set ignorecase

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в режиме редактирования
set scrolljump=7

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы опуститься в режиме редактирования
set scrolloff=7

"Ленивая перерисовка экрана при выполнении скриптов
set lazyredraw

" Выключаем надоедливый "звонок"
set novisualbell
set t_vb=

" Поддержка мыши
set mouse=a
set mousemodel=popup

" При копировании добавить в иксовый буфер
nmap yy yy:silent .w !xclip<CR>
vmap y y:silent '<,'> w !xclip<CR>

" Вырубаем .swp и ~ (резервные) файлы
"set nobackup
set noswapfile

" Кодировка текста по умолчанию
set encoding=utf8
set termencoding=utf-8

" возможные кодировки файлов и последовательность определения.
set fileencodings=utf8,cp1251

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden

" Скрыть панель в gui версии ибо она не нужна
set guioptions-=T

" Сделать строку команд высотой в одну строку
set ch=1

" Скрывать указатель мыши, когда печатаем
set mousehide

" Включить автоотступы
set autoindent

" Влючить подстветку синтаксиса
syntax on

"Переносим на другую строчку, разрываем строки
set wrap
set linebreak

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Преобразование Таба в пробелы
" set expandtab
set noexpandtab
let s:tabwidth=4
" Размер табулации по умолчанию
exec 'set tabstop='     . s:tabwidth
exec 'set shiftwidth='  . s:tabwidth
exec 'set softtabstop=' . s:tabwidth

" Формат строки состояния
"set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
set laststatus=2

" Включаем "умные" отспупы ( например, автоотступ после {)
set smartindent

" Fix <Enter> for comment
set fo+=cr

" Опции сесссий
set sessionoptions=curdir,buffers,tabpages

"-------------------------
" Горячие клавиши
"-------------------------

" Пробел в нормальном режиме перелистывает страницы
nmap <Space> <PageDown>

" CTRL-F для omni completion
imap <C-F> <C-X><C-O>

" C-c and C-v - Copy/Paste в "глобальный клипборд"
vmap <C-c> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u
map <C-v> :set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

" C-y - удаление текущей строки
nmap <C-y> dd
imap <C-y> <esc>ddi

" C-d - дублирование текущей строки
imap <C-d> <esc>yypi

" Поиск и замена слова под курсором
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" F1 вкл/выкл отображения номеров строк
imap <F1> <Esc>:set<Space>nu!<CR>a
nmap <F1> :set<Space>nu!<CR>

" F2 - быстрое сохранение и выход
nmap <F2> :wq<cr>
vmap <F2> <esc>:wq<cr>i
imap <F2> <esc>:wq<cr>i

" F3 - открыть NerdTree
nmap <F3> :OpenNERDTree<CR>
vmap <F3> :OpenNERDTree<CR>
imap <F3> :OpenNERDTree<CR>

" F4 - создать вкладку
nmap <F4> :tabnew<cr>
vmap <F4> :tabnew<cr>
imap <F4> :tabnew<cr>

" F5 - предыдушая вкладка
nmap <F5> :tabprevious<cr>
vmap <F5> :tabprevious<cr>
imap <F5> :tabprevious<cr>

" F6 - следующая вкладка
nmap <F6> :tabnext<cr>
vmap <F6> :tabnext<cr>
imap <F6> :tabnext<cr>

" F7 - следующий буфер
map <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>i
imap <F7> <esc>:bn<cr>i

" F8 - список закладок
"map <F8> :MarksBrowser<cr>
"vmap <F8> <esc>:MarksBrowser<cr>
"imap <F8> <esc>:MarksBrowser<cr>

" F9 - "make" команда
"map <F9> :make<cr>
"vmap <F9> <esc>:make<cr>i
"imap <F9> <esc>:make<cr>i

" F10 - удалить буфер
map <F10> :bd<cr>
vmap <F10> <esc>:bd<cr>
imap <F10> <esc>:bd<cr>

" F11 - показать окно Taglist
"map <F11> :TlistToggle<cr>
"vmap <F11> <esc>:TlistToggle<cr>
"imap <F11> <esc>:TlistToggle<cr>
noremap <silent> <F11> :cal VimCommanderToggle()<CR>

" F12 - для работы с файлами в различных кодировках
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
menu Encoding.cp1251  :e ++enc=cp1251<CR>
menu Encoding.cp866   :e ++enc=cp866<CR>
menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
menu Encoding.utf-8   :e ++enc=utf-8<CR>
map <F12> :emenu Encoding.<Tab>

" < & > - делаем отступы для блоков
vmap < <gv
vmap > >gv

" Выключаем ненавистный режим замены
imap >Ins> <Esc>i

" Меню выбора кодировки текста (koi8-r, cp1251, cp866, utf8)
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>

" Редко когда надо [ без пары =)
imap [ []<LEFT>
" Аналогично и для {
imap {<CR> {<CR>}<Esc>O

" С-q - выход из Vim
map <C-Q> <Esc>:qa<cr>

" Слова откуда будем завершать
set complete=""
" Из текущего буфера
set complete+=.
" Из словаря
set complete+=k
" Из других открытых буферов
set complete+=b
" из тегов
set complete+=t

" Для pydiction
let g:pydiction_location = '/home/ekoz/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 20

" Для pathogen
" filetype on
" call pathogen#infect()
" call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Настройки для SessionMgr
let g:SessionMgr_AutoManage = 0
let g:SessionMgr_DefaultName = "mysession"

" Настройки для Tlist (показвать только текущий файл в окне навигации по  коду)
let g:Tlist_Show_One_File = 1

set completeopt-=preview
set completeopt+=longest
set mps-=[:]

" Поддержка SQL СУБД MySQL:
if has("autocmd")
         autocmd BufRead *.sql set filetype=mysql
endif

" Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1

" Включаем 256 цветов в терминале, мы ведь работаем из иксов?
" Нужно во многих терминалах, например в gnome-terminal
set t_Co=256

" Тема из Color Sampler Pack
set background=dark
" colorscheme ir_black
colorscheme delek
"colorscheme xoria256

" Восстановление позиции курсора при открытии файла в Vim
"if has("autocmd")
"    set viewoptions=cursor,folds
"    au BufWinLeave * mkview
"    au BufWinEnter * silent loadview
"endif

" Vim и кириллица переключение по CTL+^
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

"Функция для вызовы NERDTree
function OpenNERDTree()
  execute ":NERDTree"
  endfunction
  command -nargs=0 OpenNERDTree :call OpenNERDTree()

" Делаем файлы сценариев исполняемыми
au BufWritePost * if getline(1) =~ "^#!.*/bin/"|silent !chmod u+x %|endif

" включить сохранение резервных копий
set backup

" сохранять умные резервные копии ежедневно
function! BackupDir()
    " определим каталог для сохранения резервной копии
    let l:backupdir=$HOME.'/.vim/backup/'.
            \substitute(expand('%:p:h'), '^'.$HOME, '~', '')

    " если каталог не существует, создадим его рекурсивно
    if !isdirectory(l:backupdir)
        call mkdir(l:backupdir, 'p', 0700)
    endif

    " переопределим каталог для резервных копий
    let &backupdir=l:backupdir

    " переопределим расширение файла резервной копии
    let &backupext=strftime('~%Y-%m-%d~')
endfunction

" выполним перед записью буффера на диск
autocmd! bufwritepre * call BackupDir()

" Задаем собственные функции для назначения имен заголовкам табов -->
     function MyTabLine()
         let tabline = ''

        " Формируем tabline для каждой вкладки -->
             for i in range(tabpagenr('$'))
                " Подсвечиваем заголовок выбранной в данный момент вкладки.
                 if i + 1 == tabpagenr()
                     let tabline .= '%#TabLineSel#'
                 else
                     let tabline .= '%#TabLine#'
                 endif

                " Устанавливаем номер вкладки
                 let tabline .= '%' . (i + 1) . 'T'

                " Получаем имя вкладки
                 let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
             endfor
        " Формируем tabline для каждой вкладки <--

        " Заполняем лишнее пространство
         let tabline .= '%#TabLineFill#%T'

        " Выровненная по правому краю кнопка закрытия вкладки
         if tabpagenr('$') > 1
             let tabline .= '%=%#TabLine#%999XX'
         endif

         return tabline
     endfunction

     function MyTabLabel(n)
         let label = ''
         let buflist = tabpagebuflist(a:n)

        " Имя файла и номер вкладки -->
             let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

             if label == ''
                 let label = '[No Name]'
             endif

             let label .= ' (' . a:n . ')'
        " Имя файла и номер вкладки <--

        " Определяем, есть ли во вкладке хотя бы один
        " модифицированный буфер.
        " -->
             for i in range(len(buflist))
                 if getbufvar(buflist[i], "&modified")
                     let label = '[+] ' . label
                     break
                 endif
             endfor
        " <--

         return label
     endfunction

     function MyGuiTabLabel()
         return '%{MyTabLabel(' . tabpagenr() . ')}'
     endfunction

     set tabline=%!MyTabLine()
	 set guitablabel=%!MyGuiTabLabel()
" Задаем собственные функции для назначения имен заголовкам табов <--
