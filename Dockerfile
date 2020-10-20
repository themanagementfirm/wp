FROM docker.io/bitnami/minideb:buster
LABEL maintainer "The Management Firm <git@tmf.network>"

ENV BITNAMI_PKG_CHMOD="-R g+rwX" \
  HOME="/" \
  PATH="/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/apache/bin:/opt/bitnami/wp-cli/bin:/opt/bitnami/mysql/bin:/opt/bitnami/common/bin:/opt/bitnami/nami/bin:$PATH"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages ca-certificates curl gzip libaudit1 libbsd0 libbz2-1.0 libc6 libcap-ng0 libcom-err2 libcurl4 libexpat1 libffi6 libfftw3-double3 libfontconfig1 libfreetype6 libgcc1 libgcrypt20 libglib2.0-0 libgmp10 libgnutls30 libgomp1 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu63 libidn2-0 libjemalloc2 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 liblcms2-2 libldap-2.4-2 liblqr-1-0 libltdl7 liblzma5 libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmcrypt4 libmemcached11 libmemcachedutil2 libncurses6 libnettle6 libnghttp2-14 libonig5 libp11-kit0 libpam0g libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5deb1 libtinfo6 libunistring2 libuuid1 libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 libxml2 libxslt1.1 libzip4 procps sudo tar unzip zlib1g
RUN /build/bitnami-user.sh
RUN /build/install-nami.sh
RUN bitnami-pkg install php-7.4.10-0 --checksum 30d4b2ec9156a8128d940c9aaf38b03f5e5649d98d1ab452059c2a2ecc7797eb
RUN bitnami-pkg unpack apache-2.4.46-0 --checksum 93181ed22488a04139fe2ab6d9ca1a81b142392e8c86675b1653a1f28c068fa9
RUN bitnami-pkg install wp-cli-2.4.0-0 --checksum 8095bdd2f96a137cb3f54836ad9deb90510b0927472e532f41e1708345432230
RUN bitnami-pkg unpack mysql-client-10.3.24-0 --checksum 94a7e3c58310f59af5c1e14544de0a42bd1ecf394a159db94aacf8ccf6058436
RUN bitnami-pkg install libphp-7.4.10-0 --checksum 2f0ef1f6c186a8372a3c48f0683893233e903eb7d2a1c93f593da342fe078cce
RUN bitnami-pkg unpack wordpress-5.5.1-1 --checksum 3852c13b4a75aaa2dae92f197d70a0c20185096f7b0d23875e0b540636a10ecc
RUN bitnami-pkg install tini-0.19.0-0 --checksum 9a8ae20be31a518f042fcec359f2cf35bfdb4e2a56f2fa8ff9ef2ecaf45da80c
RUN bitnami-pkg install gosu-1.12.0-1 --checksum 51cfb1b7fd7b05b8abd1df0278c698103a9b1a4964bdacd87ca1d5c01631d59c
RUN apt-get update && apt-get upgrade -y && \
  rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN ln -sf /dev/stdout /opt/bitnami/apache/logs/access_log && \
  ln -sf /dev/stderr /opt/bitnami/apache/logs/error_log

COPY rootfs /
RUN bash download-extra.sh
ENV ALLOW_EMPTY_PASSWORD="no" \
  APACHE_ENABLE_CUSTOM_PORTS="no" \
  APACHE_HTTPS_PORT_NUMBER="8443" \
  APACHE_HTTP_PORT_NUMBER="8080" \
  BITNAMI_APP_NAME="wordpress" \
  BITNAMI_IMAGE_VERSION="5.5.1-debian-10-r2" \
  MARIADB_HOST="mariadb" \
  MARIADB_PORT_NUMBER="3306" \
  MARIADB_ROOT_PASSWORD="" \
  MARIADB_ROOT_USER="root" \
  MYSQL_CLIENT_CREATE_DATABASE_NAME="" \
  MYSQL_CLIENT_CREATE_DATABASE_PASSWORD="" \
  MYSQL_CLIENT_CREATE_DATABASE_PRIVILEGES="ALL" \
  MYSQL_CLIENT_CREATE_DATABASE_USER="" \
  MYSQL_CLIENT_ENABLE_SSL="no" \
  MYSQL_CLIENT_SSL_CA_FILE="" \
  NAMI_PREFIX="/.nami" \
  OS_ARCH="amd64" \
  OS_FLAVOUR="debian-10" \
  OS_NAME="linux" \
  PHP_MEMORY_LIMIT="256M" \
  SMTP_HOST="" \
  SMTP_PASSWORD="" \
  SMTP_PORT="" \
  SMTP_PROTOCOL="" \
  SMTP_USER="" \
  SMTP_USERNAME="" \
  WORDPRESS_BLOG_NAME="User's Blog!" \
  WORDPRESS_DATABASE_NAME="themanagementfirm_wp" \
  WORDPRESS_DATABASE_PASSWORD="" \
  WORDPRESS_DATABASE_SSL_CA_FILE="" \
  WORDPRESS_DATABASE_USER="tmf_wp" \
  WORDPRESS_EMAIL="user@example.com" \
  WORDPRESS_EXTRA_WP_CONFIG_CONTENT="" \
  WORDPRESS_FIRST_NAME="FirstName" \
  WORDPRESS_HTACCESS_OVERRIDE_NONE="yes" \
  WORDPRESS_HTACCESS_PERSISTENCE_ENABLED="no" \
  WORDPRESS_HTTPS_PORT="8443" \
  WORDPRESS_HTTP_PORT="8080" \
  WORDPRESS_LAST_NAME="LastName" \
  WORDPRESS_PASSWORD="themanagementfirm" \
  WORDPRESS_RESET_DATA_PERMISSIONS="no" \
  WORDPRESS_SCHEME="http" \
  WORDPRESS_SKIP_INSTALL="no" \
  WORDPRESS_TABLE_PREFIX="wp_" \
  WORDPRESS_USERNAME="user"

EXPOSE 8080 8443
ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "httpd", "-f", "/opt/bitnami/apache/conf/httpd.conf", "-DFOREGROUND" ]
