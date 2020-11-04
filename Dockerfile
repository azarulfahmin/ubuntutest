FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install vainfo && \
    apt-get install ssh && \
    systemctl ssh start && \
    systemctl ssh enable

EXPOSE 6379

CMD vainfo > ~/result.txt
