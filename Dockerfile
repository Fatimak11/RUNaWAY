FROM nginx

LABEL author="Fatimah Alkhamees"

COPY . /usr/share/nginx/html

EXPOSE 80