FROM alpine:3.5

#https://github.com/tatsushid/docker-alpine-py3-tensorflow-jupyter

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV LOCAL_RESOURCES 2048,.8,1.0

ENV BAZEL_VERSION 0.4.3
ENV TENSORFLOW_VERSION 1.0.1

RUN apk add --no-cache python3 python3-tkinter freetype lapack libgfortran libpng libjpeg-turbo imagemagick graphviz git
RUN apk add --no-cache --virtual=.build-deps \
        bash \
        cmake \
        curl \
        freetype-dev \
        g++ \
        gfortran \
        lapack-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        linux-headers \
        make \
        musl-dev \
        openjdk8 \
        perl \
        python3-dev \
        rsync \
        sed \
        swig \
        zip \
    && : prepare for building TensorFlow \
    && : install numpy and wheel python module \
    && cd /tmp \
    && : numpy requires xlocale.h but it is not provided by musl-libc so just copy it from locale.h \
    && $(cd /usr/include/ && ln -s locale.h xlocale.h) \
    && pip3 install --no-cache-dir numpy wheel \
    && : \
    && : install Bazel to build TensorFlow \
    && curl -SLO https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip \
    && mkdir bazel-${BAZEL_VERSION} \
    && unzip -qd bazel-${BAZEL_VERSION} bazel-${BAZEL_VERSION}-dist.zip \
    && cd bazel-${BAZEL_VERSION} \
    && : add -fpermissive compiler option to avoid compilation failure \
    && sed -i -e '/"-std=c++0x"/{h;s//"-fpermissive"/;x;G}' tools/cpp/cc_configure.bzl \
    && : add '#include <sys/stat.h>' to avoid mode_t type error \
    && sed -i -e '/#endif  \/\/ COMPILER_MSVC/{h;s//#else/;G;s//#include <sys\/stat.h>/;G;}' third_party/ijar/common.h \
    && bash compile.sh \
    && cp -p output/bazel /usr/bin/ \
    && : \
    && : build TensorFlow pip package \
    && cd /tmp \
    && curl -SL https://github.com/tensorflow/tensorflow/archive/v${TENSORFLOW_VERSION}.tar.gz \
        | tar xzf - \
    && cd tensorflow-${TENSORFLOW_VERSION} \
    && : add python symlink to avoid python detection error in configure \
    && $(cd /usr/bin && ln -s python3 python) \
    && : musl-libc does not have "secure_getenv" function \
    && sed -i -e '/JEMALLOC_HAVE_SECURE_GETENV/d' third_party/jemalloc.BUILD \
    && echo | PYTHON_BIN_PATH=/usr/bin/python \
                CC_OPT_FLAGS="-march=native" \
                TF_NEED_JEMALLOC=1 \
                TF_NEED_GCP=0 \
                TF_NEED_HDFS=0 \
                TF_NEED_OPENCL=0 \
                TF_NEED_CUDA=0 \
                TF_ENABLE_XLA=0 \
                bash configure \
    && bazel build -c opt --local_resources ${LOCAL_RESOURCES} //tensorflow/tools/pip_package:build_pip_package \
    && ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg \
    && : \
    && : install python modules including TensorFlow \
    && cd \
    && pip3 install --no-cache-dir /tmp/tensorflow_pkg/tensorflow-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl \
    && pip3 install --no-cache-dir pandas scipy jupyter \
    && pip3 install --no-cache-dir scikit-learn matplotlib Pillow \
    && pip3 install --no-cache-dir google-api-python-client \
    && : \
    && : clean up unneeded packages and files \
    && apk del .build-deps \
    && rm -f /usr/bin/bazel \
    && rm -rf /tmp/* /root/.cache

RUN jupyter notebook --generate-config \
    && sed -i -e "/c\.NotebookApp\.ip/a c.NotebookApp.ip = '*'" \
        -e "/c\.NotebookApp\.open_browser/a c.NotebookApp.open_browser = False" \
            /root/.jupyter/jupyter_notebook_config.py
RUN ipython profile create \
    && sed -i -e "/c\.InteractiveShellApp\.matplotlib/a c.InteractiveShellApp.matplotlib = 'inline'" \
            /root/.ipython/profile_default/ipython_config.py

ADD init.sh /usr/local/bin/init.sh
RUN chmod u+x /usr/local/bin/init.sh
EXPOSE 8888
CMD ["/usr/local/bin/init.sh"]

