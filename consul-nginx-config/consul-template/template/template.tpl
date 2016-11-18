events {
	worker_connections 15;
	# multi_accept on;
}

http {
  upstream app1 {
  {{range service "app1"}}
	server {{.Address}}:{{.Port}};
  {{end}}
  
 }

  server {
    listen 80;
    location / {
      proxy_pass http://app1;
    }
  }  
}

