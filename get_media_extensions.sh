curl -s 'http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types' | tail -n +16 | sed 's/^# //' | sed 's/\s\+/ /' | while read line; do
  application="$(echo "$line" | cut -d' ' -f1)"
  extensions="$(echo "$line" | cut -d' ' -f2- | sed 's/ /","/g')"
  if [[ "$application" == "$extensions" ]]; then
    echo "{\"type\":\"$(echo "$application" | cut -d'/' -f1)\",\"name\":\"$application\",\"extension\":[]}"
  else
    echo "{\"type\":\"$(echo "$application" | cut -d'/' -f1)\",\"name\":\"$application\",\"extension\":[\"$extensions\"]}"
  fi
done | sort | jq -s
