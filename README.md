# Description
This project is derived from the original project found [here](https://github.com/jrrdev/cve-2017-5638) and aims to demonstrate the [CVE-2017-5638](https://www.google.com/search?q=CVE-2017-5638&rlz=1C5CHFA_enUS940US940&oq=CVE-2017-5638&aqs=chrome..69i57.2371j0j1&sourceid=chrome&ie=UTF-8) exploitation found in vulnerable versions of Apache Struts.


### Build
1. Apache Struts application container image
   
   ```
   ./build.sh --registry <registry_name> --type app --push
   ```

2. Apache Struts exploit container image
   
   ```
   ./build.sh --registry <registry_name> --type exploit --push
   ```

### Run Apache Struts Application (Kubernetes)
1. In the `apache-struts.yaml` manifest file and update the`image` key to point to the `apache-struts-app` container image created in the previous setp. Update or delete `impagePullSecrets` as necessary.

2. Deploy the Apache Struts pods:
   
   ```
   kubectl apply -f 1-deployment.yaml
   ```
   
3. Deploy the Apache Struts service (external load balancer):
   
   ```
   kubectl apply -f 2-service.yaml
   ```

### Run Apache Struts Exploit (Docker)
1. To run the standard Apache Struts exploit, modify the `image`, `host`, `src_ip`, and `dst_ip` variables in the `run_exploit.sh` file for your requirements and run the shell script:
   
   ```
   ./run_exploit.sh
   ```
   
2. To run the reverse web shell Apache Struts exploit, modify the `image`, `host`, `port`, `src_ip`, and `src_port` variables in the `run_webshell.sh` file for your requirements and open the designated `src_port` on the exploit host using `netcat`:

   ```
   nc -lvp <src_port>
   ```
   
   On the same exploit host but in a new terminal window, run the shell script:
   
   ```
   ./run_webshell.sh
   ```
   
   Once the exploit has completed and the `GET` response has been returned, you should have full shell access to the host, pod, or container as `root` user.
