# jhchacc.github.io
My Github Pages - random thoughts

[German Declensions](./german/Declensions.md)

[Swift programming for macOS](./swift/MacOS.md)

Socket Programming

C/C++

[Google Style Guide](https://google.github.io/styleguide/)

[GitHub Docs Style Guide](https://docs.github.com/en/contributing/style-guide-and-content-model/style-guide)


## What I had to do to build up this blog site (so far)

1. Install `ruby`, `chruby`, and `jekyll` as guided at https://jekyllrb.com/docs/installation/macos/.
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

- https://etch-cure.github.io/blog/toggle-dark-mode/
- https://joont92.github.io/git/github-dark-theme-적용하기/
- https://daybreaker.info/2019/05/07/applying-dark-mode/
- https://devinlife.com/howto/

2. 
