#!/usr/bin/env python
# -*- coding: utf-8 -*-

# импортируем необходимые модули
import pexpect
from sys import argv

# принимаем ip адрес аргументом командной строки
p=pexpect.spawn('telnet %s' % argv[1])

# данные для логина
login='user'
password=''

i = p.expect(['Username:'])
if i == 0:
    p.sendline(login)
    p.expect('Password:')
    p.sendline(password)
    p.interact()
