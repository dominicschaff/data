# Random Data

This repository is a collection of data that can be used as is for many projects.

The data is retrieved from many sources, and combined or reformatted.

All data should be in JSON, or at least as much as possible.

## Quick shortcuts

Some quick hints to get this data into a terminal environment. Shortcuts assume `cURL` and `jq` is installed.

```bash
# List all HTTP status codes:
curl -s 'https://raw.githubusercontent.com/dominicschaff/data/master/http_codes.json' | jq -r '.[] | .codes[] | "\(.code) : \(.name)"'

# Get Code Description:
code=401
curl -s 'https://raw.githubusercontent.com/dominicschaff/data/master/http_codes.json' | jq -r ".[] | .codes[] | select(.code == \"$code\") | \"\(.code) : \(.name)\n\n\(.description)\""
```

### Bash Functions for the above

Place this code in your `.bashrc` file to use the above from your terminal:

```bash
http_code()
{
  if [[ $# -eq 0 ]]; then
    echo -e "$(curl -s 'https://raw.githubusercontent.com/dominicschaff/data/master/http_codes.json' | jq -r '.[] | .codes[] | "\\e[36m\(.code)\\e[0m : \(.name)"')"
  else
    data="$(curl -s 'https://raw.githubusercontent.com/dominicschaff/data/master/http_codes.json')"
    for f in "$@"; do
      echo -e "$(echo "$data" | jq -r ".[] | .codes[] | select(.code == \"$f\") | \"\\\\e[36m\(.code) : \(.name)\\\\e[0m\n\n\(.description)\"")"
    done
  fi
}
```

## Sources:

* `get_media_extensions.sh` / `media_types.json` : <http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types>
* `http_codes.json` : <https://en.wikipedia.org/wiki/List_of_HTTP_status_codes>