FROM centos:centos8
#ADD gcp-key.json /gcp-key.json

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y
RUN yum install sudo -y
RUN yum groupinstall "Development Tools" -y
RUN yum install python39 -y
RUN yum install python3-pip -y
RUN pip3 install --upgrade pip

COPY src/ /kaggle_project/src
COPY data/ /kaggle_project/data
COPY models/ /kaggle_project/models
COPY ./requirements.txt /kaggle_project
#COPY ./pyproject.toml /kaggle_project
#COPY ./poetry.lock /kaggle_project
COPY ./ds_app.py /kaggle_project
#RUN mkdir /home/gcp_keys
#COPY gcp-key.json /home/gcp_keys/gcp-key.json

WORKDIR /kaggle_project

RUN pip3 install -r requirements.txt

#RUN pip install poetry
#RUN poetry config virtualenvs.create false
#RUN poetry install --no-dev
