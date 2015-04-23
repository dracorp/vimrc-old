au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile */nginx-conf/**.conf set ft=nginx
au BufRead *access.log* setf httplog
au BufRead *error.log* setf httplog
" Parse the php-fpm.conf file as a dosini
autocmd BufRead,BufNewFile /etc/php/* set syntax=dosini
au BufRead *.vmb set ft=vim
