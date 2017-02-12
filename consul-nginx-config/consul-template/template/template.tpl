{{ range services }}
upstream {{.Name}} {
  {{range service .Name}}
	server {{.Address}}:{{.Port}};
  {{end}}
}
{{end}}

server {
  listen 80;
{{ range services }}
  location /{{.Name}} {
    rewrite /{{.Name}}(.*) /$1  break;
    proxy_pass http://{{.Name}};
  }
{{end}}
}

