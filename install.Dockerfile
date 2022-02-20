FROM httpd:2.4
#RUN command
WORKDIR var/www/html
COPY index.html index.html 
#docker build -t my-apache2 . 
EXPOSE 80
CMD  [service apache2 start] 


 