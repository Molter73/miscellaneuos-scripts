import win32api
import win32con
import win32security

k = win32api.RegOpenKeyEx(win32con.HKEY_LOCAL_MACHINE, 'software\\test',
                          0, win32con.KEY_ALL_ACCESS | win32con.KEY_WOW64_64KEY)
s = win32api.RegGetKeySecurity(k, win32con.DACL_SECURITY_INFORMATION)
acl = s.GetSecurityDescriptorDacl()
user = win32security.LookupAccountName(None, 'test')
acl.AddAccessAllowedAce(0, user[0])
s.SetDacl(True, acl, False)
win32api.RegSetKeySecurity(k, win32con.DACL_SECURITY_INFORMATION, s)
