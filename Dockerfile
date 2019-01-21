FROM python:3.7

# These values are hard coded for the build, but
# should be set to something else at run time
ENV DJANGO_SECRET=default
ENV OPEN5E_DEBUG=False
ENV SERVER_NAME=localhost

ADD . /

WORKDIR /

RUN pip install --no-cache-dir -r requirements.txt

RUN sh scripts/generate_self_signed_cert.sh && \
  pip install pipenv && pipenv install && \
  pipenv run python manage.py migrate && \
  pipenv run python manage.py populatedb --flush /data/WOTC_5e_SRD_v5.1/

