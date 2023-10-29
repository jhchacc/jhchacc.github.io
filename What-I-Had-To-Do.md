# What I had to do to build up this blog site (so far)

Besides bundled Github Pages functionality, I just wanted to auto-generate table of contents with so-called scroll-spy functionality. The effort is still work in progress - WIP.

1. Installed `ruby`, `chruby`, and `jekyll` as guided at https://jekyllrb.com/docs/installation/macos/.
```
# Install openssl@1.1 (if not installed) and set OpenSSL environment variables. See:
# - https://github.com/rbenv/ruby-build/discussions/2245
brew install openssl@1.1
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# Install chruby, ruby-install, and ruby 3.1.3
brew install chruby ruby-install
ruby-install 3.1.3 -- --enable-shared

# Activate chruby
echo "source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.bash_profile
echo "source $(brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.bash_profile
echo "chruby ruby-3.1.3" >> ~/.bash_profile
source ~/.bash_profile
ruby --version  # ruby 3.1.3p185 (2022-11-24 revision 1a6b16756e) [x86_64-darwin23]

# Install jekyll
gem install jekyll
```

2. Started with Jekyll and installed gem `github-pages` (see doc [here](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site) - step 7-10).

```
jekyll new --skip-bundle .
vim Gemfile  # replace 'gem "jekyll"' with 'gem "github-pages" (see step 10)
bundle install
```

(Gemfile)
```
# gem "jekyll"
gem "github-pages", "~> 228", group: :jekyll_plugins
```

3. Removed the fancy stuffs from Jekyll.

```
rm about.markdown index.markdown _config.yml 404.html
```

4. Set Markdown processor to [Github Flavoured Markdown (GFM)](https://github.github.com/gfm/) at `_config.yml` (see doc [here](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/setting-a-markdown-processor-for-your-github-pages-site-using-jekyll) - step 2-4)

```
echo 'markdown: GFM' > _config.yml
```

- https://etch-cure.github.io/blog/toggle-dark-mode/
- https://joont92.github.io/git/github-dark-theme-적용하기/
- https://daybreaker.info/2019/05/07/applying-dark-mode/
- https://devinlife.com/howto/

(for scrollspy)
- https://getbootstrap.com/docs/4.0/components/scrollspy/
- https://github.blog/changelog/2021-04-13-table-of-contents-support-in-markdown-files/



2. 
