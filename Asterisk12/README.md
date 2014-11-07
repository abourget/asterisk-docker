Asterisk 12 in Docker
=====================

This builds Asterisk 12 from ubuntu:14.04

Build with:

    sudo docker build -t asterisk12 .

Extract sample config (optional) with:

    sudo docker run -ti --name="tmp" asterisk12 echo Boo
    sudo docker cp tmp:/etc/asterisk .
    sudo mv asterisk etc_asterisk
    sudo docker rm tmp

And run with:

    sudo docker run -ti --rm --name="asterisk12" --net=host -v `pwd`/etc_asterisk:/etc/asterisk -v `pwd`/voicemail:/var/spool/asterisk/voicemail -v `pwd`/spool:/var/spool/asterisk -v `pwd`/run:/var/run/asterisk asterisk12

or replace `-ti --rm` with `-d` to spin in server mode.

In daemon mode, you can see the asterisk logs through:

    sudo docker logs -f asterisk12

Enjoy!
