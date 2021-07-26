# see https://github.com/xonixx/intellij-awk/issues/11
#{ print $/= b/ c /= d/ }
{ print $/= b/ c (/= d/) }
{ print /a/ + /b/ + !/c/}
