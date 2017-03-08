ProxyPass /unifi/ !
RedirectMatch 302 ^/unifi/(.*)$ http://{{IPV4ADDR}}:8080/$1
