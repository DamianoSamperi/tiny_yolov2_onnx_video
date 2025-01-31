#
# Dockerfile to build the image of the tiny_yolov2_onnx_cam application
#

ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.7.1
FROM ${BASE_IMAGE}

ARG REPOSITORY_NAME=tiny_yolov2_onnx_cam
#ARG MODEL_URL='https://github.com/onnx/models/raw/master/vision/object_detection_segmentation/tiny-yolov2/model/tinyyolov2-8.tar.gz'
#ARG MODEL_URL='https://github.com/onnx/models/raw/main/vision/object_detection_segmentation/tiny-yolov2/model/tinyyolov2-8.tar.gz'
ARG MODEL_URL='https://github.com/onnx/models/blob/main/validated/vision/object_detection_segmentation/tiny-yolov2/model/tinyyolov2-8.tar.gz'
ARG LABEL_URL='https://raw.githubusercontent.com/pjreddie/darknet/master/data/voc.names'

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

WORKDIR /tmp

# Install ca-certificates and update package lists
RUN apt-get update && apt-get install -y ca-certificates

# Add Nvidia apt source and GPG key for secure package installation
COPY  nvidia-l4t-apt-source.list /etc/apt/sources.list.d/nvidia-l4t-apt-source.list
COPY  jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc
RUN apt-get update

# Install dependencies, including Cython and build tools
RUN apt-get update && \
    apt-get install -y libopencv-python && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-dev \
        build-essential \
        zlib1g-dev \
        zip \
        libjpeg8-dev \
        protobuf-compiler \
        libprotoc-dev \
        cmake \
        cython3 \
        libopenblas-dev \
        liblapack-dev && \
    rm -rf /var/lib/apt/lists/*

# Install a more recent version of Cython (>= 0.29.21) before numpy
RUN pip3 install --upgrade cython
RUN pip3 install --upgrade pip

# Install Python dependencies
RUN pip3 install setuptools wheel
RUN pip3 install numpy==1.13.3 protobuf==3.0.0
RUN pip3 install --no-deps "onnx>=1.6.0,<=1.11.0"
RUN pip3 install \
        Pillow>=5.2.0 \
        wget>=3.2 \
        pycuda \
        paho-mqtt

# Create and copy repository files into the container
RUN mkdir /${REPOSITORY_NAME}
COPY ./ /${REPOSITORY_NAME}

WORKDIR /${REPOSITORY_NAME}

# Download videos from GitHub
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/bolt-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/bolt-multi-size-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/bottle-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/car-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/classroom.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/driver-action-recognition.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/face-demographics-walking-and-pause.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/face-demographics-walking.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/fruit-and-vegetable-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/head-pose-face-detection-female-and-male.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/head-pose-face-detection-female.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/head-pose-face-detection-male.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/one-by-one-person-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/people-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/person-bicycle-car-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/store-aisle-detection.mp4 -P /${REPOSITORY_NAME}/video
RUN wget https://github.com/intel-iot-devkit/sample-videos/raw/master/worker-zone-detection.mp4 -P /${REPOSITORY_NAME}/video

# Download model and labels
RUN wget ${LABEL_URL}
RUN wget ${MODEL_URL}
