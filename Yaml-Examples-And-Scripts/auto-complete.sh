# Make sure you have the following packages. 
# git sudo curl less redis bat



##Enabling kubectl auto completion
echo 'source /usr/share/bash-completion/bash_completion' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc

mkdir /etc/bash_completion.d
kubectl completion bash >/etc/bash_completion.d/kubectl


##Enabling alias’ to save you typing kubectl and kubectx

echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc
echo 'alias kx=kubectx' >>~/.bashrc
echo 'complete -F __start_kubectx kx' >>~/.bashrc
echo 'alias kn=kubens' >>~/.bashrc
echo 'complete -F __start_kubens kn' >>~/.bashrc

. ~/.bashrc


##Enabling kubectx for fast context switching

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

. ~/.bashrc


