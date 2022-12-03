# Rosetta Stone

scroll and shift-scroll

| Action | Void | Arch | Red Hat/Fedora | Debian/Ubuntu | SUSE/openSUSE | Gentoo |
|--------|------|------|----------------|---------------|---------------|--------|
| Install a package(s) by name | xbps-install | pacman -S | dnf install | apt-get install | zypper install zypper in | emerge [-a] |
| Remove a package(s) by name | xbps-remove | pacman -R | dnf remove | apt-get remove | zypper remove zypper rm | emerge -C |
| Remove a package(s) by name and its dependencies that aren't required by other installed packages | xbps-remove -R | pacman -Rs |  |  | zypper rm -u | emerge -C then emerge -c |
| Search for package(s) by searching the expression in name, description, short description. What exact fields are being searched by default varies in each tool. Mostly options bring tools on par. | xbps-query -Rs | pacman -Ss | dnf search | apt-cache search | zypper search zypper se [-s] | emerge -S |
| Upgrade Packages - Install packages which have an older version already installed | xbps-install -Su | pacman -Syu | dnf upgrade | apt-get update; apt-get upgrade | zypper update zypper up | emerge -u world |
| Upgrade Packages - Another form of the update command, which can perform more complex updates -- like distribution upgrades. When the usual update command will omit package updates, which include changes in dependencies, this command can perform those updates. | xbps-install -Su | pacman -Syu | dnf distro-sync | apt-get dist-upgrade | zypper dup | emerge -uDN world |
| Reinstall given Package - Will reinstall the given package without dependency hassle. | xbps-install -f | pacman -S | dnf reinstall | apt-get install --reinstall | zypper install --force | emerge [-a] |
| Installs local package file, e.g. app.rpm and uses the installation sources to resolve dependencies |  | pacman -U | dnf install | dpkg -i && apt-get install -f | zypper in /path/to/local.rpm | emerge |
| Updates package(s) with local packages and uses the installation sources to resolve dependencies |  | pacman -U | dnf upgrade | debi |  | emerge |
| Use some magic to fix broken dependencies in a system | xbps-pkgdb -a | pacman dep level - testdb, shared lib level - findbrokenpkgs or lddd | dnf repoquery --unsatisfied | apt-get --fix-broken aptitude install | zypper verify | revdep-rebuild |
| Only downloads the given package(s) without unpacking or installing them | xbps-install -D | pacman -Sw | dnf download | apt-get install --download-only (into the package cache) apt-get download (bypass the package cache) | zypper --download-only | emerge --fetchonly |
| Remove dependencies that are no longer needed, because e.g. the package which needed the dependencies was removed. | xbps-remove -o | pacman -Qdtq | pacman -Rs - | dnf autoremove | apt-get autoremove& | emerge --depclean |
| Downloads the corresponding source package(s) to the given package name(s) |  | Use ABS && makepkg -o | dnf download --source | apt-get source / debcheckout | zypper source-install | emerge --fetchonly |
| Remove packages no longer included in any repositories. |  |  |  | package-cleanup --orphans | aptitude purge '\~o' |  |
| Install/Remove packages to satisfy build-dependencies. Uses information in the source package. |  | automatic | dnf builddep | apt-get build-dep | zypper si -d | emerge -o |
| Add a package lock rule to keep its current state from being changed | xbps-pkgdb -m hold | /etc/pacman.conf modify IgnorePkg array | dnf.conf <--”exclude” option (add/amend) | apt-mark hold pkg | Put package name in /etc/zypp/locks, or zypper al | /etc/portage/package.mask |
| Delete a package lock rule | xbps-pkgdb -m unhold | remove package from IgnorePkg line in /etc/pacman.conf |  | apt-mark unhold pkg | Remove package name from /etc/zypp/locks or zypper rl | /etc/portage/package.mask (or package.unmask) |
| Show a listing of all lock rules | xbps-query -H | cat /etc/pacman.conf |  | /etc/apt/preferences | View /etc/zypp/locks or zypper ll | cat /etc/portage/package.mask |
| Mark a package previously installed as a dependency as explicitly required. | xbps-pkgdb -m manual | pacman -D --asexplicit |  | apt-mark manual |  | emerge --select |
| Install package(s) as dependency / without marking as explicitly required. | xbps-pkgdb -m auto | pacman -S --asdeps |  | aptitude install 'pkg&M' |  | emerge -1 |
| **Package information management** |  |  |  |  |  |  |
| Get a dump of the whole system information - Prints, Saves or similar the current state of the package management system. Preferred output is text or XML. (Note: Why either-or here? No tool offers the option to choose the output format.) | (see /var/db/xbps/pkgdb-\*.plist) | (see /var/lib/pacman/local) | (see /var/lib/rpm/Packages) | apt-cache stats |  | emerge --info |
| Show all or most information about a package. The tools' verbosity for the default command vary. But with options, the tools are on par with each other. | xbps-query -RS | pacman -[S | Q]i | dnf list, dnf info | apt-cache show / apt-cache policy | zypper info zypper if |
| Search for package(s) by searching the expression in name, description, short description. What exact fields are being searched by default varies in each tool. Mostly options bring tools on par. | xbps-query -Rs | pacman -Ss | dnf search | apt-cache search | zypper search zypper se [-s] | emerge -S |
| Lists packages which have an update available. Note: Some provide special commands to limit the output to certain installation sources, others use options. | xbps-install -Suvn | pacman -Qu | dnf list updates, dnf check-update | apt-get upgrade -> n | zypper list-updates zypper patch-check (just for patches) | emerge -uDNp world |
| Display a list of all packages in all installation sources that are handled by the packages management. Some tools provide options or additional commands to limit the output to a specific installation source. |  | pacman -Sl | dnf list available | apt-cache dumpavail apt-cache dump (Cache only) apt-cache pkgnames | zypper packages | emerge -ep world |
| Displays packages which provide the given exp. aka reverse provides. Mainly a shortcut to search a specific field. Other tools might offer this functionality through the search command. |  | pkgfile <filename> | dnf provides | apt-file search <filename> | zypper what-provides zypper wp | equery belongs (only installed packages); pfl |
| Display packages which require X to be installed, aka show reverse/ dependencies. | xbps-query -X | pacman -Sii | dnf provides | apt-cache rdepends / aptitude search \~Dpattern | zypper search --requires | equery depends |
| List all packages which are required for the given package, aka show dependencies. | xbps-query -x | pacman -[S | Q]i | dnf repoquery --requires | apt-cache depends / apt-cache show | zypper info --requires |
| List what the current package provides |  |  | dnf provides | dpkg -s / aptitude show | zypper info --provides | equery files |
| List the files that the package holds. Again, this functionality can be mimicked by other more complex commands. |  | pacman -Ql $pkgname pkgfile -l | dnf repoquery -l $pkgname | dpkg-query -L $pkgname | rpm -ql $pkgname | equery files |
| List all packages that require a particular package |  |  | repoquery --whatrequires [--recursive] | aptitude search \~D{depends,recommends,suggests}:pattern / aptitude why pkg | zypper search --requires | equery depends -a |
| Search all packages to find the one which holds the specified file. auto-apt is using this functionality. | xbps-query -o | pkgfile -s | dnf provides | apt-file search | zypper search -f | equery belongs |
| Display all packages that the specified packages obsoletes. |  |  | dnf list obsoletes | apt-cache show |  |  |
| Verify dependencies of the complete system. Used if installation process was forcefully killed. |  | testdb | dnf repoquery --requires | apt-get check | zypper verify | emerge -uDN world |
| Generates a list of installed packages | xbps-query -l | pacman -Q dnf list installed | dpkg --list | grep ^i | zypper search --installed-only | emerge -ep world |
| List packages that are installed but are not available in any installation source (anymore). |  | pacman -Qm | dnf list extras | deborphan | zypper se -si | grep 'System Packages' |
| List packages that were recently added to one of the installation sources, i.e. which are new to it. |  |  | dnf list recent | aptitude search '\~N' / aptitude forget-new |  | eix-diff |
| Show a log of actions taken by the software management. |  | cat /var/log/pacman.log | dnf history | cat /var/log/dpkg.log | cat /var/log/zypp/history | located in /var/log/portage |
| Clean up all local caches. Options might limit what is actually cleaned. Autoclean removes only unneeded, obsolete information. | xbps-remove -O | pacman -Sc pacman -Scc | dnf clean all | apt-get clean / apt-get autoclean / aptitude clean | zypper clean | eclean distfiles |
| Add a local package to the local package cache mostly for debugging purposes. |  | cp $pkgname /var/cache/pacman/pkg/ |  | apt-cache add |  |  |
| Display the source package to the given package name(s) |  |  | repoquery -s | apt-cache showsrc |  |  |
| Set the priority of the given package to avoid upgrade, force downgrade or to overwrite any default behavior. Can also be used to prefer a package version from a certain installation source. |  | ${EDITOR} /etc/pacman.conf | Modify HoldPkg and/or IgnorePkg arrays |  | /etc/apt/preferences, apt-cache policy | zypper mr -p |
| Remove a previously set priority |  |  |  | /etc/apt/preferences | zypper mr -p | ${EDITOR} /etc/portage/package.keywords remove offending line |
| Show a list of set priorities. |  |  |  | apt-cache policy /etc/apt/preferences | zypper lr -p | cat /etc/portage/package.keywords |
| Installation sources management | ${EDITOR} /etc/xbps.d/*.conf ${EDITOR} /usr/share/xbps.d/*.conf | ${EDITOR} /etc/pacman.conf | ${EDITOR} /etc/yum.repos.d/${REPO}.repo | ${EDITOR} /etc/apt/sources.list | ${EDITOR} /etc/zypp/repos.d/${REPO}.repo | layman |
| Add an installation source to the system. Some tools provide additional commands for certain sources, others allow all types of source URI for the add command. Again others, like apt and dnf force editing a sources list. apt-cdrom is a special command, which offers special options design for CDs/DVDs as source. | ${EDITOR} /etc/xbps.d/\*.conf or *{EDITOR} /usr/share/xbps.d/*.conf | /etc/pacman.conf | /etc/yum.repos.d/\*.repo | apt-cdrom add | zypper service-add | layman, overlays |
| Refresh the information about the specified installation source(s) or all installation sources. | xbps-install -S | pacman -Sy (always upgrade the whole system afterwards) | dnf clean expire-cache && dnf check-update | apt-get update | zypper refresh zypper ref | layman -f |
| Prints a list of all installation sources including important information like URI, alias etc. | xbps-query -L | cat /etc/pacman.d/mirrorlist | cat /etc/yum.repos.d/\* | apt-cache policy | zypper service-list | layman -l |
| Disable an installation source for an operation |  |  | dnf --disablerepo= |  |  | emerge package::repo-to-use |
| Download packages from a different version of the distribution than the one installed. |  |  | dnf --releasever= | apt-get install -t release package/ apt-get install package/release (deps not covered) |  | echo "category/package \~amd64" >> /etc/portage/package.keywords && emerge package |
| **Other commands** |  |  |  |  |  |  |
| Start a shell to enter multiple commands in one session |  |  |  | apt-config shell | zypper shell |  |
| **Package Verification** |  |  |  |  |  |  |
| Single package |  | pacman -Qk[k] <package> | rpm -V <package> | debsums | rpm -V <package> | equery check |
| All packages |  | pacman -Qk[k] | rpm -Va | debsums | rpm -Va | equery check |
| **Package Querying** |  |  |  |  |  |  |
| List installed local packages along with version | xbps-query -l | pacman -Q | rpm -qa | dpkg -l | zypper search -s; rpm -qa | emerge -e world |
| Display local package information: Name, version, description, etc. | xbps-query | pacman -Qi | rpm -qi | dpkg -s / aptitude show | zypper info; rpm -qi | emerge -pv and emerge -S |
| Display remote package information: Name, version, description, etc. | xbps-query -R | pacman -Si | dnf info | apt-cache show / aptitude show | zypper info | emerge -pv and emerge -S |
| Display files provided by local package | xbps-query -f | pacman -Ql | rpm -ql | dpkg -L | rpm -Ql | equery files |
| Display files provided by a remote package | xbps-query -Rf | pkgfile -l | repoquery -l | apt-file list pattern |  | pfl |
| Query the package which provides FILE | xbps-query -Ro (remote) xbps-query -o (local) | pacman -Qo | rpm -qf (installed only) or dnf provides (everything) | dpkg -S / dlocate | zypper search -f | equery belongs |
| Query a package supplied on the command line rather than an entry in the package management database |  | pacman -Qp | rpm -qp | dpkg -I |  |  |
| Show the changelog of a package |  | pacman -Qc | rpm -q --changelog | apt-get changelog |  | equery changes -f |
| Search locally installed package for names or descriptions | xbps-query -s | pacman -Qs | rpm -qa '*<str>*' | aptitude search '\~i(\~n name | \~d description)' |  |
| List packages not required by any other package | xbps-query -O | pacman -Qt | package-cleanup --all --leaves | deborphan -anp1 |  |  |
| **Building Packages** |  |  |  |  |  |  |
| Build a package | xbps-src | makepkg -s | rpmbuild -ba (normal) mock (in chroot) | debuild | rpmbuild -ba; build; osc build | ebuild; quickpkg |
| Check for possible packaging issues | xlint | namcap | rpmlint | lintian | rpmlint | repoman |
| List the contents of a package file |  | pacman -Qpl <file> | rpmls rpm -qpl | dpkg -c | rpm -qpl |  |
| Extract a package |  | tar -Jxvf | rpm2cpio | cpio -vid | dpkg-deb -x | rpm2cpio |
| Query a package supplied on the command line rather than an entry in the package management database |  | pacman -Qp | rpm -qp | dpkg -I |  |  |
| **Action** | **Void** | **Arch** | **Red Hat/Fedora** | **Debian/Ubuntu** | **SUSE/openSUSE** | **Gentoo** |
