#!/usr/bin/env python
# -*- coding: utf-8 -*-

# импортируем необходимые модули
import pexpect
from sys import argv

# данные для логина
login='user'
password=''

# принимаем ip адрес аргументом командной строки
p=pexpect.spawn('ssh %s@%s' % ( login, argv[1]))

i = p.expect('[pP]assword: ', timeout=5)
if i == 0:
    p.sendline(password)
    p.interact()
