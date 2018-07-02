FROM mysql:5.7

RUN apt-get update && \
	apt-get -y install git ruby gcc libmysqlclient-dev

ADD WPM_Latch /WPM_Latch
RUN chmod -R 755 /WPM_Latch
WORKDIR /WPM_Latch

