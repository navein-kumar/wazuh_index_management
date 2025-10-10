
#clear gz file--
0 * * * * { echo "==== $(date '+\%Y-\%m-\%d \%H:\%M:\%S') ===="; find /var/log/ /home/ubuntu/nginxproxy/ /var/ossec/logs/ -type f -name "*.gz" -delete -print; echo "Cleanup finished"; } >> /var/log/gz_cleanup.log 2>&1

#clear truncate unused file
*/30 * * * * cd /var/ossec/logs/alerts && find . -type f -name "ossec-alerts-*.json" -exec sh -c 'for f; do if ! lsof "$f" >/dev/null 2>&1; then s=$(du -h "$f" 2>/dev/null | cut -f1); echo "$(date "+\%Y-\%m-\%d \%H:\%M:\%S") - Truncated: $f ($s)" >> /var/log/wazuh-truncate.log; > "$f" 2>/dev/null; fi; done' _ {} +

#manager ossecc.conf add below line global section to rotate file
<global>
    <jsonout_output>yes</jsonout_output>
        <!-- Rotate when file reaches 5GB -->
    <max_output_size>5120M</max_output_size>
<global>

----
 cat /var/ossec/etc/local_internal_options.conf
 --
# local_internal_options.conf

# Enable compression immediately
monitord.compress=1

# Delete logs after 1 day (since already in dashboard)
monitord.keep_log_days=0

# Wait only 10 seconds before compressing
monitord.day_wait=10

# Enable rotation
monitord.rotate_log=1
    

    
