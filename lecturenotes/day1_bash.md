# Housekeeping and introduction

00. Welcome to MSiA bootcamp
    * staff and instructor introductions
    * student introductions
    * bootcamp schedule

0. How the lab environment works
    * What's a remote desktop?
    * Where to store things: home directories, Z: drive, Team/T: drive
        * Don't move any data you're not supposed to move
    * Start getting comfortable with servers and clients

# Bash outline

1. Introduction
    * Motivation: why learn the shell?
        * The shell is the most general toolbox in the computing world
        * It's much, much more dominant than you think
        * No, seriously: the shell unlocks doors that will never open otherwise
        * Concepts from the shell pop up everywhere in computing
        * The shell allows you to solve many common problems yourself without having to wait on an IT person
        * Analytics trends come and go, but Bash is forever.
    * History of Unix and the prevalence of the shell
        * UNIX was developed in the 1970s at Bell Labs. Like other operating systems at the time, 
        it was proprietary, but AT&T licensed it to other vendors who made their 
        own OSes from it, all of which shared many common properties, allowing the computing world 
        to begin to standardize on a way of interacting with operating systems. Some of these 
        lineages are still around, but you probably don't need to worry about them.
        * True Unixes were really expensive and not accessible to individuals. BSD and Linux arose
        as free and open source Unix clones. Today, Linux dominates
            * most public web servers and other internet infrastructure
            * most data analysis environments and almost all high-performance clusters
            * embedded devices and the entire Internet of Things
            * Android and ChromeOS, which are Linux distributions
        * BSD itself is less common, but it forms the basis of Apple's entire line of OSes.
        * Today many people use Unix and Linux synonymously
    * Unix philosophy:
        * everything is a file
        * programs should do one thing and do it well
        * programs should operate on text streams because it is a universal interface
            * This means the Unix shell is not object-oriented. To get the current day of week, in Bash:
            ```bash
            [ltm909@rstudio ~]$ date
            Wed Sep 19 16:23:53 UTC 2018  # this is just text
            [ltm909@rstudio ~]$ date +%A # this just changes text formatting
            Wednesday
            ```
            
            Whereas in Powershell, the  `date` returns an object:
            ```
            PS C:\Users\lewis> date

            Wednesday, September 19, 2018 4:30:37 PM  # this is an object with a bunch of methods available


            PS C:\Users\lewis> $(date).IsDaylightSavingTime()
            True
            PS C:\Users\lewis> $(date).AddDays(60).IsDaylightSavingTime()
            False
            ```
    * terminology: 
        * Unix: a family of operating systems defined by their adherence to a specific 
        set of standards for how to interact with them
        * Linux: a free and open source Unix-like operating system (technically only the kernel)
        * Linux distro: a full operating system that packages the Linux kernel with other tools. 
        Common Linux distros are Red Hat, CentOS, Ubuntu, Debian, SUSE, etc.
        * shell: a special program that receives text input, passes commands to the OS, and sends 
        the output to the user (or anywhere else the user wants to send output to). The shell is the 
        main interface between the user and the operating system.
        * terminal: a program that displays shells and handles things like tabs, fonts, colors, 
        custom keyboard shortcuts, etc.
        * Bash: the default shell for regular (non-admin) users on most Unix-like OSes

2. Basic commands
    * `pwd`, `whoami`, `hostname`, `ls`, `ls -l`, `echo`, `which`
    * `Ctrl + C`, for example to escape `echo "hello`
    * `cd`, intro to paths
    * `/ ~ . ..`
    * `mkdir`, `cp`, `mv`: practice with paths
    * `rm` *careful with this one*
    * anatomy of a shell command: prompt, command, option, argument, cursor 
    ![shell_command](https://softcover.s3.amazonaws.com/636/learn_enough_command_line/images/figures/anatomy.png "Anatomy of a shell command")
    * `cat`
    
3. Shortcuts: typing in Bash is fast
    * A lot of this works outside the terminal!
    * Tab completion
    * Double-tap tab to see options
    * `↑` and `↓`
    * `Ctrl + ←/→`  to skip words
    * `Alt + Backspace` to delete words
    * `Ctrl + A`, `Ctrl + E` to go to beginning/end of line
    * `Ctrl + R` to search history
    * `Ctrl + C` to cancel
    
4. Making and editing files
    * `touch`
    * `echo 'something' > somefile`
    * `echo 'something else' >> somefile`
    * `nano`, `vim`
    
