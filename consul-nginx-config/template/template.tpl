http {
  upstream app1 {
  {{range service "app1"}}
	server {{.Address}}:{{.Port}};
  {{end}}
  
 }

  server {
    listen 80;
    location /app1 {
      proxy_pass http://app1;
    }
  }  
}

