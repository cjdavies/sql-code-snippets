# Method 1 (Recommended): Use **PowerShell via Command Line**

This method works even if folders contain files and does not require guessing folder names.

### Run **Command Prompt as Administrator**, then execute:

```cmd
powershell -Command "Get-ChildItem 'C:\Windows\CCMCache' -Directory | Remove-Item -Recurse -Force"
```

What this does:

   Deletes **all subfolders**
   Leaves the `CCMCache` folder intact (important)
   Forces removal even if files are read-only

# Method 2: Pure **CMD (no PowerShell)**

If PowerShell is restricted, use this:

```cmd
for /d %i in (C:\Windows\CCMCache\*) do rmdir /s /q "%i"
```

Explanation:

   `/d` → operates on directories
   `/s` → removes all contents
   `/q` → quiet mode (no prompts)

**Important**: Run from an **Administrator Command Prompt**
