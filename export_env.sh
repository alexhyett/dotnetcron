#!/bin/bash

echo '#!/bin/bash' > /app/set_env.sh
printenv | sed '/^affinity:container/ d' | sed -r 's/^([a-zA-Z_]+[a-zA-Z0-9_-]*)=(.*)$/export \1="\2"/g' >> /app/set_env.sh
chmod +x /app/set_env.sh