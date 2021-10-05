# Github Notes
### Terminal Commands
<details>
<summary>Create</summary>
<pre>
echo "# [repo.name]" >> README.md
git init
git add .
git commit -m "info"
git branch -M main
git remote add origin https://github.com/[github.username]/[repo.name].git
git push (-u origin main)
</pre>
</details>
<details>
<summary>Commit</summary>
<pre>
git add .
git commit -m "info"
git push
</pre>
</details>
<details>
<summary>Push</summary>
<pre>
git push
</pre>
</details>
<details>
<summary>Pull</summary>
<pre>
git pull(-u origin main)
</pre>
</details>
<details>
<summary>Clone</summary>
<pre>
git clone https://github.com/[github.username]/[repo.name].git
cd [repo.name]
git config --global user.email "[email]"
git config --global user.name "MatthiasBenaets"
</pre>
</details>

---

### Template
<details>
<summary>.git/config</summary>
<pre>
[core] 
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = https://www.github.com/[github.username]/[repo.name]
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main
</pre>
</details>

---

### Token
<details>
<summary>Personal Access Token</summary>
<a href="https://github.com/settings/tokens">github.com/settings/tokens</a><b>
<details>
<summary>Token</summary>
MatthiasBenaets <br>
Token: see home directory <br>
Expires: 31/12/2021
</details> 
</details>
