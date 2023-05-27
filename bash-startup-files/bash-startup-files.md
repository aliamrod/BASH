# Bash Startup Files
The Bash startup files are executed when initiating a Shell session. There are different log-in modes.

This section describes how Bash executes its startup files. If any of the fils exist but cannot be read, Bash reports an error. Tildes are expanded in filenames as described under Tilde Expansion in "Miscellaneous".

## Interactive Login Shell.
---------------------------------------------------------------------
◉ This mode refers to opening a local terminal in your machine or connecting to a remote one interactively. In other words, a session is initiated after a successful login. `ssh user@host`

◉ Examples:

||
|:--:|
<img width="358" alt="Screen Shot 2023-05-27 at 10 10 35 AM" src="https://github.com/aliamrod/BASH/assets/62684338/a8c2a021-3bc8-4bce-80e7-e81d72ca8297">
|Fig 1. - Local interactive login shell|










## Interative Non-Login Shell.
---------------------------------------------------------------------
◉ It consists of running a new Shell session (subshell) from an interative login shell when opening a child shell from a terminal already logged on.

```bash
bash

```
◉ It also happens when running a remote Shell command from your terminal.
```bash
ssh test@localhost cat /etc/os-release

```

```bash
||
|:--:|
|![i])
```

## Bash Startup Files Precedence
---------------------------------------------------------------------
The following diagram demonstrates the Bash startup precedence on Ubuntu 22.04 system.

---
title: Bash startup files order of precedence
---
flowchart LR
  subgraph A["affect all users"]
    direction LR
    a(/etc/bash.bashrc) -->  b(/etc/profile) 
  end 
  subgraph B["interactive login shell (single user)"]
    direction LR
    subgraph when session starts
      c("~/.bash_profile") --> 
      d("~/.bash_login") --> 
      e("~/.profile") 
    end
    subgraph C["at session ends"]
      f("~/.bash_logout")
    end
  end
  subgraph D["interactive non-login shell (single user subshell)"]
    direction LR
      g("~/.bash_rc")
  end
  A --> B
  e --> f
  a --> g


## Miscellaneous
### Tilde Expansion
If a word begins with an unquoted tilde character ('~'), all of the characters up to the first unquoted slack (or all characters, if there is no unquoted slash) are considered a _tilde-prefix_. If none of the characters in the tilde-prefix are quoted, the characters in the tilde-prefix following the tilde are treated as a possible _login name_. If this login name is the null string, the tilde is repaced with the value of the `HOME` shell variable. If `HOME` is unset, the home directory of the user executing the shell is substituted instead. Otherwise, the tilde-prefix is replaced with the home directory associated with the specific login name.

If the tile-prefix is '~+', the value of the shell variable `PWD` replaces the tilde-prefix. 

Each variable assignmment is checked for unquoted tilde-prefixes immediately following a ':' or the first '='. In these cases, tilde expansion is also performed. Consequently, one may use filenames with tildes in assignments to `PATH`, `MAILPATH`, and `CDPATH`, and the shell assigns the expanded value.

The following table shows how Bash treats unquoted tilde-prefixes.

| Command | Description |
| --- | --- |
| ~ | The value of $HOME|
| ~/foo | $HOME/foo |
