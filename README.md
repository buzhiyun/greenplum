# greenplum
gpdb 单机镜像

---
- #### docker-compose.yml
  ```yaml
  version: '2'
  services:
    gpmaster:
      privileged: true
      container_name: gpdb-master
      build:
        context: .
        dockerfile: Dockerfile
      #image: gpdb:6.9-test
      ports:
        - "5432:5432"
      volumes:
        - ./gpdb-master/data:/data
        - ./gpdb-master/data1:/data1
        - ./gpdb-master/data2:/data2
      entrypoint: /usr/sbin/init 
  ```
