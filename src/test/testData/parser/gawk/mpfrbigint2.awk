BEGIN { print 0x1F12233445566778DFEF + 0 }
BEGIN { print strtonum("0x1F12233445566778DFEF") }
{ print $1 + 0 }
