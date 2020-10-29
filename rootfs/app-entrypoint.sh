#!/bin/bash -e

. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

print_welcome_page

if [[ "$1" == "nami" && "$2" == "start" ]] || [[ "$1" == "httpd" ]]; then
    . /apache-init.sh
    . /wordpress-init.sh
    nami_initialize apache mysql-client wordpress
    info "Starting gosu... "
    . /post-init.sh
fi

nami_initialize apache php mysql-client wordpress

# Theme Activation
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp theme activate medizco-child'

# Plugin Activation
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate bbpress'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate contact-form-7'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate buddypress'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate leadin'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate mailpoet'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate woocommerce'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate eps-301-redirects'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate convertplug'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-custom-404'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-disqus-comments'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-email-forms'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate envira-gallery'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate essential-grid'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-facebook-comments'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-google-analytics'
# su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate LayerSlider'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate modern-events-calendar'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-olark-integration'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate revslider'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-smooth-scroll'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate snippet'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate soliloquy'
# su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate superfly-menu'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-terms-of-use'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate the-grid'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate ubermenu'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-under-construction'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-video-lock'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate js_composer'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-white-label'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-woo-checkout-editor'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate tco-content-dock'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate WP_Estimation_Form'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate advanced-custom-fields-pro'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate all-in-one-seo-pack'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate akismet'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate all-in-one-wp-migration'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate amp'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate contact-form-7-signature-addon'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate jetpack'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate loginpress'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate nomiddleman-crypto-payments-for-woocommerce'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate simple-tags'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate google-site-kit'
# su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate w3-total-cache'
# su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate woocommerce-gift-cards'
# su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate woocommerce-services'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate woocommerce-square'
# su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate wp-force-ssl'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp plugin activate intercom'
su daemon -s /bin/bash -c '/opt/bitnami/wp-cli/bin/wp theme activate medizco-essential'
info "Starting wordpress... "

exec tini -- "$@"