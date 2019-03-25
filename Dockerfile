FROM gcr.io/kubeflow-images-public/tensorflow-1.12.0-notebook-cpu:v0.4.0

MAINTAINER Weikunt <weikun.t@google.com>

COPY ./requirements.txt /env

WORKDIR /env

RUN pip3 install -i https://pypi.doubanio.com/simple -r /notebooks/requirements.txt
RUN apt-get install -y apt-transport-https libhdfs3 libhdfs3-dev
RUN pip3 install --user jupyter_nbextensions_configurator \
    &&jupyter contrib nbextension install --user \
    && jupyter nbextensions_configurator enable --user \
    &&python -m pip install --user jupyter_contrib_nbextensions

CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]