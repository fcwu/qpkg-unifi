ProxyPass /unifi/ !
RedirectMatch 301 ^/unifi/(.*)$ http://{{IPV4ADDR}}:8080/$1
