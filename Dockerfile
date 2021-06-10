FROM jrottenberg/ffmpeg
LABEL maintainer="Varun Singh <admin@talkhash.com>"

# Install Pre-requisites
RUN apt-get update && \
    apt-get install python-dev python-pip -y && \
    apt-get clean

# Install aws cli for writing the thumbnail to S3
RUN pip install awscli

WORKDIR /tmp/workdir

COPY copy_thumbnail.sh /tmp/workdir

ENTRYPOINT ffmpeg -i ${INPUT_VIDEO_FILE_URL} -ss ${POSITION_TIME_DURATION} -vframes 1 -vcodec png -an -y ${OUTPUT_THUMBS_FILE_NAME} && ./copy_thumbs.sh