# This docker file should be copied into dist via the build docker file and run from there.
# The purpose of this image is only to copy the already built 'build' directory and serve it
FROM nginx:alpine
COPY dist/ /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80