FROM huggingface/transformers-pytorch-gpu:4.22.0

RUN apt update && \
    apt install -y git htop g++ && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/g++ 10 && \
    apt-get install -y zip unzip

COPY ./requirements.txt /
RUN pip3 install --upgrade pip && \
    pip3 install -r /requirements.txt

RUN git clone --branch fixing_prefix_allowed_tokens_fn https://github.com/MihailSalnikov/fairseq && \
    pip3 install ./fairseq && \
    echo "export PYTHONPATH=/fairseq/" >> ~/.bashrc

RUN git clone https://github.com/facebookresearch/KILT.git && \
    pip3 install ./KILT

RUN git clone https://github.com/MihailSalnikov/GENRE.git && \
    pip3 install ./GENRE

RUN cd fairseq && python3 setup.py build_ext --inplace

