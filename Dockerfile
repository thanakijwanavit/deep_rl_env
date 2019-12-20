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


RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

RUN echo 'aws=aws2' >> ~/.bashrc

RUN wget https://nicrl.s3.amazonaws.com/ddpg.zip

RUN unzip ddpg.zip
RUN pip install deep-reinforcement-learning/python
RUN pip install torch==1.3
