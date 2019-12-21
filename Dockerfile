FROM pytorch/pytorch:1.3-cuda10.1-cudnn7-runtime


RUN apt-get update && apt-get install -y --no-install-recommends \
        dh-make \
        fakeroot \
        build-essential \
        devscripts \
        vim \
        wget \
        htop \
        tmux \
        unzip \
        lsb-release && \
    rm -rf /var/lib/apt/lists/*

# download and install awscli
RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
RUN ln -s /usr/local/bin/aws2 /usr/local/bin/aws

#install ddpg
RUN wget https://nicrl.s3.amazonaws.com/ddpg.zip
RUN unzip ddpg.zip


RUN pip install deep-reinforcement-learning/python
RUN pip install torch==1.3 gpustat

# install vimrc
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
# install tmuxrc
RUN git clone https://github.com/gpakosz/.tmux.git&&ln -s -f .tmux/.tmux.conf&&cp .tmux/.tmux.conf.local .

WORKDIR /workspace/deep-reinforcement-learning/p2_continuous-control
RUN tmux new-session -d -s monitoring htop
RUN tmux new-session -d -s gpu gpustat
