# Github Notes
### Terminal Commands
<details>
<summary>**Create** </summary>
```
echo "# [repo.name]" >> README.md
git init
git add .
git commit -m "info"
git branch -M main
git remote add origin https://github.com/[github.username]/[repo.name].git
git push (-u origin main)
```
</details>
<details>
<summary>** Commit** </summary>
```
git add .
git commit -m "info"
git push
```
</details>
<details>
<summary>**Push**</summary>
```
git push
```
</details>
<details>
<summary>**Pull** </summary>
```
git pull(-u origin main)
```
</details>
<details>
<summary>**Clone**</summary>
```
git clone https://github.com/[github.username]/[repo.name].git
cd [repo.name]
git config --global user.email "[email]"
git config --global user.name "MatthiasBenaets"
```
</details>

---

### Template
<details>
<summary>**.git/config**</summary>
```
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
```
</details>

---

### Token
<details>
<summary>**Personal Access Token**</summary>
[github.com/settings/tokens](https://github.com/settings/tokens)
<details>
<summary> </summary>
MatthiasBenaets <br>
ghp_AOKK7k63pl3B9FBurFCWMPThm3VjVLC022K0JZ <br>
Expires: 31/12/2021
</details> 
</details>
