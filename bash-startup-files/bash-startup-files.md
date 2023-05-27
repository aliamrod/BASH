# Bash Startup Files
The Bash startup files are executed when initiating a Shell session. There are different log-in modes.

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
