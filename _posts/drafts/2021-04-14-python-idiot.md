## Encoding

Windows default encoding file is ANSI, which is quite different from *nix platforms, and not friendly.
Recommend pass encoding parameter to python command line, 'python -X utf8'.

``` shell
D:\>py
Python 3.9.4 (tags/v3.9.4:1f2e308, Apr  6 2021, 13:40:21) [MSC v.1928 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import locale
>>> locale.getpreferredencoding()
'cp936'
>>> exit()

D:\>py -X utf8
Python 3.9.4 (tags/v3.9.4:1f2e308, Apr  6 2021, 13:40:21) [MSC v.1928 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import locale
>>> locale.getpreferredencoding()
'UTF-8'
>>>exit()
```