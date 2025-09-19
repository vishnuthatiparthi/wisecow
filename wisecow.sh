#!/usr/bin/env bash
SRVPORT=4499

serve() {
    while true; do
        { 
            # Read and discard HTTP request headers until blank line
            while IFS= read -r line && [ "$line" != $'\r' ] && [ -n "$line" ]; do :; done
            # Generate fortune + cowsay output and wrap in HTTP response with styled <pre>
            fortune /usr/share/games/fortunes/custom | cowsay | \
            awk 'BEGIN { print "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r"
                         print "<pre style=\"font-family: monospace;\">"
                       }
                 { print $0 }
                 END { print "</pre>" }'
        } | nc -q 1 -l -p "$SRVPORT"
    done
}

echo "Wisdom served on port=$SRVPORT..."
serve