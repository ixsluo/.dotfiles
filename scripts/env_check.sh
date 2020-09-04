#/bin/bash
echo 'environment checking ...'


echo '> checking package manager'
if command -v apt-get >/dev/null ; then
    echo 'apt-get founded'
    pm='apt-get'
elif command -v yum >/dev/null ; then
    echo 'yum founded'
    pm='yum'
else
    echo 'Neither apt-get nor yum is founded.'
fi

installed=''
n_install=''  # not install
command_test(){
    echo "> checking $1"
    if command -v $1 >/dev/null ; then
        echo "$1 installed"
        installed="$installed $1"
        return 0
    else
        echo "$1 not exist"
        n_install="$n_install $1"
        return 1
    fi
}

# test wget
command_test wget
if [ $? == 1 ] ; then
    echo "sudo $np install wget"
fi

# test git
command_test git
if [ $? == 1 ] ; then
    echo "sudo $pm install git"
fi

# test commitizen
command_test commitizen
if [ $? == 1 ] ; then
    # commitizen not installed
    command_test npm
    if [ $? == 1 ] ; then
        echo "sudo $pm install npm"
    fi
fi

# test conda
command_test conda
if [ $? == 1 ] ; then
    # conda not installed
    echo ""
fi

echo ""
echo "Installed:"
echo $installed
echo "Not installed:"
echo $n_install

