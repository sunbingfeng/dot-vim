dot-vim
===========

One-stop .vim configuration to boost daily productivity.

# How to install

```shell
wget -qO - https://raw.github.com/sunbingfeng/dot-vim/master/setup.sh | bash
```

# How to use

- Generate compile flags for `YCM`

    - Set `CMAKE_EXPORT_COMPILE_COMMANDS` to `ON` if you are using cmake

    ```
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
    ```

    - Use 3rd tool [bear](https://github.com/rizsotto/Bear) if you are using makefile

- Generate tags using `ctag`. Refer to [e-ctags](http://ctags.sourceforge.net/) for more details.
  ctags tutorial: https://kulkarniamit.github.io/whatwhyhow/howto/use-vim-ctags.html
