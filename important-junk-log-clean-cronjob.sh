# m h  dom mon dow   command
#restart isp
0 * * * * cd /home/ubuntu/nginxproxy/wazuh-misp-ioc && /usr/bin/docker-compose restart > /dev/null 2>&1

#delete gz file
0 * * * * find /var/log/ /home/ubuntu/nginxproxy/ /var/ossec/logs/ -type f -name "*.gz" -delete 2>/dev/null

#truncate unused files
*/30 * * * * cd /var/ossec/logs/alerts && find . -type f -name "ossec-alerts-*.json" -exec sh -c 'for f; do if ! lsof "$f" >/dev/null 2>&1; then s=$(du -h "$f" 2>/dev/null | cut -f1); echo "$(date "+\%Y-\%m-\%d \%H:\%M:\%S") - Truncated: $f ($s)" >> /var/log/wazuh-truncate.log; > "$f" 2>/dev/null; fi; done' _ {} +
