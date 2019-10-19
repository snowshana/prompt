function language_prompt --description 'Write out language version prompt'
    # Language

    set __language_prompt \
        (php_prompt) \
        (laravel_prompt) \
        (node_prompt) \
        (golang_prompt) \
        (python_prompt)
    
    echo (string join " " $__language_prompt)
end

function php_prompt
    type -q php; or return

    if not test -f composer.json \
        -o (count *.php) -gt 0
        return
    end

    set -g php_version (string replace "PHP " "" (php -v | grep -o "PHP [0-9][0-9.]*") 2> /dev/null)

    set_color magenta
    echo -sn "PHP v" $php_version
    set_color normal
end

function laravel_prompt
    type -q php; or return

    if not test -f artisan
        return
    end

    set -l laravel_version (php artisan -V | grep -o "[0-9][0-9.]*" 2> /dev/null)

    set_color magenta
    echo -sn "LARAVEL v" $laravel_version
    set_color normal
end

function node_prompt
    type -q node; or return

    if not test -f ./package.json \
        -o -d ./node_modules \
        -o (count *.js) -gt 0
        return
    end

    set -l node_version (node -v 2>/dev/null)

    set_color magenta
    echo -sn "NODE " $node_version
    set_color normal
end

function golang_prompt
    type -q go; or return

    if not test -f ./go.mod \
        -o -f ./vendor/vendor.json \
        -o (count *.go) -gt 0
        return
    end

    set -l go_version (string replace "go" "" (go version | cut -d ' ' -f 3) 2> /dev/null)

    set_color magenta
    echo -sn "GO " $go_version
    set_color normal
end

function python_prompt
    type -q python3; or return

    if not test (count *.py) -gt 0
        return
    end

    set -l python_version (python3 -V | cut -d ' ' -f 2 2> /dev/null)

    set_color magenta
    echo -sn "PYTHON v" $python_version
    set_color normal
end

