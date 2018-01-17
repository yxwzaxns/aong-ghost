# About this Repo

This is a project fork from [https://github.com/docker-library/ghost](https://github.com/docker-library/ghost)

It use the [qn-store](https://github.com/yxwzaxns/qn-store) to store the image

# How To Use

```
version: '2'
services:
  blog:
    build:
      context: .
      dockerfile: Dockerfile
    image: blog:dev
    ports:
     - "2368:2368"
    environment:
     - NODE_ENV=production
    volumes:
     - "host_path_save_content:/ghost/content"
```

#### TODO
In your config.js file, you'll need to add a new storage block to whichever environment you want to change:
```
storage: {
    active: 'qn-store',
    'qn-store': {
    accessKey: 'your AK',
    secretKey: 'your SK',
    bucket: 'your bucket name',
    origin: 'your storage url'
     }
},

```
# Example

This is a docker-compose.yml
```
version: '2'
services:
  blog:
    build:
      context: .
      dockerfile: Dockerfile
    image: blog:dev
    ports:
     - "2368"
    envrionment:
     - PROTO_TYPE=https
    volumes:
      - "/root/docker:/var/lib/ghost"
```
# License
