FROM google/cloud-sdk:325.0.0-alpine

RUN apk --update add openjdk8-jre netcat-openbsd && gcloud components install --quiet beta pubsub-emulator

CMD [ "gcloud", "beta", "emulators", "pubsub", "start", "--host-port=0.0.0.0:8085", "--log-http", "--verbosity=debug", "--user-output-enabled" ]
