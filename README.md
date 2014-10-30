Asterisk 13 in Docker
=====================

This builds Asterisk 13 from ubuntu:14.04

Build with:

    sudo docker build -t asterisk13 .

Extract sample config (optional) with:

    sudo docker run -ti --name="tmp" asterisk13 echo Boo
    sudo docker cp tmp:/etc/asterisk .
    sudo mv asterisk etc_asterisk
    sudo docker rm tmp

And run with:

    sudo docker run -ti --rm --name="asterisk13" --net=host -v `pwd`/etc_asterisk:/etc/asterisk -v `pwd`/voicemail:/var/spool/asterisk/voicemail -v `pwd`/monitor:/var/spool/asterisk/monitor -v `pwd`/run:/var/run/asterisk asterisk13

or replace `-ti --rm` with `-d` to spin in server mode.

You can see the asterisk logs through:

    sudo docker logs -f asterisk13

Enjoy!